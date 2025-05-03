import 'package:flutter/material.dart';
import 'package:genie_luck/core/design/gl_text_form_field.dart';
import 'package:genie_luck/core/utils/data_picker.dart';
import 'package:genie_luck/core/utils/validators.dart';
import 'package:genie_luck/l10n/generated/app_localizations.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';

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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: SizedBox(
          width: 600,
          child: ListView(
            shrinkWrap: true,
            children: [
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
                        .then(
                          (value) => onDateSelected(dataPicker.selectedDate),
                        ),
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
              IntlPhoneField(
                pickerDialogStyle: PickerDialogStyle(
                  searchFieldInputDecoration: InputDecoration(
                    labelText: locale.searchCountry,
                  ),
                ),
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: locale.labelPhoneNumber,
                  hintText: locale.hintPhoneNumber,
                  hintStyle: const TextStyle(color: Colors.grey),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                initialCountryCode: 'BR',
                onChanged: (phone) => onCountryCodeChanged(phone.countryCode),
                validator:
                    (phone) => validators.validatePhoneNumber(phone?.number),
                showCountryFlag: true,
                dropdownIcon: const Icon(Icons.arrow_drop_down),
                disableLengthCheck: true,
                autovalidateMode: AutovalidateMode.onUnfocus,
              ),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: onNext, child: Text(locale.next)),
            ],
          ),
        ),
      ),
    );
  }
}
