import 'package:washpro/data/models/user.dart';

abstract class UserRepository {
  Future<void> getUser();
  Future<void> createNewUser(
      {required Map<String, dynamic> user, required String uuid});
  Stream<User> get loggedInUser;
  void dispose();
}
