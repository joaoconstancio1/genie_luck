import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genie_luck/core/design/gl_text_form_field.dart';
import 'package:genie_luck/core/utils/validators.dart';
import 'package:genie_luck/l10n/generated/app_localizations.dart';
import 'package:genie_luck/modules/register/presenter/components/search_address_field.dart';
import 'package:genie_luck/modules/register/presenter/cubit/address_search_cubit.dart';
import 'package:genie_luck/modules/register/presenter/cubit/address_search_state.dart';

class AddressPage extends StatefulWidget {
  final TextEditingController countryController;
  final TextEditingController zipCodeController;
  final TextEditingController addressController;
  final TextEditingController searchController;
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
    required this.searchController,
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
          SearchAddressField(
            searchController: widget.searchController,
            locale: widget.locale,
          ),
          const SizedBox(height: 16),
          Visibility(
            visible: _showFormFields,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: GlTextFormField(
                        controller: widget.addressController,
                        keyboardType: TextInputType.text,
                        labelText: widget.locale.labelAddress,
                        hintText: widget.locale.hintAddress,
                        validator: widget.validators.validateAddress,
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
                        validator: widget.validators.validateAddressNumber,
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
                  validator: widget.validators.validateNeighborhood,
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
                        validator: widget.validators.validateCity,
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
                        validator: widget.validators.validateState,
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
                  validator: widget.validators.validateZipCode,
                ),
                const SizedBox(height: 16),
                GlTextFormField(
                  controller: widget.countryController,
                  keyboardType: TextInputType.text,
                  labelText: widget.locale.labelCountry,
                  hintText: widget.locale.hintCountry,
                  validator: widget.validators.validateCountry,
                ),
                const SizedBox(height: 16),
                GlTextFormField(
                  controller: widget.complementController,
                  keyboardType: TextInputType.text,
                  labelText: widget.locale.labelComplement,
                  hintText: widget.locale.hintComplement,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: widget.onPrevious,
                child: Text(widget.locale.back),
              ),
              ElevatedButton(
                onPressed: () {
                  if (Form.of(context).validate()) {
                    widget.onNext();
                  }
                },
                child: Text(widget.locale.next),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
