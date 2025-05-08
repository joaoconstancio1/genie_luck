import 'package:flutter/material.dart';
import 'package:genie_luck/core/design/gl_text_form_field.dart';
import 'package:genie_luck/modules/register/presenter/components/country_picker_dialog.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:genie_luck/l10n/generated/app_localizations.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PhoneField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Country? selectedCountry;
  final ValueChanged<Country> onCountryChanged;
  final AppLocalizations locale;

  const PhoneField({
    super.key,
    required this.controller,
    this.validator,
    required this.selectedCountry,
    required this.onCountryChanged,
    required this.locale,
  });
  static final Map<String, String> _countryPhoneMasks = {
    'BR': '(##) #####-####',
    'US': '(###) ###-####',
    'GB': '#### ######',
    'IN': '#####-#####',
  };

  static const String _defaultMask = '#############';

  String _getMask() {
    if (selectedCountry == null) return _defaultMask;
    return _countryPhoneMasks[selectedCountry!.code] ?? _defaultMask;
  }

  void _showCountryPickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => CountryPickerDialog(
            countries: countries,
            onCountrySelected: (country) {
              onCountryChanged(country);
              controller.clear();
            },
            locale: locale,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final maskFormatter = MaskTextInputFormatter(
      mask: _getMask(),
      filter: {'#': RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );

    return GlTextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,

      validator: validator,
      labelText: locale.labelPhoneNumber,
      hintText: locale.hintPhoneNumber,
      inputFormatters: [maskFormatter],
      prefixIcon: GestureDetector(
        onTap: () => _showCountryPickerDialog(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (selectedCountry != null) ...[
                Text(
                  selectedCountry!.flag,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(width: 8),
                Text(
                  '+${selectedCountry!.dialCode}',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
              const SizedBox(width: 8),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }
}
