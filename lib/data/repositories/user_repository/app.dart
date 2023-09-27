import 'dart:async';
import 'package:washpro/data/models/user.dart';
import 'package:rxdart/rxdart.dart';
import 'package:washpro/data/repositories/user_repository/test.dart';
import 'base.dart';

class AppUserRepository extends UserRepository {
  final BehaviorSubject<User> _userStreamController = BehaviorSubject<User>();

  @override
  void dispose() => _userStreamController.close();

  @override
  Future<void> getUser() async {
    if (currentUser != null) _userStreamController.add(currentUser!);
  }

  @override
  Stream<User> get loggedInUser =>
      _userStreamController.stream.asBroadcastStream();
}
