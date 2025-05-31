import 'package:flutter/material.dart';

class GlSecondaryButton extends StatelessWidget {
  const GlSecondaryButton({super.key, required this.text, this.onPressed});

  final String text;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.secondary,
        side: BorderSide(
          color: Theme.of(context).colorScheme.secondary,
          width: 2,
        ),
        padding:
            Theme.of(context).elevatedButtonTheme.style?.padding?.resolve({}) ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        minimumSize: const Size(140, 50),
      ).copyWith(
        overlayColor: WidgetStateProperty.all(
          Theme.of(context).colorScheme.secondary.withOpacity(0.1),
        ), // Efeito de prensa
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.pressed)) {
            return Theme.of(context).colorScheme.secondary.withOpacity(
              0.1,
            ); // Fundo sutil ao interagir
          }
          return Colors.transparent;
        }),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color:
              Theme.of(
                context,
              ).colorScheme.secondary, // Verde-azulado para texto
        ),
      ),
    );
  }
}
