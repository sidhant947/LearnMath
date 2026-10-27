import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:learnmath/domain/models/math_problem.dart';
import 'package:learnmath/l10n/l10n.dart';

class RichMathVisualizer extends StatelessWidget {
  const RichMathVisualizer({
    super.key,
    required this.problem,
  });

  final MathProblem problem;

  @override
  Widget build(BuildContext context) {
    switch (problem.visualType) {
      case MathVisualType.dots:
        return _buildDotsVisual(context, problem.visualCount);
      case MathVisualType.arrayGrid:
        return _buildArrayVisual(context, problem.visualRows, problem.visualCols);
      case MathVisualType.numberLine:
        return _buildNumberLineVisual(
          context,
          problem.numberLineStart,
          problem.numberLineEnd,
          problem.numberLineStep,
        );
      case MathVisualType.placeValueBlocks:
        return _buildPlaceValueVisual(context, problem.tensCount, problem.onesCount);
      case MathVisualType.squareGrid:
        final side = problem.visualRows > 0
            ? problem.visualRows
            : (int.tryParse(RegExp(r'^\d+').firstMatch(problem.prompt)?.group(0) ?? '') ?? 0);
        if (side <= 0) {
          return const SizedBox.shrink();
        }
        return _buildSquareGridVisual(context, side);
      case MathVisualType.none:
        if (problem.visualCount > 0) {
          return _buildDotsVisual(context, problem.visualCount);
        }
        return const SizedBox.shrink();
    }
  }

  Widget _buildDotsVisual(BuildContext context, int count) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.4),
        ),
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 10,
        runSpacing: 10,
        children: List.generate(count, (index) {
          return Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colorScheme.primary,
                  colorScheme.primary.withValues(alpha: 0.75),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: colorScheme.primary.withValues(alpha: 0.3),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildArrayVisual(BuildContext context, int rows, int cols) {
    final colorScheme = Theme.of(context).colorScheme;
    final r = rows.clamp(1, 10);
    final c = cols.clamp(1, 10);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.l10n.rowsCols(r, c),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(r, (rowIndex) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(c, (colIndex) {
                    return Container(
                      width: 18,
                      height: 18,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    );
                  }),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberLineVisual(
    BuildContext context,
    int start,
    int end,
    int step,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.startAt(start),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              if (step != 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    step > 0 ? context.l10n.jumpStepPositive(step) : context.l10n.jumpStep(step),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              Text(
                context.l10n.endAt(end),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 36,
            child: CustomPaint(
              size: const Size(double.infinity, 36),
              painter: _NumberLinePainter(
                start: start,
                end: end,
                step: step,
                lineColor: colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                accentColor: colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceValueVisual(BuildContext context, int tens, int ones) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(
                context.l10n.tensVisual(tens, tens * 10),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: colorScheme.primary,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(tens, (i) {
                  return Container(
                    width: 10,
                    height: 52,
                    margin: const EdgeInsets.symmetric(horizontal: 2.5),
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  );
                }),
              ),
            ],
          ),
          Container(
            width: 1,
            height: 60,
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
          Column(
            children: [
              Text(
                context.l10n.onesVisual(ones, ones),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFFF59E0B),
                ),
              ),
              const SizedBox(height: 6),
              Wrap(
                spacing: 3,
                runSpacing: 3,
                children: List.generate(ones, (i) {
                  return Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF59E0B),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSquareGridVisual(BuildContext context, int side) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.4),
        ),
      ),
      child: Text(
        '$side² = $side × $side',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: colorScheme.primary,
        ),
      ),
    );
  }
}

class _NumberLinePainter extends CustomPainter {
  const _NumberLinePainter({
    required this.start,
    required this.end,
    required this.step,
    required this.lineColor,
    required this.accentColor,
  });

  final int start;
  final int end;
  final int step;
  final Color lineColor;
  final Color accentColor;

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    final accentPaint = Paint()
      ..color = accentColor
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final dotPaint = Paint()
      ..color = accentColor
      ..style = PaintingStyle.fill;

    final y = size.height - 8;
    canvas.drawLine(Offset(10, y), Offset(size.width - 10, y), linePaint);

    final span = math.max(1, end - start);
    final usableWidth = size.width - 20;

    for (int i = 0; i <= span; i++) {
      final x = 10 + (i / span) * usableWidth;
      canvas.drawLine(Offset(x, y - 5), Offset(x, y + 5), linePaint);
    }

    if (step != 0) {
      final startX = 10.0;
      final endX = size.width - 10.0;
      final path = Path();
      path.moveTo(startX, y);
      path.quadraticBezierTo(
        (startX + endX) / 2,
        0,
        endX,
        y,
      );
      canvas.drawPath(path, accentPaint);
      canvas.drawCircle(Offset(startX, y), 4.5, dotPaint);
      canvas.drawCircle(Offset(endX, y), 5.5, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _NumberLinePainter oldDelegate) => false;
}
