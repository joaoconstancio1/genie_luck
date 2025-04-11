import 'dart:convert';
import 'package:http/http.dart' as http;

class AddressSearchDatasource {
  final String _backendUrl =
      'http://localhost:5050/places'; // URL do backend Flask

  Future<List<Map<String, dynamic>>> searchPlaces(
    String input,
    String sessionToken,
  ) async {
    final url = Uri.parse(
      '$_backendUrl/autocomplete?input=$input&sessiontoken=$sessionToken',
    );
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return (data['predictions'] as List<dynamic>)
            .cast<Map<String, dynamic>>();
      } else {
        throw Exception('Erro na resposta do backend: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao buscar lugares via backend: $e');
    }
  }

  Future<Map<String, dynamic>?> getPlaceDetails(
    String placeId,
    String sessionToken,
  ) async {
    final url = Uri.parse(
      '$_backendUrl/place-details?place_id=$placeId&sessiontoken=$sessionToken',
    );
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        if (data.containsKey('error')) {
          throw Exception('Erro ao buscar detalhes: ${data['error']}');
        }
        return data;
      } else {
        throw Exception('Erro na resposta do backend: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao buscar detalhes via backend: $e');
    }
  }
}
