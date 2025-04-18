import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genie_luck/core/models/user_model.dart';
import 'package:genie_luck/modules/register/data/repositories/register_repository.dart';
import 'package:genie_luck/modules/register/presenter/cubit/register_states.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required this.repository})
    : super(const RegisterInitialState());

  final RegisterRepository repository;

  Future<void> registerUser(UserModel userModel) async {
    emit(const RegisterLoadingState());

    try {
      final result = await repository.registerUser(userModel);
      result.fold(
        (s) => emit(RegisterSuccessState(data: s)),
        (f) => emit(RegisterErrorState((Exception(f)))),
      );
    } catch (error) {
      emit(RegisterErrorState(Exception(error)));
    }
  }

  // Future<List<Map<String, dynamic>>> searchPlaces(
  //   String input,
  //   String sessionToken,
  // ) async {
  //   try {
  //     final result = await repository.searchPlaces(input, sessionToken);
  //     return result.fold((s) => s, (f) => throw Exception(f));
  //   } catch (error) {
  //     throw Exception(error);
  //   }
  // }

  // Future<Map<String, dynamic>> getPlaceDetails(
  //   String placeId,
  //   String sessionToken,
  // ) async {
  //   try {
  //     final result = await repository.getPlaceDetails(placeId, sessionToken);
  //     return result.fold((s) => s, (f) => throw Exception(f));
  //   } catch (error) {
  //     throw Exception(error);
  //   }
  // }
}
