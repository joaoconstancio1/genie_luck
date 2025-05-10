class AddressSuggestionModel {
  final String placeId;
  final String description;
  final String? secondaryText;

  AddressSuggestionModel({
    required this.placeId,
    required this.description,
    this.secondaryText,
  });

  factory AddressSuggestionModel.fromJson(Map<String, dynamic> json) {
    return AddressSuggestionModel(
      placeId: json['place_id'] as String,
      description: json['description'] as String,
      secondaryText:
          json['structured_formatting']?['secondary_text'] as String?,
    );
  }
}
