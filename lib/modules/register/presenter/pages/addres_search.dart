import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:genie_luck/modules/register/data/datasources/address_search_datasource.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddressPage extends StatefulWidget {
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final TextEditingController _controller = TextEditingController();
  List<Prediction> _predictions = [];
  String _sessionToken = const Uuid().v4();
  Map<String, String> _addressData = {};

  Future<void> _searchPlaces(String input) async {
    if (input.isEmpty) {
      setState(() => _predictions = []);
      return;
    }

    try {
      final predictions = await AddressSearchDatasource().searchPlaces(
        input,
        _sessionToken,
      );
      setState(
        () =>
            _predictions =
                predictions.map((e) => Prediction.fromJson(e)).toList(),
      );
    } catch (e) {
      print('Erro ao buscar lugares: $e');
      setState(() => _predictions = []);
    }
  }

  Future<void> _selectPlace(Prediction prediction) async {
    try {
      final details = await AddressSearchDatasource().getPlaceDetails(
        prediction.placeId ?? '',
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
                      title: Text(
                        prediction.description ?? 'Descrição indisponível',
                      ),
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
