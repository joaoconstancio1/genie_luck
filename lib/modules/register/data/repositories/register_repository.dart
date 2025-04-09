import 'package:genie_luck/modules/register/data/datasources/register_datasource.dart';
import 'package:genie_luck/core/models/user_model.dart';
import 'package:result_dart/result_dart.dart';

class RegisterRepository {
  final RegisterDatasource datasource;

  RegisterRepository(this.datasource);

  Future<Result<UserModel>> registerUser(UserModel userModel) async {
    try {
      final result = await datasource.registerUser(userModel);

      return Success((result));
    } catch (e) {
      return Failure(Exception('Erro ao registrar usuário: $e'));
    }
  }
}
