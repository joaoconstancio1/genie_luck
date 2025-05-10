import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genie_luck/core/design/gl_text_form_field.dart';
import 'package:genie_luck/core/utils/validators.dart';
import 'package:genie_luck/l10n/generated/app_localizations.dart';
import 'package:genie_luck/modules/register/presenter/cubit/cep_cubit.dart';
import 'package:genie_luck/modules/register/presenter/cubit/cep_state.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:genie_luck/modules/register/presenter/components/country_picker_dialog.dart';
import 'dart:async';

class AddressPage extends StatefulWidget {
  final TextEditingController countryController;
  final TextEditingController zipCodeController;
  final TextEditingController addressController;
  final TextEditingController addressNumberController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController complementController;
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
    required this.validators,
    required this.onNext,
    required this.onPrevious,
    required this.locale,
  });

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      shrinkWrap: true,
      children: [
        const SizedBox(height: 16),
        GlTextFormField(onChanged: (p0) {}),
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
    );
  }
}
