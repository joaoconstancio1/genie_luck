import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genie_luck/modules/login/data/repositories/login_repository.dart';

import 'package:genie_luck/modules/login/presenter/cubit/login_states.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.repository}) : super(const LoginInitialState());

  final LoginRepository repository;

  Future<void> login({required String email, required String password}) async {
    emit(const LoginLoadingState());

    try {
      final result = await repository.login(email, password);
      result.fold(
        (s) => emit(LoginSuccessState(data: s)),
        (f) => emit(LoginErrorState((Exception(f)))),
      );
    } catch (error) {
      emit(LoginErrorState(Exception(error)));
    }
  }
}
