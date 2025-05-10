import 'package:equatable/equatable.dart';
import 'package:genie_luck/modules/register/data/models/address_details_model.dart';
import 'package:genie_luck/modules/register/data/models/address_sugestions_model.dart';

abstract class AddressSearchState extends Equatable {
  const AddressSearchState();

  @override
  List<Object?> get props => [];
}

class AddressSearchInitialState extends AddressSearchState {
  const AddressSearchInitialState();
}

class AddressSearchLoadingState extends AddressSearchState {
  const AddressSearchLoadingState();
}

class AddressSearchSuggestionsState extends AddressSearchState {
  final List<AddressSuggestionModel> suggestions;

  const AddressSearchSuggestionsState({required this.suggestions});

  @override
  List<Object?> get props => [suggestions];
}

class AddressSearchDetailsState extends AddressSearchState {
  final AddressDetailsModel details;

  const AddressSearchDetailsState({required this.details});

  @override
  List<Object?> get props => [details];
}

class AddressSearchErrorState extends AddressSearchState {
  final Exception error;

  const AddressSearchErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
