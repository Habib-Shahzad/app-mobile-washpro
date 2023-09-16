part of 'cubit.dart';

abstract class ForgotPasswordScreenState extends Equatable {
  const ForgotPasswordScreenState();

  @override
  List<Object> get props => [];
}

class ForgotPasswordRequestSent extends ForgotPasswordScreenState {}

class ForgotPasswordRequestSending extends ForgotPasswordScreenState {}

class ForgotPasswordScreenError extends ForgotPasswordScreenState {
  final String errorMessage;

  const ForgotPasswordScreenError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
