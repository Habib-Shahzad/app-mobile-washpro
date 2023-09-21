part of 'bloc.dart';

abstract class AuthWrapperEvent extends Equatable {
  const AuthWrapperEvent();

  @override
  List<Object> get props => [];
}

class NavigateToPickFromCustomerScreen extends AuthWrapperEvent {}

class NavigateToHomeScreen extends AuthWrapperEvent {}

class NavigateToPickUpScreen extends AuthWrapperEvent {}
