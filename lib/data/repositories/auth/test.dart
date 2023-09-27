import 'dart:async';
import 'package:washpro/data/models/user.dart';
import 'package:washpro/data/repositories/user_repository/test.dart';

import 'base.dart';

class TestAuthRepository extends AuthRepository {
  final _controller = StreamController<AuthenticationStatus>();

  @override
  void dispose() => _controller.close();

  @override
  Future<bool> isSignedIn() async {
    return currentUser != null;
  }

  @override
  Future<void> signIn(String username, String password) {
    Future.delayed(const Duration(microseconds: 500), () {
      currentUser = User(userId: "123", firstName: "John", lastName: password);
      _controller.add(AuthenticationStatus.authenticated);
    });
    return Future.value();
  }

  @override
  Future<void> signOut() {
    Future.delayed(const Duration(microseconds: 500), () {
      currentUser = null;
      _controller.add(AuthenticationStatus.unauthenticated);
    });
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
