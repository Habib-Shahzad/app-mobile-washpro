import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? userId;
  final String firstName;
  final String lastName;

  const User({
    this.userId,
    required this.firstName,
    required this.lastName,
  });

  @override
  List<Object?> get props => [
        userId,
        firstName,
        lastName,
      ];

  static const empty = User(
    firstName: '-',
    lastName: '-',
    userId: '-',
  );
}
