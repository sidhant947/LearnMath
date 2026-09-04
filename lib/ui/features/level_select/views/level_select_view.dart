import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:learnmath/ui/core/services/app_haptics.dart';
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
        title: const Text('Levels'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: GridView.builder(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
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
    Widget iconWidget;

    if (isCompleted) {
      cardBg = isBoss
          ? const Color(0xFFD97706)
          : colorScheme.primaryContainer;
      textColor = isBoss ? Colors.white : colorScheme.onPrimaryContainer;
      iconWidget = Icon(
        Icons.check_circle_rounded,
        size: 14,
        color: textColor,
      );
    } else if (isCurrent) {
      cardBg = isBoss ? const Color(0xFFFFB800) : colorScheme.primary;
      textColor = isBoss ? Colors.black87 : colorScheme.onPrimary;
      iconWidget = isBoss
          ? const Icon(Icons.workspace_premium_rounded, size: 15, color: Colors.black87)
          : const SizedBox.shrink();
    } else {
      cardBg = isBoss
          ? const Color(0xFFFFB800).withValues(alpha: 0.12)
          : colorScheme.surfaceContainer;
      textColor = isBoss ? const Color(0xFFFFB800) : colorScheme.onSurfaceVariant.withValues(alpha: 0.5);
      iconWidget = Icon(
        Icons.lock_outline_rounded,
        size: 15,
        color: textColor,
      );
    }

    return Card(
      color: cardBg,
      elevation: isCurrent ? 2 : 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isCurrent
              ? (isBoss ? const Color(0xFFFFB800) : colorScheme.primary)
              : colorScheme.outlineVariant.withValues(alpha: 0.3),
          width: isCurrent ? 1.5 : 1.0,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
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
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                    height: 1.2,
                  ),
                ),
              ],
            ),
            if (iconWidget is! SizedBox) ...[
              const SizedBox(height: 3),
              iconWidget,
            ],
          ],
        ),
      ),
    );
  }
}
