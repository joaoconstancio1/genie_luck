import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:genie_luck/modules/register/presenter/cubit/places_states.dart';
import 'package:genie_luck/modules/register/presenter/cubit/places_states.dart';

class PlacesCubit extends Cubit<PlacesState> {
  PlacesCubit() : super(const PlacesInitialState());

  Future<void> searchPlaces(String input, String sessionToken) async {
    try {
      if (input.isEmpty) {
        emit(const PlacesSearchSuccessState([]));
        return;
      }

      emit(const PlacesLoadingState());

      final response = await _places.autocomplete(
        input,
        sessionToken: sessionToken,
        language: 'pt-BR', // Ajuste conforme necessário
      );

      if (response.isOkay) {
        emit(PlacesSearchSuccessState(response.predictions));
      } else {
        emit(
          PlacesErrorState(
            Exception('Erro ao buscar lugares: ${response.errorMessage}'),
          ),
        );
      }
    } catch (error) {
      emit(PlacesErrorState(Exception(error.toString())));
    }
  }

  Future<void> getPlaceDetails(String placeId, String sessionToken) async {
    emit(const PlacesLoadingState());

    try {
      final response = await _places.getDetailsByPlaceId(
        placeId,
        sessionToken: sessionToken,
        language: 'pt-BR',
      );

      if (response.isOkay) {
        final details = response.result;
        // Extrai os componentes do endereço
        String? street, city, state, country, zipCode;
        for (var component in details.addressComponents!) {
          if (component.types.contains('street_number')) {
            street = component.longName;
          } else if (component.types.contains('route')) {
            street = (street ?? '') + ' ' + component.longName;
          } else if (component.types.contains('locality')) {
            city = component.longName;
          } else if (component.types.contains('administrative_area_level_1')) {
            state = component.shortName;
          } else if (component.types.contains('country')) {
            country = component.longName;
          } else if (component.types.contains('postal_code')) {
            zipCode = component.longName;
          }
        }

        emit(
          PlacesDetailsSuccessState(
            PlaceDetailsModel(
              street: street?.trim(),
              city: city,
              state: state,
              country: country,
              zipCode: zipCode,
            ),
          ),
        );
      } else {
        emit(
          PlacesErrorState(
            Exception('Erro ao obter detalhes: ${response.errorMessage}'),
          ),
        );
      }
    } catch (error) {
      emit(PlacesErrorState(Exception(error.toString())));
    }
  }

  void clearPredictions() {
    emit(const PlacesSearchSuccessState([]));
  }
}
