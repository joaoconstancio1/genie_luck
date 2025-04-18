import 'package:equatable/equatable.dart';
import 'package:genie_luck/core/models/user_model.dart';

sealed class LoginState extends Equatable {
  const LoginState();
  @override
  List<Object?> get props => [];
}

final class LoginInitialState extends LoginState {
  const LoginInitialState();
}

final class LoginLoadingState extends LoginState {
  const LoginLoadingState();
}

final class LoginErrorState extends LoginState {
  final Exception exception;

  const LoginErrorState(this.exception);
}

final class LoginSuccessState extends LoginState {
  const LoginSuccessState({required this.data});

  final UserModel data;

  @override
  List<Object?> get props => [data];
}
