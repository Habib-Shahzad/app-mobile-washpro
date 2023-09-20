import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'event.dart';
part 'state.dart';

class AuthWrapperBloc extends Bloc<AuthWrapperEvent, AuthWrapperState> {
  AuthWrapperBloc() : super(OnHomeScreen()) {
    on<NavigateToHomeScreen>((event, emit) {
      emit(OnHomeScreen());
    });
    on<NavigateToPickFromCustomerScreen>((event, emit) async {
      emit(OnPickFromCustomerScreen());
    });
  }
}
