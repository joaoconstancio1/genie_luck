import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genie_luck/modules/register/data/repositories/register_repository.dart';
import 'package:genie_luck/modules/register/presenter/cubit/cep_state.dart';

class CepCubit extends Cubit<CepState> {
  final RegisterRepository repository;

  CepCubit({required this.repository}) : super(const CepInitialState());

  Future<void> fetchCepData(String cep) async {
    emit(const CepLoadingState());

    try {
      final result = await repository.fetchCepData(cep);
      result.fold(
        (s) => emit(CepSuccessState(cepData: s)),
        (f) => emit(CepErrorState(f.toString())),
      );
    } catch (error) {
      emit(CepErrorState(error.toString()));
    }
  }
}
