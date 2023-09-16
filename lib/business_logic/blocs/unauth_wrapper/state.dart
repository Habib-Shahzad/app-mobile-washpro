part of 'bloc.dart';

abstract class UnauthWrapperState extends Equatable {
  const UnauthWrapperState();

  @override
  List<Object> get props => [];
}

class OnLoginScreen extends UnauthWrapperState {}

class OnForgotPasswordScreen extends UnauthWrapperState {}
