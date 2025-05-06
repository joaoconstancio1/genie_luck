import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genie_luck/core/design/gl_text_form_field.dart';
import 'package:genie_luck/core/utils/validators.dart';
import 'package:genie_luck/l10n/generated/app_localizations.dart';
import 'package:genie_luck/modules/register/presenter/cubit/cep_cubit.dart';
import 'package:genie_luck/modules/register/presenter/cubit/cep_state.dart';
import 'package:intl_phone_field/countries.dart';
import 'dart:async';

class ContactAddressPage extends StatefulWidget {
  final TextEditingController countryController;
  final TextEditingController zipCodeController;
  final TextEditingController addressController;
  final TextEditingController addressNumberController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final Validators validators;
  final Country? selectedCountry;
  final ValueChanged<Country> onCountrySelected;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final AppLocalizations locale;

  const ContactAddressPage({
    super.key,
    required this.countryController,
    required this.zipCodeController,
    required this.addressController,
    required this.addressNumberController,
    required this.cityController,
    required this.stateController,
    required this.validators,
    required this.selectedCountry,
    required this.onCountrySelected,
    required this.onNext,
    required this.onPrevious,
    required this.locale,
  });

  @override
  State<ContactAddressPage> createState() => _ContactAddressPageState();
}

class _ContactAddressPageState extends State<ContactAddressPage> {
  final List<String> _countryFlags = [];
  final List<Country> _countries = countries;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _preloadCountryFlags();
    widget.zipCodeController.addListener(() => _onZipCodeChanged(context));
  }

  @override
  void dispose() {
    _debounce?.cancel();
    widget.zipCodeController.removeListener(() => _onZipCodeChanged(context));
    super.dispose();
  }

  void _preloadCountryFlags() {
    for (var country in _countries) {
      _countryFlags.add(country.flag);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  void _onZipCodeChanged(BuildContext context) {
    _debounce?.cancel();
    if (widget.selectedCountry?.code == 'BR') {
      final cep = widget.zipCodeController.text;
      if (cep.replaceAll(RegExp(r'[^0-9]'), '').length == 8) {
        _debounce = Timer(const Duration(milliseconds: 500), () {
          context.read<CepCubit>().fetchCepData(cep);
        });
      }
    }
  }

  void _showCountryPickerDialog(BuildContext context) {
    String searchQuery = '';
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            final filteredCountries =
                _countries
                    .where(
                      (country) => country.name.toLowerCase().contains(
                        searchQuery.toLowerCase(),
                      ),
                    )
                    .toList();
            return AlertDialog(
              title: Text(widget.locale.searchCountry),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: widget.locale.searchCountry,
                        border: const OutlineInputBorder(),
                      ),
                      onChanged:
                          (value) => setStateDialog(() => searchQuery = value),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        cacheExtent: 1000,
                        itemCount: filteredCountries.length,
                        itemBuilder: (context, index) {
                          final country = filteredCountries[index];
                          return ListTile(
                            dense: true,
                            leading: Text(
                              country.flag,
                              style: const TextStyle(fontSize: 20),
                            ),
                            title: Text(
                              country.name,
                              style: const TextStyle(fontSize: 20),
                            ),
                            onTap: () {
                              widget.countryController.text = country.name;
                              widget.onCountrySelected(country);

                              if (country.code != 'BR') {
                                widget.zipCodeController.clear();
                                widget.addressController.clear();
                                widget.cityController.clear();
                                widget.stateController.clear();
                              }

                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CepCubit, CepState>(
      listener: (context, state) {
        if (state is CepSuccessState) {
          widget.addressController.text = state.cepData.logradouro;
          widget.cityController.text = state.cepData.localidade;
          widget.stateController.text = state.cepData.uf;
        } else if (state is CepErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(widget.locale.errorInvalidZipCode)),
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SizedBox(
              width: 600,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Offstage(
                    offstage: true,
                    child: Text(
                      _countryFlags.join(),
                      style: const TextStyle(fontSize: 0),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _showCountryPickerDialog(context),
                    child: AbsorbPointer(
                      child: GlTextFormField(
                        controller: widget.countryController,
                        keyboardType: TextInputType.none,
                        readOnly: true,
                        labelText: widget.locale.labelCountry,
                        hintText: widget.locale.hintCountry,
                        prefixIcon:
                            widget.selectedCountry != null
                                ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        widget.selectedCountry!.flag,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                )
                                : null,
                        suffixIcon: const Icon(Icons.arrow_drop_down),
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? widget.locale.errorCountryRequired
                                    : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GlTextFormField(
                    controller: widget.zipCodeController,
                    keyboardType: TextInputType.number,
                    labelText: widget.locale.labelZipCode,
                    hintText: widget.locale.hintZipCode,
                    validator:
                        widget.selectedCountry?.code == 'BR'
                            ? (value) =>
                                value != null &&
                                        value
                                                .replaceAll(
                                                  RegExp(r'[^0-9]'),
                                                  '',
                                                )
                                                .length ==
                                            8
                                    ? null
                                    : widget.locale.errorInvalidZipCode
                            : null,
                  ),
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
          ),
        );
      },
    );
  }
}
