import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnmath/domain/models/badge_item.dart';
import 'package:learnmath/domain/models/math_problem.dart';
import 'package:learnmath/domain/models/user_progress.dart';
import 'package:learnmath/ui/core/widgets/tangible_button.dart';
import 'package:learnmath/ui/core/widgets/tangible_card.dart';
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
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 750),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
              children: [
                _buildXpCard(context, progress),
                const SizedBox(height: 16),
                _buildQuickStats(context, progress),
                const SizedBox(height: 16),
                _buildWeakSpotCard(context, progress, ref),
                const SizedBox(height: 16),
                _buildCategoryBreakdown(context, progress),
                const SizedBox(height: 24),
                _buildBadgesSection(context, progress),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildXpCard(BuildContext context, UserProgress progress) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final playerLvl = progress.playerLevel;
    final title = _getPlayerTitle(playerLvl);

    return TangibleCard(
      color: colorScheme.surfaceContainer,
      borderColor: const Color(0xFFF59E0B),
      shadowColor: const Color(0xFFB45309),
      borderRadius: 24,
      depth: 4.5,
      padding: const EdgeInsets.all(18),
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
                    const Color(0xFFF59E0B).withValues(alpha: 0.15),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFBBF24), Color(0xFFD97706)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFFDE68A), width: 1.5),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.military_tech_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
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
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF59E0B).withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: const Color(0xFFF59E0B),
                                    width: 1.2,
                                  ),
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
                            fontWeight: FontWeight.w700,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Level Progress',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    '${progress.currentLevelXp} / 100 XP',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFF59E0B),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: colorScheme.outline, width: 1.5),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress.playerLevelProgress,
                    minHeight: 10,
                    backgroundColor: colorScheme.surfaceContainerHighest,
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFF59E0B)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats(BuildContext context, UserProgress progress) {
    final colorScheme = Theme.of(context).colorScheme;
    final accuracy = (progress.overallAccuracy * 100).toStringAsFixed(0);

    return Column(
      children: [
        _statTile(
          context,
          title: 'Accuracy',
          value: '$accuracy%',
          subtitle: 'Overall problem solving accuracy',
          icon: Icons.track_changes_rounded,
          color: const Color(0xFF10B981),
          shadowColor: const Color(0xFF047857),
        ),
        const SizedBox(height: 10),
        _statTile(
          context,
          title: 'Solved Problems',
          value: '${progress.totalSolved}',
          subtitle: 'Total math problems completed',
          icon: Icons.check_circle_outline_rounded,
          color: colorScheme.primary,
          shadowColor: const Color(0xFF047857),
        ),
        const SizedBox(height: 10),
        _statTile(
          context,
          title: 'Daily Streak',
          value: '${progress.dailyStreak} Days',
          subtitle: 'Consecutive active practice days',
          icon: Icons.local_fire_department_rounded,
          color: const Color(0xFFF97316),
          shadowColor: const Color(0xFFC2410C),
        ),
      ],
    );
  }

  Widget _statTile(
    BuildContext context, {
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Color shadowColor,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return TangibleCard(
      color: colorScheme.surfaceContainer,
      borderColor: color,
      shadowColor: shadowColor,
      borderRadius: 18,
      depth: 3.5,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: color.withValues(alpha: 0.4), width: 1.2),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: color,
              letterSpacing: -0.5,
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

    return TangibleCard(
      color: colorScheme.errorContainer.withValues(alpha: 0.35),
      borderColor: colorScheme.error,
      shadowColor: const Color(0xFF991B1B),
      borderRadius: 20,
      depth: 4.0,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.radar_rounded, color: colorScheme.error, size: 22),
              const SizedBox(width: 8),
              Text(
                'Focus Recommendation',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 15,
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
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface,
              fontWeight: FontWeight.w600,
              height: 1.35,
            ),
          ),
          if (progress.savedMistakes.isNotEmpty) ...[
            const SizedBox(height: 14),
            TangibleButton(
              text: 'Review Mistakes (${progress.savedMistakes.length})',
              height: 48,
              color: colorScheme.error,
              shadowColor: const Color(0xFF991B1B),
              onPressed: () async {
                final mistakeProblems = <MathProblem>[];
                for (final m in progress.savedMistakes) {
                  if (m.trim().isEmpty) continue;
                  final parts = m.split(' = ').map((s) => s.trim()).toList();
                  if (parts.length < 2) continue;

                  final answer = parts.last;
                  if (answer == '?' || answer.isEmpty) continue;

                  String prompt;
                  if (parts.length > 2 && parts[parts.length - 2] == '?') {
                    prompt = '${parts.sublist(0, parts.length - 2).join(' = ')} = ?';
                  } else {
                    prompt = parts.sublist(0, parts.length - 1).join(' = ');
                    if (!prompt.endsWith('?') && !prompt.endsWith(':') && !prompt.contains('=')) {
                      prompt = '$prompt = ?';
                    }
                  }

                  MathCategory cat = MathCategory.concepts;
                  if (prompt.contains('+')) {
                    cat = MathCategory.addition;
                  } else if (prompt.contains('−') || prompt.contains('-')) {
                    cat = MathCategory.subtraction;
                  } else if (prompt.contains('×') || prompt.contains('*') || prompt.contains('x')) {
                    cat = MathCategory.multiplication;
                  } else if (prompt.contains('÷') || prompt.contains('/')) {
                    cat = MathCategory.division;
                  } else if (prompt.contains('^') || prompt.contains('√') || prompt.contains('²') || prompt.contains('³') || prompt.contains('⁴')) {
                    cat = MathCategory.powersRoots;
                  }

                  ProblemInputType inputType = ProblemInputType.numberPad;
                  List<String> options = const [];
                  if (answer == 'Even' || answer == 'Odd') {
                    inputType = ProblemInputType.multipleChoice;
                    options = const ['Even', 'Odd'];
                  } else if (int.tryParse(answer) == null && double.tryParse(answer) == null) {
                    inputType = ProblemInputType.multipleChoice;
                    options = [answer, '0', '1', '2'];
                  }

                  mistakeProblems.add(
                    MathProblem(
                      title: 'Mistake Review',
                      prompt: prompt,
                      correctAnswer: answer,
                      category: cat,
                      inputType: inputType,
                      options: options,
                    ),
                  );
                }

                if (mistakeProblems.isEmpty) return;

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

    return TangibleCard(
      color: colorScheme.surfaceContainer,
      borderColor: colorScheme.outline,
      borderRadius: 22,
      depth: 4.0,
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mastery Breakdown',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 14),
          ...MathCategory.values.where((c) => c != MathCategory.master).map((category) {
            final solved = progress.categorySolvedCount[category.name] ?? 0;
            final correct = progress.categoryCorrectCount[category.name] ?? 0;
            final acc = solved > 0 ? (correct / solved) : 0.0;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        category.name.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        solved > 0 ? '${(acc * 100).toStringAsFixed(0)}% ($correct/$solved)' : 'Unplayed',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: colorScheme.outline, width: 1.2),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: LinearProgressIndicator(
                        value: acc,
                        minHeight: 8,
                        backgroundColor: colorScheme.surfaceContainerHighest,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          acc > 0.8
                              ? const Color(0xFF10B981)
                              : (acc > 0.5 ? const Color(0xFFF59E0B) : colorScheme.primary),
                        ),
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
            fontWeight: FontWeight.w900,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 14),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            mainAxisExtent: 132,
          ),
          itemCount: allBadges.length,
          itemBuilder: (context, index) {
            final badge = allBadges[index];
            final isUnlocked = progress.unlockedBadges.contains(badge.id);

            return TangibleCard(
              color: isUnlocked
                  ? colorScheme.surfaceContainerHigh
                  : colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
              borderColor: isUnlocked
                  ? badge.accentColor
                  : colorScheme.outlineVariant,
              shadowColor: isUnlocked
                  ? HSLColor.fromColor(badge.accentColor)
                      .withLightness((HSLColor.fromColor(badge.accentColor).lightness - 0.2).clamp(0.0, 1.0))
                      .toColor()
                  : colorScheme.outlineVariant,
              borderRadius: 18,
              depth: 3.5,
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: isUnlocked
                              ? badge.accentColor.withValues(alpha: 0.18)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          badge.icon,
                          color: isUnlocked
                              ? badge.accentColor
                              : colorScheme.onSurfaceVariant.withValues(alpha: 0.35),
                          size: 22,
                        ),
                      ),
                      if (isUnlocked)
                        const Icon(Icons.check_circle_rounded, color: Color(0xFF10B981), size: 18)
                      else
                        Icon(Icons.lock_outline_rounded, color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4), size: 18),
                    ],
                  ),
                  const SizedBox(height: 8),
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
                  const SizedBox(height: 2),
                  Text(
                    badge.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
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
