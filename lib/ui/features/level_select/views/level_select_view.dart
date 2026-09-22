import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:learnmath/l10n/l10n.dart';
import 'package:learnmath/ui/core/services/app_haptics.dart';
import 'package:learnmath/ui/core/widgets/tangible_card.dart';
import 'package:learnmath/ui/features/game/math_game/math_game_engine.dart';
import 'package:learnmath/ui/features/game/math_game/math_game_screen.dart';
import 'package:learnmath/ui/features/home/view_models/home_view_model.dart';

class LevelSelectView extends ConsumerStatefulWidget {
  const LevelSelectView({super.key});

  @override
  ConsumerState<LevelSelectView> createState() => _LevelSelectViewState();
}

class _LevelSelectViewState extends ConsumerState<LevelSelectView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(homeViewModelProvider.notifier).loadProgress());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeViewModelProvider);
    final highestCompleted = state.progress?.highestLevelCompleted ?? 0;
    final currentLevel = state.progress?.currentLevel ?? 1;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final int totalLevelsToShow = math.max(60, currentLevel + 8);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.levels),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 850),
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 85,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.0,
              ),
              itemCount: totalLevelsToShow,
              itemBuilder: (context, index) {
                final levelNumber = index + 1;
                final isCompleted = levelNumber <= highestCompleted;
                final isCurrent = levelNumber == currentLevel;
                final isLocked = levelNumber > currentLevel;

                return _buildLevelCard(
                  context,
                  colorScheme: colorScheme,
                  levelNumber: levelNumber,
                  isCompleted: isCompleted,
                  isCurrent: isCurrent,
                  isLocked: isLocked,
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLevelCard(
    BuildContext context, {
    required ColorScheme colorScheme,
    required int levelNumber,
    required bool isCompleted,
    required bool isCurrent,
    required bool isLocked,
  }) {
    final bool isClickable = !isLocked;
    final isBoss = MathGameEngine.isBossLevel(levelNumber);

    Color cardBg;
    Color textColor;
    Color shadowColor;
    Color borderColor;
    Widget iconWidget;

    if (isCompleted) {
      cardBg = isBoss ? const Color(0xFFD97706) : colorScheme.primaryContainer;
      shadowColor = isBoss ? const Color(0xFF92400E) : colorScheme.primary;
      borderColor = isBoss ? const Color(0xFFF59E0B) : colorScheme.primary;
      textColor = isBoss ? Colors.white : colorScheme.onPrimaryContainer;
      iconWidget = Icon(
        Icons.check_circle_rounded,
        size: 14,
        color: textColor,
      );
    } else if (isCurrent) {
      cardBg = isBoss ? const Color(0xFFFFB800) : colorScheme.primary;
      shadowColor = isBoss ? const Color(0xFFB45309) : const Color(0xFF047857);
      borderColor = isBoss ? const Color(0xFFFBBF24) : const Color(0xFF34D399);
      textColor = isBoss ? Colors.black87 : colorScheme.onPrimary;
      iconWidget = isBoss
          ? const Icon(Icons.workspace_premium_rounded, size: 15, color: Colors.black87)
          : const SizedBox.shrink();
    } else {
      cardBg = isBoss
          ? const Color(0xFFFFB800).withValues(alpha: 0.12)
          : colorScheme.surfaceContainer;
      shadowColor = colorScheme.outlineVariant;
      borderColor = colorScheme.outline;
      textColor = isBoss
          ? const Color(0xFFFFB800)
          : colorScheme.onSurfaceVariant.withValues(alpha: 0.5);
      iconWidget = Icon(
        Icons.lock_outline_rounded,
        size: 15,
        color: textColor,
      );
    }

    return TangibleCard(
      color: cardBg,
      shadowColor: shadowColor,
      borderColor: borderColor,
      borderRadius: 18,
      depth: 4.0,
      padding: EdgeInsets.zero,
      onTap: isClickable
          ? () async {
              AppHaptics.light();
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MathGameScreen(levelNumber: levelNumber),
                ),
              );
              ref.read(homeViewModelProvider.notifier).loadProgress();
            }
          : null,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isBoss && (isCompleted || isCurrent)) ...[
                  Icon(Icons.star_rounded, size: 13, color: textColor),
                  const SizedBox(width: 2),
                ],
                Text(
                  '$levelNumber',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: textColor,
                    height: 1.2,
                  ),
                ),
              ],
            ),
            if (isCompleted || isLocked || (isBoss && isCurrent)) ...[
              const SizedBox(height: 2),
              iconWidget,
            ],
          ],
        ),
      ),
    );
  }
}
