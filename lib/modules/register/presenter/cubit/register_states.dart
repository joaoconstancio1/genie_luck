import 'package:equatable/equatable.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:genie_luck/core/models/user_model.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object?> get props => [];
}

class RegisterInitialState extends RegisterState {
  const RegisterInitialState();
}

class RegisterLoadingState extends RegisterState {
  const RegisterLoadingState();
}

class RegisterSuccessState extends RegisterState {
  final UserModel data;

  const RegisterSuccessState({required this.data});

  @override
  List<Object?> get props => [data];
}

class RegisterErrorState extends RegisterState {
  final Exception exception;

  const RegisterErrorState(this.exception);

  @override
  List<Object?> get props => [exception];
}

class SearchPlacesLoadingState extends RegisterState {
  const SearchPlacesLoadingState();
}

class SearchPlacesSuccessState extends RegisterState {
  final List<Prediction> predictions;

  const SearchPlacesSuccessState(this.predictions);

  @override
  List<Object?> get props => [predictions];
}

class SearchPlacesErrorState extends RegisterState {
  final String error;

  const SearchPlacesErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class PlaceDetailsLoadingState extends RegisterState {
  const PlaceDetailsLoadingState();
}

class PlaceDetailsSuccessState extends RegisterState {
  final Map<String, String> addressData;
  final String formattedAddress;

  const PlaceDetailsSuccessState({
    required this.addressData,
    required this.formattedAddress,
  });

  @override
  List<Object?> get props => [addressData, formattedAddress];
}

class PlaceDetailsErrorState extends RegisterState {
  final String error;

  const PlaceDetailsErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
