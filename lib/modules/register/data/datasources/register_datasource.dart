import 'dart:convert';
import 'package:genie_luck/core/http_client/custom_http_client.dart';
import 'package:genie_luck/core/http_client/http_client_exception.dart';
import 'package:genie_luck/flavors/flavors.dart';
import 'package:genie_luck/core/models/user_model.dart';
import 'package:genie_luck/modules/register/data/models/address_details_model.dart';
import 'package:genie_luck/modules/register/data/models/address_sugestions_model.dart';

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

  Future<List<AddressSuggestionModel>> searchPlaces(
    String input,
    String sessionToken,
  ) async {
    final url =
        '${F.baseUrl}/places/autocomplete?input=$input&sessiontoken=$sessionToken';
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await client.get(url, headers: headers);
      final data = response as Map<String, dynamic>;
      final predictions = data['predictions'] as List<dynamic>;
      return predictions
          .map((json) => AddressSuggestionModel.fromJson(json))
          .toList();
    } catch (e) {
      if (e is HttpClientException) {
        throw Exception('Erro na requisição: ${e.message}');
      } else {
        throw Exception('Erro ao buscar lugares: $e');
      }
    }
  }

  Future<AddressDetailsModel> getPlaceDetails(
    String placeId,
    String sessionToken,
  ) async {
    final url =
        '${F.baseUrl}/places/place-details?place_id=$placeId&sessiontoken=$sessionToken';
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await client.get(url, headers: headers);
      final data = response as Map<String, dynamic>;
      if (data.containsKey('error')) {
        throw Exception('Erro ao buscar detalhes: ${data['error']}');
      }
      return AddressDetailsModel.fromJson(data);
    } catch (e) {
      if (e is HttpClientException) {
        throw Exception('Erro na requisição: ${e.message}');
      } else {
        throw Exception('Erro ao buscar detalhes: $e');
      }
    }
  }
}
