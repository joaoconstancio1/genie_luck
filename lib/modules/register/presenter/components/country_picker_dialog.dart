import 'package:flutter/material.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:genie_luck/l10n/generated/app_localizations.dart';

class CountryPickerDialog extends StatefulWidget {
  final List<Country> countries;
  final ValueChanged<Country> onCountrySelected;
  final AppLocalizations locale;

  const CountryPickerDialog({
    super.key,
    required this.countries,
    required this.onCountrySelected,
    required this.locale,
  });

  @override
  State<CountryPickerDialog> createState() => _CountryPickerDialogState();
}

class _CountryPickerDialogState extends State<CountryPickerDialog> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredCountries =
        widget.countries
            .where(
              (country) => country.name.toLowerCase().contains(
                _searchQuery.toLowerCase(),
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
              onChanged: (value) => setState(() => _searchQuery = value),
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
  }
}
