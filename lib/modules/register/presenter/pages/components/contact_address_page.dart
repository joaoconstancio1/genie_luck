import 'package:flutter/material.dart';
import 'package:genie_luck/core/design/gl_text_form_field.dart';
import 'package:genie_luck/core/utils/validators.dart';
import 'package:genie_luck/l10n/generated/app_localizations.dart';
import 'package:intl_phone_field/countries.dart';

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

  @override
  void initState() {
    super.initState();
    _preloadCountryFlags();
  }

  void _preloadCountryFlags() {
    for (var country in _countries) {
      _countryFlags.add(country.flag);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  void _showCountryPickerDialog(BuildContext context) {
    String searchQuery = '';
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
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
                      onChanged: (value) => setState(() => searchQuery = value),
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
                              widget.onCountrySelected(country);
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
                    hintText:
                        widget.selectedCountry?.name ??
                        widget.locale.hintCountry,
                    suffixIcon: const Icon(Icons.arrow_drop_down),
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? 'widget.locale.errorCountryRequired'
                                : null,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GlTextFormField(
                controller: widget.zipCodeController,
                keyboardType: TextInputType.text,
                labelText: widget.locale.labelZipCode,
                hintText: widget.locale.hintZipCode,
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
  }
}
