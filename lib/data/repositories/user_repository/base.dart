import 'package:washpro/data/models/user.dart';



abstract class UserRepository {
  Future<void> getUser();
  Stream<User> get loggedInUser;
  void dispose();
}
