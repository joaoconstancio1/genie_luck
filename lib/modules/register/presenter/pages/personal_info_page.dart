import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:genie_luck/core/design/gl_primary_button.dart';
import 'package:genie_luck/core/design/gl_text_form_field.dart';
import 'package:genie_luck/core/design/data_picker.dart';
import 'package:genie_luck/core/utils/validators.dart';
import 'package:genie_luck/l10n/generated/app_localizations.dart';
import 'package:genie_luck/modules/register/presenter/components/phone_field.dart';
import 'package:intl_phone_field/countries.dart';

class PersonalInfoPage extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController dateController;
  final TextEditingController phoneController;
  final Validators validators;
  final DataPicker dataPicker;
  final String selectedCountryCode;
  final ValueChanged<String> onCountryCodeChanged;
  final ValueChanged<DateTime?> onDateSelected;
  final VoidCallback onNext;
  final AppLocalizations locale;

  const PersonalInfoPage({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.dateController,
    required this.phoneController,
    required this.validators,
    required this.dataPicker,
    required this.selectedCountryCode,
    required this.onCountryCodeChanged,
    required this.onDateSelected,
    required this.onNext,
    required this.locale,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return ListView(
      padding: const EdgeInsets.all(16.0),
      shrinkWrap: true,
      children: [
        Text(
          locale.registerTitle,
          textAlign: TextAlign.center,
          style: theme.titleLarge,
        ),
        SizedBox(height: 16),
        GlTextFormField(
          controller: nameController,
          keyboardType: TextInputType.name,
          labelText: locale.labelCompleteName,
          hintText: locale.hintCompleteName,
          validator: validators.nameValidator,
        ),
        const SizedBox(height: 16),
        GlTextFormField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          labelText: locale.labelEmail,
          hintText: locale.hintEmail,
          validator: validators.validateEmail,
        ),
        const SizedBox(height: 16),
        GlTextFormField(
          controller: passwordController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          labelText: locale.labelPassword,
          hintText: locale.hintPassword,
          obscureText: true,
          validator: validators.validatePassword,
        ),
        const SizedBox(height: 16),
        GlTextFormField(
          controller: confirmPasswordController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          labelText: locale.labelConfirmPassword,
          hintText: locale.hintConfirmPassword,
          obscureText: true,
          validator:
              (value) => validators.validateConfirmPassword(
                value,
                passwordController.text,
              ),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap:
              () => dataPicker
                  .displayDatePicker(context)
                  .then((value) => onDateSelected(dataPicker.selectedDate)),
          child: AbsorbPointer(
            child: GlTextFormField(
              controller: dateController,
              keyboardType: TextInputType.none,
              readOnly: true,
              labelText: locale.labelBirthDate,
              hintText: locale.hintBirthDate,
              suffixIcon: const Icon(Icons.calendar_today),
              validator: validators.validateDate,
            ),
          ),
        ),
        const SizedBox(height: 16),
        PhoneField(
          controller: phoneController,
          validator: validators.validatePhoneNumber,
          selectedCountry: _getSelectedCountry(),
          onCountryChanged: (country) => onCountryCodeChanged(country.code),
          locale: locale,
        ),

        const SizedBox(height: 16),
        GlPrimaryButton(onPressed: onNext, text: locale.next),
      ],
    );
  }

  Country? _getSelectedCountry() {
    if (selectedCountryCode.isEmpty) return null;
    return countries.firstWhere(
      (country) => country.code == selectedCountryCode,
      orElse: () => countries.firstWhere((country) => country.code == 'BR'),
    );
  }
}
