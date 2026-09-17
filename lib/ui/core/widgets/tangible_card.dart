import 'package:flutter/material.dart';
import 'package:learnmath/ui/core/services/app_haptics.dart';

class TangibleCard extends StatefulWidget {
  const TangibleCard({
    super.key,
    required this.child,
    this.color,
    this.borderColor,
    this.shadowColor,
    this.depth = 4.0,
    this.borderRadius = 22.0,
    this.padding = const EdgeInsets.all(16),
    this.onTap,
  });

  final Widget child;
  final Color? color;
  final Color? borderColor;
  final Color? shadowColor;
  final double depth;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  @override
  State<TangibleCard> createState() => _TangibleCardState();
}

class _TangibleCardState extends State<TangibleCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final Color faceColor = widget.color ?? colorScheme.surfaceContainer;
    final Color depthColor = widget.shadowColor ??
        HSLColor.fromColor(faceColor)
            .withLightness(
                (HSLColor.fromColor(faceColor).lightness - 0.18).clamp(0.0, 1.0))
            .toColor();
    final Color outlineColor = widget.borderColor ?? colorScheme.outlineVariant;

    final double currentShift = _isPressed && widget.onTap != null ? widget.depth : 0.0;

    Widget body = Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          top: widget.depth,
          child: Container(
            decoration: BoxDecoration(
              color: depthColor,
              borderRadius: BorderRadius.circular(widget.borderRadius),
              border: Border.all(
                color: depthColor,
                width: 1.5,
              ),
            ),
          ),
        ),
        AnimatedPadding(
          duration: const Duration(milliseconds: 60),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.only(
            top: currentShift,
            bottom: widget.depth - currentShift,
          ),
          child: Container(
            padding: widget.padding,
            decoration: BoxDecoration(
              color: faceColor,
              borderRadius: BorderRadius.circular(widget.borderRadius),
              border: Border.all(
                color: outlineColor,
                width: 2.0,
              ),
            ),
            child: widget.child,
          ),
        ),
      ],
    );

    if (widget.onTap == null) {
      return body;
    }

    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isPressed = true);
        AppHaptics.light();
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap!();
      },
      onTapCancel: () {
        setState(() => _isPressed = false);
      },
      child: body,
    );
  }
}
