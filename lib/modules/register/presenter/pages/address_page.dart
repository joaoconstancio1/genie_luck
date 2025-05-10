import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genie_luck/core/design/gl_text_form_field.dart';
import 'package:genie_luck/core/utils/validators.dart';
import 'package:genie_luck/l10n/generated/app_localizations.dart';
import 'package:genie_luck/modules/register/presenter/cubit/address_search_cubit.dart';
import 'package:genie_luck/modules/register/presenter/cubit/address_search_state.dart';

class AddressPage extends StatefulWidget {
  final TextEditingController countryController;
  final TextEditingController zipCodeController;
  final TextEditingController addressController;
  final TextEditingController addressNumberController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController complementController;
  final TextEditingController neighborhoodController;
  final Validators validators;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final AppLocalizations locale;

  const AddressPage({
    super.key,
    required this.countryController,
    required this.zipCodeController,
    required this.addressController,
    required this.addressNumberController,
    required this.cityController,
    required this.stateController,
    required this.complementController,
    required this.neighborhoodController,
    required this.validators,
    required this.onNext,
    required this.onPrevious,
    required this.locale,
  });

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  bool _showFormFields = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddressSearchCubit, AddressSearchState>(
      listener: (context, state) {
        if (state is AddressSearchDetailsState) {
          widget.addressController.text = state.details.street ?? '';
          widget.addressNumberController.text =
              state.details.streetNumber ?? '';
          widget.neighborhoodController.text = state.details.neighborhood ?? '';
          widget.cityController.text = state.details.city ?? '';
          widget.stateController.text = state.details.state ?? '';
          widget.zipCodeController.text = state.details.postalCode ?? '';
          widget.countryController.text = state.details.country ?? '';
          setState(() {
            _showFormFields = true;
          });
        }
      },
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        shrinkWrap: true,
        children: [
          const SizedBox(height: 16),
          BlocBuilder<AddressSearchCubit, AddressSearchState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlTextFormField(
                    controller: widget.addressController,
                    keyboardType: TextInputType.text,
                    labelText: widget.locale.labelAddress,
                    hintText: widget.locale.hintAddress,
                    onChanged:
                        (value) => context
                            .read<AddressSearchCubit>()
                            .searchPlaces(value),
                    decoration: InputDecoration(
                      labelText: widget.locale.labelAddress,
                      hintText: widget.locale.hintAddress,
                      prefixIcon: const Icon(Icons.search, color: Colors.blue),
                      filled: true,
                      fillColor: Colors.blue[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  if (state is AddressSearchLoadingState)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Center(child: CircularProgressIndicator()),
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
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
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
                              context
                                  .read<AddressSearchCubit>()
                                  .getPlaceDetails(suggestion.placeId);
                              FocusScope.of(context).unfocus();
                            },
                          );
                        },
                      ),
                    ),
                ],
              );
            },
          ),
          Visibility(
            visible: _showFormFields,
            child: Column(
              children: [
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: GlTextFormField(
                        controller: widget.addressController,
                        keyboardType: TextInputType.text,
                        labelText: widget.locale.labelAddress,
                        hintText: widget.locale.hintAddress,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: GlTextFormField(
                        controller: widget.addressNumberController,
                        keyboardType: TextInputType.number,
                        labelText: widget.locale.labelAddressNumber,
                        hintText: widget.locale.hintAddressNumber,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                GlTextFormField(
                  controller: widget.neighborhoodController,
                  keyboardType: TextInputType.text,
                  labelText: widget.locale.labelNeighborhood,
                  hintText: widget.locale.hintNeighborhood,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: GlTextFormField(
                        controller: widget.cityController,
                        keyboardType: TextInputType.text,
                        labelText: widget.locale.labelCity,
                        hintText: widget.locale.hintCity,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: GlTextFormField(
                        controller: widget.stateController,
                        keyboardType: TextInputType.text,
                        labelText: widget.locale.labelState,
                        hintText: widget.locale.hintState,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                GlTextFormField(
                  controller: widget.zipCodeController,
                  keyboardType: TextInputType.number,
                  labelText: widget.locale.labelZipCode,
                  hintText: widget.locale.hintZipCode,
                ),
                const SizedBox(height: 16),
                GlTextFormField(
                  controller: widget.countryController,
                  keyboardType: TextInputType.text,
                  labelText: widget.locale.labelCountry,
                  hintText: widget.locale.hintCountry,
                ),
                const SizedBox(height: 16),
                GlTextFormField(
                  controller: widget.complementController,
                  keyboardType: TextInputType.text,
                  labelText: widget.locale.labelComplement,
                  hintText: widget.locale.hintComplement,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: widget.onPrevious,
                      child: Text(widget.locale.back),
                    ),
                    ElevatedButton(
                      onPressed: widget.onNext,
                      child: Text(widget.locale.next),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
