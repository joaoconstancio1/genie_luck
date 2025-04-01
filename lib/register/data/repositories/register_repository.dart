import 'package:genie_luck/register/data/datasources/register_datasource.dart';
import 'package:genie_luck/register/data/models/user_model.dart';
import 'package:result_dart/result_dart.dart';

class RegisterRepository {
  final RegisterDatasource datasource;

  RegisterRepository(this.datasource);

  Future<Result<UserModel>> registerUser({
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
    try {
      final result = await datasource.registerUser(
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

      return Success((result));
    } catch (e) {
      return Failure(Exception('Erro ao registrar usuário: $e'));
    }
  }
}
