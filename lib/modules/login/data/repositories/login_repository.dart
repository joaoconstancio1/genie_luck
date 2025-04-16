import 'package:genie_luck/core/models/user_model.dart';
import 'package:genie_luck/modules/login/data/datasources/login_datasource.dart';
import 'package:result_dart/result_dart.dart';

class LoginRepository {
  final LoginDatasource datasource;

  LoginRepository(this.datasource);

  Future<Result<UserModel>> login(String email, String password) async {
    try {
      final result = await datasource.login(email, password);

      return Success((result));
    } catch (e) {
      return Failure(Exception('Erro ao registrar usuário: $e'));
    }
  }
}
