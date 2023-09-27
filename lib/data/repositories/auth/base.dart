enum AuthenticationStatus { unknown, authenticated, unauthenticated }

abstract class AuthRepository {
  Stream<AuthenticationStatus> get status;
  Future<void> signIn(String username, String password);
  Future<void> signOut();
  Future<bool> isSignedIn();
  void dispose();
}
