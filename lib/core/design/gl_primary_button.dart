import 'package:flutter/material.dart';

class GlPrimaryButton extends StatelessWidget {
  const GlPrimaryButton({super.key, required this.text, this.onPressed});

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Theme.of(context).colorScheme.primary,
        padding:
            Theme.of(context).elevatedButtonTheme.style?.padding?.resolve({}) ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 6,
        shadowColor: Theme.of(
          context,
        ).colorScheme.primary.withAlpha((0.5 * 255).toInt()),
        minimumSize: const Size(140, 50),
      ).copyWith(
        overlayColor: WidgetStateProperty.all(
          Theme.of(context).colorScheme.primary.withAlpha((0.2 * 255).toInt()),
        ),
      ),
      child: Text(text, style: Theme.of(context).textTheme.labelLarge),
    );
  }
}
