class AddressDetailsModel {
  final String? streetNumber;
  final String? street;
  final String? neighborhood;
  final String? city;
  final String? state;
  final String? country;
  final String? postalCode;
  final String? formattedAddress;
  final double? latitude;
  final double? longitude;

  AddressDetailsModel({
    this.streetNumber,
    this.street,
    this.neighborhood,
    this.city,
    this.state,
    this.country,
    this.postalCode,
    this.formattedAddress,
    this.latitude,
    this.longitude,
  });

  factory AddressDetailsModel.fromJson(Map<String, dynamic> json) {
    String? getComponent(List<dynamic> components, List<String> types) {
      for (var component in components) {
        final componentTypes = component['types'] as List<dynamic>;
        if (types.any((type) => componentTypes.contains(type))) {
          return component['long_name'] as String;
        }
      }
      return null;
    }

    final components = json['address_components'] as List<dynamic>? ?? [];
    final geometry = json['geometry']?['location'] as Map<String, dynamic>?;

    return AddressDetailsModel(
      streetNumber: getComponent(components, ['street_number']),
      street: getComponent(components, ['route']),
      neighborhood: getComponent(components, [
        'sublocality',
        'sublocality_level_1',
      ]),
      city: getComponent(components, ['administrative_area_level_2']),
      state: getComponent(components, ['administrative_area_level_1']),
      country: getComponent(components, ['country']),
      postalCode: getComponent(components, ['postal_code']),
      formattedAddress: json['formatted_address'] as String?,
      latitude: geometry != null ? (geometry['lat'] as num?)?.toDouble() : null,
      longitude:
          geometry != null ? (geometry['lng'] as num?)?.toDouble() : null,
    );
  }
}
