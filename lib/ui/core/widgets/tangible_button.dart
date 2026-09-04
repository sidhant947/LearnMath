import 'package:flutter/material.dart';
import 'package:learnmath/ui/core/services/app_haptics.dart';

class TangibleButton extends StatelessWidget {
  const TangibleButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isSecondary = false,
    this.height = 54,
    this.icon,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isSecondary;
  final double height;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final VoidCallback? effectiveOnPressed = onPressed == null
        ? null
        : () {
            AppHaptics.light();
            onPressed!();
          };

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: isSecondary
          ? BorderSide(color: colorScheme.outlineVariant, width: 1.2)
          : BorderSide.none,
    );

    if (isSecondary) {
      if (icon != null) {
        return OutlinedButton.icon(
          onPressed: effectiveOnPressed,
          style: OutlinedButton.styleFrom(
            minimumSize: Size.fromHeight(height),
            shape: shape,
          ),
          icon: Icon(icon, size: 20),
          label: Text(text),
        );
      }
      return OutlinedButton(
        onPressed: effectiveOnPressed,
        style: OutlinedButton.styleFrom(
          minimumSize: Size.fromHeight(height),
          shape: shape,
        ),
        child: Text(text),
      );
    }

    if (icon != null) {
      return FilledButton.icon(
        onPressed: effectiveOnPressed,
        style: FilledButton.styleFrom(
          minimumSize: Size.fromHeight(height),
          shape: shape,
        ),
        icon: Icon(icon, size: 20),
        label: Text(text),
      );
    }

    return FilledButton(
      onPressed: effectiveOnPressed,
      style: FilledButton.styleFrom(
        minimumSize: Size.fromHeight(height),
        shape: shape,
      ),
      child: Text(text),
    );
  }
}
