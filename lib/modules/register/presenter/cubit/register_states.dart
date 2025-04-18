import 'package:equatable/equatable.dart';
import 'package:genie_luck/core/models/user_model.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();
  @override
  List<Object?> get props => [];
}

final class RegisterInitialState extends RegisterState {
  const RegisterInitialState();
}

final class RegisterLoadingState extends RegisterState {
  const RegisterLoadingState();
}

final class RegisterErrorState extends RegisterState {
  final Exception exception;

  const RegisterErrorState(this.exception);
}

final class RegisterSuccessState extends RegisterState {
  const RegisterSuccessState({required this.data});

  final UserModel data;

  @override
  List<Object?> get props => [data];
}
