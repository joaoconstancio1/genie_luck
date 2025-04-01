import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genie_luck/register/data/repositories/register_repository.dart';
import 'package:genie_luck/register/presenter/cubit/register_states.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.repository) : super(const RegisterInitialState());

  final RegisterRepository repository;

  Future<void> init({
    required String fullName,
    required String email,
    required String password,
    required DateTime birthDate,
    required String phoneNumber,
    required String zipCode,
    required String address,
    required String addressNumber,
    required String city,
    required String state,
    required String country,
    required bool termsAccepted,
    required bool receivePromotions,
  }) async {
    emit(const RegisterLoadingState());

    try {
      final result = await repository.registerUser(
        fullName: fullName,
        email: email,
        password: password,
        birthDate: birthDate,
        phoneNumber: phoneNumber,
        zipCode: zipCode,
        address: address,
        addressNumber: addressNumber,
        city: city,
        state: state,
        country: country,
        termsAccepted: termsAccepted,
        receivePromotions: receivePromotions,
      );
      result.fold(
        (s) => emit(RegisterSuccessState(data: s)),
        (f) => emit(RegisterErrorState((Exception(f)))),
      );
    } catch (error) {
      emit(RegisterErrorState(Exception(error)));
    }
  }
}
