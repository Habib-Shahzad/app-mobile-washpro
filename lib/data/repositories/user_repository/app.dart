import 'dart:async';
import 'package:washpro/data/models/user.dart';
import 'package:rxdart/rxdart.dart';
import 'package:washpro/temp.dart';
import 'base.dart';

class AppUserRepository extends UserRepository {
  final BehaviorSubject<User> _userStreamController = BehaviorSubject<User>();

  @override
  void dispose() => _userStreamController.close();

  @override
  Future<void> createNewUser(
      {required Map<String, dynamic> user, required String uuid}) {
    throw UnimplementedError();
  }

  @override
  Future<void> getUser() async {
    Future.delayed(const Duration(seconds: 1), () {});
    if (currentUser != null) _userStreamController.add(currentUser!);
  }

  @override
  Stream<User> get loggedInUser =>
      _userStreamController.stream.asBroadcastStream();
}
