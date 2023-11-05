import 'dart:async';
import 'package:washpro/data/exceptions/auth.dart';
import 'package:washpro/data/models/api/auth/model.dart';
import 'package:washpro/logger.dart';
import 'package:washpro/services/preferences.dart';
import 'package:washpro/services/retrofit/client.dart';
import 'package:washpro/singletons.dart';

import 'base.dart';

class AppAuthRepository extends AuthRepository {
  final _controller = StreamController<AuthenticationStatus>();

  @override
  void dispose() => _controller.close();

  @override
  Future<bool> isSignedIn() async {
    final accessToken =
        SharedPreferencesService.get(PreferenceKeys.accessToken);
    final refreshToken =
        SharedPreferencesService.get(PreferenceKeys.refreshToken);

    if (accessToken != null &&
        accessToken.isNotEmpty &&
        refreshToken != null &&
        refreshToken.isNotEmpty) {
      try {
        final client = getIt<RestClient>();
        final response = await client.verify({
          'token': accessToken,
        });

        return response.response.statusCode == 200;
      } catch (e) {
        logger.e(e.toString());
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Future<void> signIn(String username, String password) async {
    Map<String, String> input = {'username': username, 'password': password};

    try {
      final client = getIt<RestClient>();
      AuthToken auth = await client.signIn(input);
      SharedPreferencesService.set(PreferenceKeys.accessToken, auth.access);
      SharedPreferencesService.set(PreferenceKeys.refreshToken, auth.refresh);
      _controller.add(AuthenticationStatus.authenticated);
    } catch (e) {
      logger.e(e.toString());
      throw AuthException("Invalid username or password");
    }
  }

  @override
  Future<void> signOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
    SharedPreferencesService.remove(PreferenceKeys.accessToken);
    SharedPreferencesService.remove(PreferenceKeys.refreshToken);
    return Future.value();
  }

  @override
  Stream<AuthenticationStatus> get status async* {
    final signedIn = await isSignedIn();
    if (signedIn) {
      _controller.add(AuthenticationStatus.authenticated);
    } else {
      _controller.add(AuthenticationStatus.unauthenticated);
    }
    yield* _controller.stream;
  }
}
