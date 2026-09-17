import 'package:flutter/material.dart';
import 'package:learnmath/ui/core/services/app_haptics.dart';

class TangibleButton extends StatefulWidget {
  const TangibleButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isSecondary = false,
    this.height = 54,
    this.icon,
    this.color,
    this.textColor,
    this.shadowColor,
    this.depth = 4.0,
    this.borderRadius = 18.0,
    this.child,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isSecondary;
  final double height;
  final IconData? icon;
  final Color? color;
  final Color? textColor;
  final Color? shadowColor;
  final double depth;
  final double borderRadius;
  final Widget? child;

  @override
  State<TangibleButton> createState() => _TangibleButtonState();
}

class _TangibleButtonState extends State<TangibleButton> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    if (widget.onPressed == null) return;
    setState(() => _isPressed = true);
    AppHaptics.light();
  }

  void _onTapUp(TapUpDetails details) {
    if (widget.onPressed == null) return;
    setState(() => _isPressed = false);
    widget.onPressed!();
  }

  void _onTapCancel() {
    if (widget.onPressed == null) return;
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isEnabled = widget.onPressed != null;

    final Color faceColor = widget.color ??
        (widget.isSecondary
            ? colorScheme.surfaceContainerHigh
            : colorScheme.primary);

    final Color effectiveFaceColor = isEnabled
        ? faceColor
        : faceColor.withValues(alpha: 0.35);

    final Color depthColor = widget.shadowColor ??
        (widget.isSecondary
            ? colorScheme.outlineVariant
            : HSLColor.fromColor(faceColor)
                .withLightness(
                    (HSLColor.fromColor(faceColor).lightness - 0.22)
                        .clamp(0.0, 1.0))
                .toColor());

    final Color effectiveDepthColor = isEnabled
        ? depthColor
        : depthColor.withValues(alpha: 0.25);

    final Color textCol = widget.textColor ??
        (widget.isSecondary
            ? colorScheme.onSurface
            : Colors.white);

    final Color effectiveTextColor = isEnabled
        ? textCol
        : textCol.withValues(alpha: 0.45);

    final double effectiveDepth = isEnabled ? widget.depth : 2.0;
    final double currentShift = _isPressed ? effectiveDepth : 0.0;

    return SizedBox(
      height: widget.height,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        behavior: HitTestBehavior.opaque,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              top: effectiveDepth,
              child: Container(
                decoration: BoxDecoration(
                  color: effectiveDepthColor,
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
              ),
            ),
            AnimatedPadding(
              duration: const Duration(milliseconds: 50),
              curve: Curves.easeOutCubic,
              padding: EdgeInsets.only(
                top: currentShift,
                bottom: effectiveDepth - currentShift,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: effectiveFaceColor,
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  border: Border.all(
                    color: isEnabled
                        ? (widget.isSecondary
                            ? colorScheme.outline
                            : Colors.white.withValues(alpha: 0.2))
                        : colorScheme.outlineVariant.withValues(alpha: 0.2),
                    width: 1.5,
                  ),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: widget.child ??
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.icon != null) ...[
                          Icon(
                            widget.icon,
                            size: 20,
                            color: effectiveTextColor,
                          ),
                          const SizedBox(width: 8),
                        ],
                        Flexible(
                          child: Text(
                            widget.text,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: effectiveTextColor,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ],
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
