import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genie_luck/core/design/gl_loading.dart';
import 'package:genie_luck/l10n/generated/app_localizations.dart';
import 'package:genie_luck/modules/register/presenter/cubit/address_search_cubit.dart';
import 'package:genie_luck/modules/register/presenter/cubit/address_search_state.dart';

class SearchAddressField extends StatelessWidget {
  final TextEditingController searchController;
  final AppLocalizations locale;

  const SearchAddressField({
    super.key,
    required this.searchController,
    required this.locale,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressSearchCubit, AddressSearchState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 16.0),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha((0.1 * 255).toInt()),
                blurRadius: 4.0,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: searchController,
                keyboardType: TextInputType.text,
                onChanged:
                    (value) =>
                        context.read<AddressSearchCubit>().searchPlaces(value),
                decoration: InputDecoration(
                  labelText: locale.labelSearchAddress,
                  hintText: locale.hintSearchAddress,
                  prefixIcon: const Icon(Icons.search, color: Colors.blue),
                  suffixIcon:
                      searchController.text.isNotEmpty
                          ? IconButton(
                            icon: const Icon(Icons.clear, color: Colors.grey),
                            onPressed: () {
                              searchController.clear();
                              context.read<AddressSearchCubit>().searchPlaces(
                                '',
                              );
                            },
                          )
                          : null,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: const BorderSide(
                      color: Colors.blueAccent,
                      width: 2.5,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                ),
              ),
              if (state is AddressSearchLoadingState)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GlLoading(locale: locale),
                ),
              if (state is AddressSearchErrorState)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    state.error.toString(),
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),
              if (state is AddressSearchSuggestionsState &&
                  state.suggestions.isNotEmpty)
                Container(
                  constraints: const BoxConstraints(maxHeight: 200),
                  margin: const EdgeInsets.only(top: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.suggestions.length,
                    itemBuilder: (context, index) {
                      final suggestion = state.suggestions[index];
                      return ListTile(
                        title: Text(suggestion.description),
                        subtitle:
                            suggestion.secondaryText != null
                                ? Text(suggestion.secondaryText!)
                                : null,
                        onTap: () {
                          context.read<AddressSearchCubit>().getPlaceDetails(
                            suggestion.placeId,
                          );
                          FocusScope.of(context).unfocus();
                        },
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
