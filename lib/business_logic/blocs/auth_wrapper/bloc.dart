import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'event.dart';
part 'state.dart';

AuthWrapperState defaultScreen = OnHomeScreen();

class AuthWrapperBloc extends Bloc<AuthWrapperEvent, AuthWrapperState> {
  AuthWrapperBloc() : super(defaultScreen) {
    on<NavigateToHomeScreen>((event, emit) {
      emit(OnHomeScreen());
    });
    on<NavigateToPickFromCustomerScreen>((event, emit) async {
      emit(OnPickFromCustomerScreen());
    });
    on<NavigateToPickUpScreen>((event, emit) async {
      emit(OnPickUpScreen());
    });
  }
}
