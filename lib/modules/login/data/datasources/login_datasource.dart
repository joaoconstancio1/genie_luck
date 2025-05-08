import 'dart:convert';

import 'package:genie_luck/core/http_client/custom_http_client.dart';
import 'package:genie_luck/core/http_client/http_client_exception.dart';
import 'package:genie_luck/core/models/user_model.dart';
import 'package:genie_luck/flavors/flavors.dart';

class LoginDatasource {
  final CustomHttpClient client;

  LoginDatasource(this.client);

  Future<UserModel> login(String email, String password) async {
    final url = '${F.baseUrl}/users/login';
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'email': email, 'password': password});

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
}
