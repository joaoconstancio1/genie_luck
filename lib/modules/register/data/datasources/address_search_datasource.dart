// import 'dart:convert';

// import 'package:genie_luck/flavors/flavors.dart';
// import 'package:genie_luck/modules/register/data/models/address_details_model.dart';
// import 'package:genie_luck/modules/register/data/models/address_sugestions_model.dart';
// import 'package:http/http.dart' as http;

// class AddressSearchDatasource {
//   Future<List<AddressSuggestionModel>> searchPlaces(
//     String input,
//     String sessionToken,
//   ) async {
//     final url = Uri.parse(
//       '${F.baseUrl}/places/autocomplete?input=$input&sessiontoken=$sessionToken',
//     );
//     try {
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body) as Map<String, dynamic>;
//         final predictions = data['predictions'] as List<dynamic>;
//         return predictions
//             .map((json) => AddressSuggestionModel.fromJson(json))
//             .toList();
//       } else {
//         throw Exception('Erro na resposta do backend: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Erro ao buscar lugares via backend: $e');
//     }
//   }

//   Future<AddressDetailsModel?> getPlaceDetails(
//     String placeId,
//     String sessionToken,
//   ) async {
//     final url = Uri.parse(
//       '${F.baseUrl}/places/place-details?place_id=$placeId&sessiontoken=$sessionToken',
//     );
//     try {
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body) as Map<String, dynamic>;
//         if (data.containsKey('error')) {
//           throw Exception('Erro ao buscar detalhes: ${data['error']}');
//         }
//         return AddressDetailsModel.fromJson(data);
//       } else {
//         throw Exception('Erro na resposta do backend: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Erro ao buscar detalhes via backend: $e');
//     }
//   }
// }
