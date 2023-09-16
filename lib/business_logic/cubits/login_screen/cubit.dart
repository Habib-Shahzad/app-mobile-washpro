import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:washpro/data/exceptions/auth.dart';
import 'package:washpro/data/repositories/auth/base.dart';
import 'package:washpro/logger.dart';

part 'state.dart';

class LoginScreenCubit extends Cubit<LoginScreenState> {
  final AuthRepository _authRepository;
  LoginScreenCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(LoginScreenInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginScreenLoading());
    try {
      await _authRepository.signInWithEmailAndPassword(email, password);
      logger.i('User Signed in successfully');
    } on AuthException catch (e) {
      emit(LoginScreenError(errorMessage: e.message));
    } catch (e) {
      logger.e(e);
      emit(const LoginScreenError(errorMessage: "Something went wrong!"));
    }
  }
}
