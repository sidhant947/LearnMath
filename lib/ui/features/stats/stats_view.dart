import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnmath/domain/models/badge_item.dart';
import 'package:learnmath/domain/models/math_problem.dart';
import 'package:learnmath/domain/models/user_progress.dart';
import 'package:learnmath/ui/core/widgets/tangible_button.dart';
import 'package:learnmath/ui/features/game/math_game/math_game_screen.dart';
import 'package:learnmath/ui/features/home/view_models/home_view_model.dart';

class StatsView extends ConsumerWidget {
  const StatsView({super.key});

  String _getPlayerTitle(int level) {
    if (level < 5) return 'Math Novice';
    if (level < 15) return 'Apprentice';
    if (level < 30) return 'Mathlete';
    if (level < 50) return 'Arithmetic Master';
    return 'Grandmaster';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModelProvider);
    final progress = state.progress ?? const UserProgress();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics & Achievements'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          children: [
            _buildXpCard(context, progress),
            const SizedBox(height: 16),
            _buildQuickStats(context, progress),
            const SizedBox(height: 16),
            _buildWeakSpotCard(context, progress, ref),
            const SizedBox(height: 16),
            _buildCategoryBreakdown(context, progress),
            const SizedBox(height: 20),
            _buildBadgesSection(context, progress),
          ],
        ),
      ),
    );
  }

  Widget _buildXpCard(BuildContext context, UserProgress progress) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final playerLvl = progress.playerLevel;
    final title = _getPlayerTitle(playerLvl);

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFF59E0B).withValues(alpha: 0.25),
          width: 1.5,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -24,
            top: -24,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFF59E0B).withValues(alpha: 0.12),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFBBF24), Color(0xFFD97706)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFF59E0B).withValues(alpha: 0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.military_tech_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Level $playerLvl',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w900,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF59E0B).withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    title,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFFF59E0B),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '${progress.totalXp} Total XP Earned',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Level Progress',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      '${progress.currentLevelXp} / 100 XP',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFFF59E0B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress.playerLevelProgress,
                    minHeight: 10,
                    backgroundColor: colorScheme.surfaceContainerHighest,
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFF59E0B)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats(BuildContext context, UserProgress progress) {
    final colorScheme = Theme.of(context).colorScheme;
    final accuracy = (progress.overallAccuracy * 100).toStringAsFixed(0);

    return Row(
      children: [
        Expanded(
          child: _statTile(
            context,
            title: 'Accuracy',
            value: '$accuracy%',
            icon: Icons.track_changes_rounded,
            color: const Color(0xFF10B981),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _statTile(
            context,
            title: 'Solved',
            value: '${progress.totalSolved}',
            icon: Icons.check_circle_outline_rounded,
            color: colorScheme.primary,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _statTile(
            context,
            title: 'Streak',
            value: '${progress.dailyStreak}d',
            icon: Icons.local_fire_department_rounded,
            color: const Color(0xFFF97316),
          ),
        ),
      ],
    );
  }

  Widget _statTile(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeakSpotCard(
    BuildContext context,
    UserProgress progress,
    WidgetRef ref,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    String? lowestCategory;
    double lowestAcc = 1.0;

    for (final cat in MathCategory.values) {
      final solved = progress.categorySolvedCount[cat.name] ?? 0;
      final correct = progress.categoryCorrectCount[cat.name] ?? 0;
      if (solved >= 3) {
        final acc = correct / solved;
        if (acc < lowestAcc) {
          lowestAcc = acc;
          lowestCategory = cat.name;
        }
      }
    }

    if (lowestCategory == null && progress.savedMistakes.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.errorContainer.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colorScheme.error.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.radar_rounded, color: colorScheme.error, size: 20),
              const SizedBox(width: 8),
              Text(
                'Focus Recommendation',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                  color: colorScheme.error,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            lowestCategory != null
                ? 'Accuracy on ${lowestCategory.toUpperCase()} is ${(lowestAcc * 100).toStringAsFixed(0)}%. Practice this area to level up faster!'
                : 'You have ${progress.savedMistakes.length} mistakes saved for review.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurface,
              height: 1.35,
            ),
          ),
          if (progress.savedMistakes.isNotEmpty) ...[
            const SizedBox(height: 12),
            TangibleButton(
              text: 'Review Mistakes (${progress.savedMistakes.length})',
              height: 42,
              onPressed: () async {
                final mistakeProblems = progress.savedMistakes.map((m) {
                  final parts = m.split(' = ');
                  final prompt = parts[0];
                  final answer = parts.length > 1 ? parts[1] : '0';
                  
                  MathCategory cat = MathCategory.addition;
                  if (prompt.contains('+')) {
                    cat = MathCategory.addition;
                  } else if (prompt.contains('−') || prompt.contains('-')) {
                    cat = MathCategory.subtraction;
                  } else if (prompt.contains('×') || prompt.contains('*') || prompt.contains('x')) {
                    cat = MathCategory.multiplication;
                  } else if (prompt.contains('÷') || prompt.contains('/')) {
                    cat = MathCategory.division;
                  } else if (prompt.contains('^') || prompt.contains('√')) {
                    cat = MathCategory.powersRoots;
                  }

                  return MathProblem(
                    title: 'Mistake Review',
                    prompt: prompt,
                    correctAnswer: answer,
                    category: cat,
                    inputType: ProblemInputType.numberPad,
                  );
                }).toList();

                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MathGameScreen(
                      levelNumber: 1,
                      customProblems: mistakeProblems,
                      customTitle: 'Mistakes Drill',
                    ),
                  ),
                );
                ref.read(homeViewModelProvider.notifier).loadProgress();
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCategoryBreakdown(BuildContext context, UserProgress progress) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mastery Breakdown',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 14),
          ...MathCategory.values.where((c) => c != MathCategory.master).map((category) {
            final solved = progress.categorySolvedCount[category.name] ?? 0;
            final correct = progress.categoryCorrectCount[category.name] ?? 0;
            final acc = solved > 0 ? (correct / solved) : 0.0;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        category.name.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        solved > 0 ? '${(acc * 100).toStringAsFixed(0)}% ($correct/$solved)' : 'Unplayed',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: acc,
                      minHeight: 6,
                      backgroundColor: colorScheme.surfaceContainerHighest,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        acc > 0.8
                            ? const Color(0xFF10B981)
                            : (acc > 0.5 ? const Color(0xFFF59E0B) : colorScheme.primary),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildBadgesSection(BuildContext context, UserProgress progress) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final allBadges = BadgeItem.allBadges;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Achievements (${progress.unlockedBadges.length}/${allBadges.length})',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.4,
          ),
          itemCount: allBadges.length,
          itemBuilder: (context, index) {
            final badge = allBadges[index];
            final isUnlocked = progress.unlockedBadges.contains(badge.id);

            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isUnlocked ? colorScheme.surfaceContainerHigh : colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: isUnlocked ? badge.accentColor.withValues(alpha: 0.5) : colorScheme.outlineVariant.withValues(alpha: 0.3),
                  width: 1.2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        badge.icon,
                        color: isUnlocked ? badge.accentColor : colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
                        size: 24,
                      ),
                      if (isUnlocked)
                        const Icon(Icons.check_circle_rounded, color: Color(0xFF10B981), size: 16)
                      else
                        Icon(Icons.lock_outline_rounded, color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4), size: 16),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    badge.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: isUnlocked ? colorScheme.onSurface : colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                    ),
                  ),
                  Text(
                    badge.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurfaceVariant,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
