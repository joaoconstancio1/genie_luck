import 'dart:convert';
import 'package:genie_luck/core/http_client/custom_http_client.dart';
import 'package:genie_luck/core/http_client/http_client_exception.dart';
import 'package:genie_luck/flavors.dart';
import 'package:genie_luck/core/models/user_model.dart';
import 'package:genie_luck/modules/register/data/models/cep_model.dart';

class RegisterDatasource {
  final CustomHttpClient client;

  RegisterDatasource(this.client);

  Future<UserModel> registerUser(UserModel? userModel) async {
    final url = '${F.baseUrl}/users/register';
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(userModel?.toJson());

    try {
      final response = await client.post(url, headers: headers, data: body);
      final result = UserModel.fromJson(response as Map<String, dynamic>);
      return result;
    } catch (e) {
      if (e is HttpClientException) {
        throw Exception('Erro na requisição: ${e.message}');
      } else {
        throw Exception('Erro inesperado: $e');
      }
    }
  }

  Future<CepModel> getCep(String cep) async {
    final url = 'https://viacep.com.br/ws/$cep/json/';
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await client.get(url, headers: headers);

      final result = CepModel.fromJson(response as Map<String, dynamic>);
      return result;
    } catch (e) {
      if (e is HttpClientException) {
        throw Exception('Erro na requisição: ${e.message}');
      } else {
        throw Exception('Erro inesperado: $e');
      }
    }
  }
}
