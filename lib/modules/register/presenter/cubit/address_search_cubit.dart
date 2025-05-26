import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genie_luck/modules/register/data/repositories/register_repository.dart';
import 'package:genie_luck/modules/register/presenter/cubit/address_search_state.dart';
import 'package:uuid/uuid.dart';

class AddressSearchCubit extends Cubit<AddressSearchState> {
  AddressSearchCubit({required this.repository})
    : super(const AddressSearchInitialState());

  final RegisterRepository repository;
  final String _sessionToken = const Uuid().v4();

  Future<void> searchPlaces(String input) async {
    if (input.isEmpty) {
      emit(const AddressSearchSuggestionsState(suggestions: []));
      return;
    }

    emit(const AddressSearchLoadingState());
    // try {
    //   final result = await repository.searchPlaces(input, _sessionToken);
    //   result.fold(
    //     (s) => emit(AddressSearchSuggestionsState(suggestions: s)),
    //     (f) => emit(AddressSearchErrorState(Exception(f))),
    //   );
    // } catch (error) {
    //   emit(AddressSearchErrorState(Exception(error.toString())));
    // }
  }

  Future<void> getPlaceDetails(String placeId) async {
    emit(const AddressSearchLoadingState());
    try {
      final result = await repository.getPlaceDetails(placeId, _sessionToken);
      result.fold(
        (s) => emit(AddressSearchDetailsState(details: s)),
        (f) => emit(AddressSearchErrorState(Exception(f))),
      );
    } catch (error) {
      emit(AddressSearchErrorState(Exception(error.toString())));
    }
  }
}
