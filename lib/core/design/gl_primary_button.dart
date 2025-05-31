// Botão Primário
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
        foregroundColor:
            Theme.of(context).colorScheme.onPrimary, // Branco do tema
        backgroundColor: Theme.of(context).colorScheme.primary, // Azul do tema
        padding:
            Theme.of(context).elevatedButtonTheme.style?.padding?.resolve({}) ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Respeita o tema
        ),
        elevation: 6, // Sombra para efeito mágico
        shadowColor: Theme.of(
          context,
        ).colorScheme.primary.withOpacity(0.5), // Sombra azul
        minimumSize: const Size(140, 50),
      ).copyWith(
        overlayColor: WidgetStateProperty.all(
          Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ), // Efeito de prensa
      ),
      child: Text(
        text,
        style:
            Theme.of(
              context,
            ).textTheme.labelLarge, // Estilo do tema (branco, negrito)
      ),
    );
  }
}
