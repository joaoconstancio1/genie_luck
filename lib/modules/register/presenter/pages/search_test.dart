import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:genie_luck/modules/register/data/datasources/address_search_datasource.dart';
import 'package:genie_luck/modules/register/data/models/address_details_model.dart';
import 'package:genie_luck/modules/register/data/models/address_sugestions_model.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:genie_luck/flavors/flavors.dart'; // Assuming this is your flavor config

class AddressSearchScreen extends StatefulWidget {
  const AddressSearchScreen({Key? key}) : super(key: key);

  @override
  _AddressSearchScreenState createState() => _AddressSearchScreenState();
}

class _AddressSearchScreenState extends State<AddressSearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final AddressSearchDatasource _datasource = AddressSearchDatasource();
  final String _sessionToken = const Uuid().v4();
  List<AddressSuggestionModel> _suggestions = [];
  AddressDetailsModel? _selectedPlaceDetails;
  bool _isLoading = false;
  String? _errorMessage;

  void _searchPlaces(String input) async {
    if (input.isEmpty) {
      setState(() {
        _suggestions = [];
        _errorMessage = null;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final results = await _datasource.searchPlaces(input, _sessionToken);
      setState(() {
        _suggestions = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  void _fetchPlaceDetails(String placeId) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final details = await _datasource.getPlaceDetails(placeId, _sessionToken);
      setState(() {
        _selectedPlaceDetails = details;
        _suggestions = [];
        _isLoading = false;
        _controller.clear();
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  // Helper to display address field
  Widget _buildAddressField(String label, String? value) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value, style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Address')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter address',
                border: OutlineInputBorder(),
                hintText: 'Type to search places...',
              ),
              onChanged: _searchPlaces,
            ),
            const SizedBox(height: 16),
            if (_isLoading) const Center(child: CircularProgressIndicator()),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
            if (_suggestions.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _suggestions.length,
                  itemBuilder: (context, index) {
                    final suggestion = _suggestions[index];
                    return ListTile(
                      title: Text(suggestion.description),
                      subtitle:
                          suggestion.secondaryText != null
                              ? Text(suggestion.secondaryText!)
                              : null,
                      onTap: () {
                        _fetchPlaceDetails(suggestion.placeId);
                      },
                    );
                  },
                ),
              ),
            if (_selectedPlaceDetails != null) ...[
              const SizedBox(height: 16),
              const Text(
                'Address Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView(
                  children: [
                    _buildAddressField(
                      'Street Number',
                      _selectedPlaceDetails!.streetNumber,
                    ),
                    _buildAddressField('Street', _selectedPlaceDetails!.street),
                    _buildAddressField(
                      'Neighborhood',
                      _selectedPlaceDetails!.neighborhood,
                    ),
                    _buildAddressField('City', _selectedPlaceDetails!.city),
                    _buildAddressField('State', _selectedPlaceDetails!.state),
                    _buildAddressField(
                      'Country',
                      _selectedPlaceDetails!.country,
                    ),
                    _buildAddressField(
                      'Postal Code',
                      _selectedPlaceDetails!.postalCode,
                    ),
                    _buildAddressField(
                      'Formatted Address',
                      _selectedPlaceDetails!.formattedAddress,
                    ),
                    _buildAddressField(
                      'Latitude',
                      _selectedPlaceDetails!.latitude?.toString(),
                    ),
                    _buildAddressField(
                      'Longitude',
                      _selectedPlaceDetails!.longitude?.toString(),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
