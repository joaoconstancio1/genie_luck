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
    return ListView(
      padding: const EdgeInsets.all(16.0),
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
          onChanged: (value) => onReceivePromotionsChanged(value ?? false),
          controlAffinity: ListTileControlAffinity.leading,
        ),
        const SizedBox(height: 16),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(onPressed: onPrevious, child: Text(locale.back)),
            ElevatedButton(
              onPressed: acceptTerms ? onRegister : null,
              child: Text(locale.buttonRegisterNow),
            ),
          ],
        ),
      ],
    );
  }
}
