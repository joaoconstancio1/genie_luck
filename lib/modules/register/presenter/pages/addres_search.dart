import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Prediction {
  final String description;
  final String placeId;

  Prediction({required this.description, required this.placeId});

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      description: json['description'] as String,
      placeId: json['place_id'] as String,
    );
  }
}

class PlacesService {
  final GoogleMapsPlaces _places;
  final String _backendUrl =
      'http://localhost:5050/places'; // URL do backend Flask

  PlacesService(String apiKey) : _places = GoogleMapsPlaces(apiKey: apiKey);

  Future<List<Prediction>> searchPlaces(
    String input,
    String sessionToken,
  ) async {
    if (kIsWeb) {
      // Chamar o backend no Flutter Web
      final url = Uri.parse(
        '$_backendUrl/autocomplete?input=$input&sessiontoken=$sessionToken',
      );
      try {
        final response = await http.get(url);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body) as Map<String, dynamic>;
          final predictions =
              (data['predictions'] as List<dynamic>)
                  .map((p) => Prediction.fromJson(p))
                  .toList();
          return predictions;
        } else {
          print('Erro na resposta do backend: ${response.statusCode}');
          return [];
        }
      } catch (e) {
        print('Erro ao buscar lugares via backend: $e');
        return [];
      }
    } else {
      // Usar flutter_google_maps_webservices no Android/iOS
      try {
        final response = await _places.autocomplete(
          input,
          sessionToken: sessionToken,
          language: 'pt-BR',
          types: ['address'],
        );

        if (response.isOkay) {
          return response.predictions
              .map(
                (p) => Prediction(
                  description: p.description ?? '',
                  placeId: p.placeId ?? '',
                ),
              )
              .toList();
        } else {
          print('Erro na API: ${response.errorMessage}');
          return [];
        }
      } catch (e) {
        print('Erro ao buscar lugares: $e');
        return [];
      }
    }
  }

  Future<Map<String, dynamic>?> getPlaceDetails(
    String placeId,
    String sessionToken,
  ) async {
    if (kIsWeb) {
      // Chamar o backend no Flutter Web
      final url = Uri.parse(
        '$_backendUrl/place-details?place_id=$placeId&sessiontoken=$sessionToken',
      );
      try {
        final response = await http.get(url);
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body) as Map<String, dynamic>;
          if (data.containsKey('error')) {
            print('Erro ao buscar detalhes: ${data['error']}');
            return null;
          }
          return data;
        } else {
          print('Erro na resposta do backend: ${response.statusCode}');
          return null;
        }
      } catch (e) {
        print('Erro ao buscar detalhes via backend: $e');
        return null;
      }
    } else {
      // Usar flutter_google_maps_webservices no Android/iOS
      try {
        final details = await _places.getDetailsByPlaceId(
          placeId,
          sessionToken: sessionToken,
        );
        if (details.isOkay) {
          return {
            'formatted_address': details.result.formattedAddress,
            'address_components':
                details.result.addressComponents
                    .map(
                      (c) => {
                        'long_name': c.longName,
                        'short_name': c.shortName,
                        'types': c.types,
                      },
                    )
                    .toList(),
          };
        } else {
          print('Erro ao buscar detalhes: ${details.errorMessage}');
          return null;
        }
      } catch (e) {
        print('Erro ao buscar detalhes: $e');
        return null;
      }
    }
  }
}

class AddressPage extends StatefulWidget {
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final TextEditingController _controller = TextEditingController();
  final PlacesService _placesService = PlacesService(
    'SUA_CHAVE_API_AQUI',
  ); // Substitua pela sua chave
  List<Prediction> _predictions = [];
  String _sessionToken = const Uuid().v4();
  Map<String, String> _addressData = {};

  Future<void> _searchPlaces(String input) async {
    if (input.isEmpty) {
      setState(() => _predictions = []);
      return;
    }

    try {
      final predictions = await _placesService.searchPlaces(
        input,
        _sessionToken,
      );
      setState(() => _predictions = predictions);
    } catch (e) {
      print('Erro ao buscar lugares: $e');
      setState(() => _predictions = []);
    }
  }

  Future<void> _selectPlace(Prediction prediction) async {
    try {
      final details = await _placesService.getPlaceDetails(
        prediction.placeId,
        _sessionToken,
      );
      if (details == null) {
        print('Nenhum detalhe retornado para o lugar selecionado');
        return;
      }

      final addressComponents = details['address_components'] as List<dynamic>;
      Map<String, String> addressData = {
        'street': '',
        'city': '',
        'state': '',
        'country': '',
        'postalCode': '',
        'fullAddress': details['formatted_address'] ?? '',
      };

      for (var component in addressComponents) {
        final types = component['types'] as List<dynamic>;
        if (types.contains('route')) {
          addressData['street'] = component['long_name'] as String;
        }
        if (types.contains('locality')) {
          addressData['city'] = component['long_name'] as String;
        }
        if (types.contains('administrative_area_level_1')) {
          addressData['state'] = component['short_name'] as String;
        }
        if (types.contains('country')) {
          addressData['country'] = component['long_name'] as String;
        }
        if (types.contains('postal_code')) {
          addressData['postalCode'] = component['long_name'] as String;
        }
      }

      setState(() {
        _addressData = addressData;
        _controller.text = details['formatted_address'] ?? '';
        _predictions = [];
        _sessionToken = const Uuid().v4();
      });
    } catch (e) {
      print('Erro ao buscar detalhes do lugar: $e');
    }
  }

  Widget _buildAddressInfo() {
    if (_addressData.isEmpty) {
      return SizedBox.shrink();
    }

    return Card(
      elevation: 2,
      margin: EdgeInsets.only(top: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detalhes do Endereço',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _buildInfoRow('Endereço Completo', _addressData['fullAddress']),
            _buildInfoRow('Rua', _addressData['street']),
            _buildInfoRow('Cidade', _addressData['city']),
            _buildInfoRow('Estado', _addressData['state']),
            _buildInfoRow('País', _addressData['country']),
            _buildInfoRow('CEP', _addressData['postalCode']),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    if (value == null || value.isEmpty) return SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Busca de Endereço'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Digite o endereço',
                prefixIcon: Icon(Icons.location_on, color: Colors.blue),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(vertical: 0),
              ),
              onChanged: (value) => _searchPlaces(value),
            ),
            if (_predictions.isNotEmpty)
              Container(
                constraints: BoxConstraints(maxHeight: 200),
                margin: EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _predictions.length,
                  itemBuilder: (context, index) {
                    final prediction = _predictions[index];
                    return ListTile(
                      title: Text(prediction.description),
                      onTap: () => _selectPlace(prediction),
                    );
                  },
                ),
              ),
            _buildAddressInfo(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
