import 'package:genie_luck/modules/register/data/models/cep_model.dart';

abstract class CepState {
  const CepState();
}

class CepInitialState extends CepState {
  const CepInitialState();
}

class CepLoadingState extends CepState {
  const CepLoadingState();
}

class CepSuccessState extends CepState {
  final CepModel cepData;

  const CepSuccessState({required this.cepData});
}

class CepErrorState extends CepState {
  final String error;

  const CepErrorState(this.error);
}
