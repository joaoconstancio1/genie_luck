import 'package:flutter/material.dart';
import 'package:genie_luck/l10n/generated/app_localizations.dart';
import 'package:go_router/go_router.dart';

class GlTermAndConditionsWidget extends StatelessWidget {
  const GlTermAndConditionsWidget({super.key, this.height});
  final double? height;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations locale = AppLocalizations.of(context)!;
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  locale.termsTitle,
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    context.pop();
                  },
                ),
              ],
            ),

            Expanded(
              child: SingleChildScrollView(child: Center(child: Text(text))),
            ),
          ],
        ),
      ),
    );
  }

  static String text = List.filled(5000, "Teste").join();
}
