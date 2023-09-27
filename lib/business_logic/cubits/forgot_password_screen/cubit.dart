import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:washpro/data/exceptions/auth.dart';
import 'package:washpro/data/repositories/auth/base.dart';

part 'state.dart';

class ForgotPasswordScreenCubit extends Cubit<ForgotPasswordScreenState> {
  // ignore: unused_field
  final AuthRepository _authRepository;

  ForgotPasswordScreenCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(ForgotPasswordRequestSent());

  Future<void> sendForgotPasswordRequest(String email) async {
    emit(ForgotPasswordRequestSending());
    try {
      emit(ForgotPasswordRequestSent());
    } on AuthException catch (e) {
      emit(ForgotPasswordScreenError(errorMessage: e.message));
    } catch (e) {
      emit(const ForgotPasswordScreenError(
          errorMessage: "Something went wrong!"));
    }
  }
}
