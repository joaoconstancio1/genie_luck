import 'dart:convert';

import 'package:genie_luck/core/http_client/custom_http_client.dart';
import 'package:genie_luck/register/data/models/user_model.dart';

class RegisterDatasource {
  final CustomHttpClient client;

  RegisterDatasource(this.client);

  Future<UserModel> registerUser({
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
    final url = 'http://localhost:5000/users/register';
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'full_name': fullName,
      'email': email,
      'password': password,
      'birth_date': birthDate.toIso8601String(),
      'phone_number': phoneNumber,
      'zip_code': zipCode,
      'address': address,
      'address_number': addressNumber,
      'city': city,
      'state': state,
      'country': country,
      'terms_accepted': termsAccepted,
      'receive_promotions': receivePromotions,
    });

    try {
      final result = await client.post(url, headers: headers, data: body);
      return result;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
