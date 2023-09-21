part of 'bloc.dart';

abstract class AuthWrapperState extends Equatable {
  const AuthWrapperState();

  @override
  List<Object> get props => [];
}

class OnHomeScreen extends AuthWrapperState {}

class OnPickFromCustomerScreen extends AuthWrapperState {}

class OnPickUpScreen extends AuthWrapperState {}
