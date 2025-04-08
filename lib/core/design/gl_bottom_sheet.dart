import 'package:flutter/material.dart';

class GlBottomSheet {
  const GlBottomSheet({
    required this.context,
    required this.child,
    this.backgroundColor,
    this.isScrollControlled,
  });
  final BuildContext context;
  final Widget child;
  final bool? isScrollControlled;
  final Color? backgroundColor;

  void call() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useSafeArea: true,
      builder: (context) {
        return child;
      },
    );
  }
}
