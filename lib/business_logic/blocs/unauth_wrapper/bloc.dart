import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'event.dart';
part 'state.dart';

class UnauthWrapperBloc extends Bloc<UnauthWrapperEvent, UnauthWrapperState> {
  UnauthWrapperBloc() : super(OnLoginScreen()) {
    on<NavigateToLoginScreen>((event, emit) async {
      emit(OnLoginScreen());
    });
    on<NavigateToForgotPasswordScreen>((event, emit) async {
      emit(OnForgotPasswordScreen());
    });
  }
}
