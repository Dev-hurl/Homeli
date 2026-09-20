import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class CircleIconButton extends StatelessWidget {
  final dynamic icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final VoidCallback onTap;
  const CircleIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.iconColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor ?? colorScheme.surface,
          shape: BoxShape.circle,
        ),
        child: HugeIcon(
          icon: icon,
          size: 18,
          color: iconColor ?? colorScheme.secondary,
        ),
      ),
    );
  }
}
