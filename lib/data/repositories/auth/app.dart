import 'dart:async';
import 'package:washpro/data/models/user.dart';
import 'package:washpro/temp.dart';

import 'base.dart';

class AppAuthRepository extends AuthRepository {
  final _controller = StreamController<AuthenticationStatus>();

  @override
  void dispose() => _controller.close();

  @override
  bool isSignedIn() {
    return currentUser != null;
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) {
    Future.delayed(const Duration(seconds: 2), () {
      currentUser = User(userId: "123", firstName: email, lastName: password);
      _controller.add(AuthenticationStatus.authenticated);
    });
    return Future.value();
  }

  @override
  Future<void> signInWithRefreshToken(Uri uri) {
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    Future.delayed(const Duration(seconds: 2), () {
      currentUser = null;
      _controller.add(AuthenticationStatus.unauthenticated);
    });
    return Future.value();
  }

  @override
  Future<String?> signUpWithEmailAndPassword(String email, String password) {
    throw UnimplementedError();
  }

  @override
  Stream<AuthenticationStatus> get status async* {
    final signedIn = isSignedIn();
    if (signedIn) {
      _controller.add(AuthenticationStatus.authenticated);
    } else {
      _controller.add(AuthenticationStatus.unauthenticated);
    }
    yield* _controller.stream;
  }

  @override
  Future<bool> userAlreadyExists({required String email}) {
    throw UnimplementedError();
  }
}
