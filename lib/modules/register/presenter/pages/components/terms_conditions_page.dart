import 'package:flutter/material.dart';
import 'package:genie_luck/l10n/generated/app_localizations.dart';

class TermsConfirmationPage extends StatelessWidget {
  final bool acceptTerms;
  final bool receivePromotions;
  final ValueChanged<bool> onAcceptTermsChanged;
  final ValueChanged<bool> onReceivePromotionsChanged;
  final VoidCallback onRegister;
  final VoidCallback onPrevious;
  final AppLocalizations locale;

  const TermsConfirmationPage({
    super.key,
    required this.acceptTerms,
    required this.receivePromotions,
    required this.onAcceptTermsChanged,
    required this.onReceivePromotionsChanged,
    required this.onRegister,
    required this.onPrevious,
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
              CheckboxListTile(
                title: Text(locale.labelAcceptTerms),
                value: acceptTerms,
                onChanged: (value) => onAcceptTermsChanged(value ?? false),
                controlAffinity: ListTileControlAffinity.leading,
              ),
              CheckboxListTile(
                title: Text(locale.labelReceivePromotions),
                value: receivePromotions,
                onChanged:
                    (value) => onReceivePromotionsChanged(value ?? false),
                controlAffinity: ListTileControlAffinity.leading,
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onRegister,
                  child: Text(locale.buttonRegisterNow),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: onPrevious, child: Text(locale.back)),
            ],
          ),
        ),
      ),
    );
  }
}
