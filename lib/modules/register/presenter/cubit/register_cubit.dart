import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:genie_luck/core/models/user_model.dart';
import 'package:genie_luck/modules/register/data/repositories/register_repository.dart';
import 'package:genie_luck/modules/register/presenter/cubit/register_states.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required this.repository})
    : super(const RegisterInitialState());

  final RegisterRepository repository;

  Future<void> registerUser(UserModel userModel) async {
    emit(const RegisterLoadingState());

    try {
      final result = await repository.registerUser(userModel);
      result.fold(
        (s) => emit(RegisterSuccessState(data: s)),
        (f) => emit(RegisterErrorState(Exception(f))),
      );
    } catch (error) {
      emit(RegisterErrorState(Exception(error.toString())));
    }
  }

  Future<void> searchPlaces(String input, String sessionToken) async {
    if (input.isEmpty) {
      emit(const SearchPlacesSuccessState([]));
      return;
    }

    try {
      final result = await repository.searchPlaces(input, sessionToken);
      result.fold(
        (s) => emit(
          SearchPlacesSuccessState(
            s.map((e) => Prediction.fromJson(e)).toList(),
          ),
        ),
        (f) => emit(SearchPlacesErrorState(f.toString())),
      );
    } catch (error) {
      emit(SearchPlacesErrorState(error.toString()));
    }
  }

  Future<void> getPlaceDetails(String placeId, String sessionToken) async {
    emit(const PlaceDetailsLoadingState());

    try {
      final result = await repository.getPlaceDetails(placeId, sessionToken);
      result.fold((details) {
        final addressComponents =
            details['address_components'] as List<dynamic>;
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

        emit(
          PlaceDetailsSuccessState(
            addressData: addressData,
            formattedAddress: details['formatted_address'] ?? '',
          ),
        );
      }, (f) => emit(PlaceDetailsErrorState(f.toString())));
    } catch (error) {
      emit(PlaceDetailsErrorState(error.toString()));
    }
  }
}
