part of 'bloc.dart';

abstract class AuthWrapperEvent extends Equatable {
  const AuthWrapperEvent();

  @override
  List<Object> get props => [];
}

class NavigateToNavigatorScreen extends AuthWrapperEvent {}