import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'event.dart';
part 'state.dart';

class AuthWrapperBloc extends Bloc<AuthWrapperEvent, AuthWrapperState> {
  AuthWrapperBloc() : super(OnNavigatorScreen()){
    on<NavigateToNavigatorScreen>((event,emit){
      emit(OnNavigatorScreen());
    });
  }

}
