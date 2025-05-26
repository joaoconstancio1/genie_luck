import 'package:flutter/material.dart';
import 'package:genie_luck/l10n/generated/app_localizations.dart';

class GlLoading extends StatelessWidget {
  final double size;
  final Color color;
  final bool showText;
  final AppLocalizations locale;

  const GlLoading({
    super.key,
    this.size = 26,
    this.color = Colors.blue,
    this.showText = true,
    required this.locale,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha((0.1 * 255).toInt()),
                  blurRadius: 8.0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: _AnimatedLoadingIcon(size: size, color: color),
          ),
          if (showText) ...[
            const SizedBox(height: 8.0),
            Text(
              locale.loading,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _AnimatedLoadingIcon extends StatefulWidget {
  final double size;
  final Color color;

  const _AnimatedLoadingIcon({required this.size, required this.color});

  @override
  State<_AnimatedLoadingIcon> createState() => _AnimatedLoadingIconState();
}

class _AnimatedLoadingIconState extends State<_AnimatedLoadingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * 3.14159,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform.rotate(
            angle: _rotationAnimation.value,
            child: Icon(
              Icons
                  .autorenew, // Ícone de rotação, pode ser substituído por um custom
              size: widget.size,
              color: widget.color,
            ),
          ),
        );
      },
    );
  }
}
