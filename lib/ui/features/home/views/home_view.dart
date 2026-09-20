import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:learnmath/domain/models/math_problem.dart';
import 'package:learnmath/domain/models/user_progress.dart';
import 'package:learnmath/ui/core/services/app_haptics.dart';
import 'package:learnmath/ui/core/widgets/tangible_button.dart';
import 'package:learnmath/ui/core/widgets/tangible_card.dart';
import 'package:learnmath/ui/features/game/math_game/math_game_engine.dart';
import 'package:learnmath/ui/features/game/math_game/math_game_screen.dart';
import 'package:learnmath/ui/features/home/view_models/home_view_model.dart';
import 'package:learnmath/ui/features/level_select/views/level_select_view.dart';
import 'package:learnmath/ui/features/modes/duel/duel_screen.dart';
import 'package:learnmath/ui/features/modes/survival/survival_screen.dart';
import 'package:learnmath/ui/features/modes/target24/target24_screen.dart';
import 'package:learnmath/ui/features/modes/time_attack/time_attack_screen.dart';
import 'package:learnmath/ui/features/settings/views/settings_view.dart';
import 'package:learnmath/ui/features/stats/stats_view.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(homeViewModelProvider.notifier).loadProgress(),
    );
  }

  String _todayDateString() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  void _startDailyChallenge(UserProgress progress) async {
    final problems = MathGameEngine.generateDailyProblems(DateTime.now());

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MathGameScreen(
          levelNumber: 1,
          customProblems: problems,
          customTitle: 'Daily Challenge',
          isDailyChallenge: true,
        ),
      ),
    );
    if (mounted) {
      ref.read(homeViewModelProvider.notifier).loadProgress();
    }
  }

  void _showGameModesSheet(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 580),
          child: Container(
            decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHigh,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          border: Border.all(color: colorScheme.outline, width: 2),
        ),
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 5,
                  decoration: BoxDecoration(
                    color: colorScheme.outline,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Special Game Modes',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 14),
              _modeTile(
                title: 'Time Attack Blitz',
                subtitle: '60 seconds speed rush with +2s time bonus per correct answer',
                icon: Icons.timer_rounded,
                color: const Color(0xFF8B5CF6),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TimeAttackScreen()),
                  ).then((_) => ref.read(homeViewModelProvider.notifier).loadProgress());
                },
              ),
              const SizedBox(height: 10),
              _modeTile(
                title: 'Endless Survival',
                subtitle: '3 Hearts. Increasing difficulty. How far can you survive?',
                icon: Icons.favorite_rounded,
                color: const Color(0xFFEC4899),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SurvivalScreen()),
                  ).then((_) => ref.read(homeViewModelProvider.notifier).loadProgress());
                },
              ),
              const SizedBox(height: 10),
              _modeTile(
                title: '2-Player Split-Screen Duel',
                subtitle: 'Race a friend head-to-head on the same screen to 10 points',
                icon: Icons.sports_kabaddi_rounded,
                color: const Color(0xFFF97316),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const DuelScreen()),
                  );
                },
              ),
              const SizedBox(height: 10),
              _modeTile(
                title: 'Target 24 Puzzle',
                subtitle: 'Use 4 numbers and operations to build an equation that equals 24',
                icon: Icons.extension_rounded,
                color: const Color(0xFF06B6D4),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const Target24Screen()),
                  ).then((_) => ref.read(homeViewModelProvider.notifier).loadProgress());
                },
              ),
            ],
          ),
        ),
      ),
    ),
  ),
);
  }

  Widget _modeTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return TangibleCard(
      onTap: onTap,
      depth: 3.5,
      borderRadius: 18,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white24, width: 1.5),
            ),
            child: Center(
              child: Icon(icon, color: Colors.white, size: 22),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurfaceVariant,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: colorScheme.onSurfaceVariant),
        ],
      ),
    );
  }

  void _showPracticeDialog(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final screenHeight = MediaQuery.sizeOf(context).height;

    MathDifficulty selectedDifficulty = MathDifficulty.medium;
    int selectedQuestions = 10;
    MathCategory? selectedCategory;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            Color diffColor;
            String diffName;
            switch (selectedDifficulty) {
              case MathDifficulty.easy:
                diffColor = const Color(0xFF10B981);
                diffName = 'EASY';
                break;
              case MathDifficulty.medium:
                diffColor = const Color(0xFFF59E0B);
                diffName = 'MEDIUM';
                break;
              case MathDifficulty.hard:
                diffColor = const Color(0xFFEF4444);
                diffName = 'HARD';
                break;
            }

            return Dialog(
              backgroundColor: colorScheme.surfaceContainerHigh,
              insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
                side: BorderSide(color: colorScheme.outline, width: 2),
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: screenHeight * 0.88,
                  maxWidth: 440,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Practice Setup',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w900,
                              fontSize: 22,
                            ),
                          ),
                          IconButton(
                            visualDensity: VisualDensity.compact,
                            icon: const Icon(Icons.close_rounded, size: 22),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Flexible(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'DIFFICULTY',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w800,
                                      color: colorScheme.onSurfaceVariant,
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      color: diffColor.withValues(alpha: 0.18),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: diffColor,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Text(
                                      diffName,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: diffColor,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  trackHeight: 6,
                                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
                                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 18),
                                ),
                                child: Slider(
                                  value: selectedDifficulty.index.toDouble(),
                                  min: 0,
                                  max: 2,
                                  divisions: 2,
                                  activeColor: diffColor,
                                  onChanged: (val) {
                                    final newDiff = MathDifficulty.values[val.round()];
                                    if (newDiff != selectedDifficulty) {
                                      AppHaptics.selection();
                                      setModalState(() {
                                        selectedDifficulty = newDiff;
                                      });
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'QUESTIONS',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w800,
                                      color: colorScheme.onSurfaceVariant,
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      color: colorScheme.primaryContainer,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: colorScheme.primary, width: 1.5),
                                    ),
                                    child: Text(
                                      '$selectedQuestions Questions',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                        color: colorScheme.onPrimaryContainer,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  trackHeight: 6,
                                  thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
                                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 18),
                                ),
                                child: Slider(
                                  value: selectedQuestions.toDouble(),
                                  min: 5,
                                  max: 50,
                                  divisions: 9,
                                  activeColor: colorScheme.primary,
                                  onChanged: (val) {
                                    final newQ = val.round();
                                    if (newQ != selectedQuestions) {
                                      AppHaptics.selection();
                                      setModalState(() {
                                        selectedQuestions = newQ;
                                      });
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'CATEGORY',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: colorScheme.onSurfaceVariant,
                                  letterSpacing: 0.8,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 6,
                                runSpacing: 6,
                                children: [
                                  _categoryChip(
                                    title: 'All Mixed',
                                    isSelected: selectedCategory == null,
                                    onTap: () {
                                      AppHaptics.selection();
                                      setModalState(() => selectedCategory = null);
                                    },
                                    colorScheme: colorScheme,
                                  ),
                                  _categoryChip(
                                    title: 'Addition',
                                    isSelected: selectedCategory == MathCategory.addition,
                                    onTap: () {
                                      AppHaptics.selection();
                                      setModalState(
                                          () => selectedCategory = MathCategory.addition);
                                    },
                                    colorScheme: colorScheme,
                                  ),
                                  _categoryChip(
                                    title: 'Subtraction',
                                    isSelected: selectedCategory == MathCategory.subtraction,
                                    onTap: () {
                                      AppHaptics.selection();
                                      setModalState(
                                          () => selectedCategory = MathCategory.subtraction);
                                    },
                                    colorScheme: colorScheme,
                                  ),
                                  _categoryChip(
                                    title: 'Multiplication',
                                    isSelected: selectedCategory == MathCategory.multiplication,
                                    onTap: () {
                                      AppHaptics.selection();
                                      setModalState(
                                          () => selectedCategory = MathCategory.multiplication);
                                    },
                                    colorScheme: colorScheme,
                                  ),
                                  _categoryChip(
                                    title: 'Division',
                                    isSelected: selectedCategory == MathCategory.division,
                                    onTap: () {
                                      AppHaptics.selection();
                                      setModalState(
                                          () => selectedCategory = MathCategory.division);
                                    },
                                    colorScheme: colorScheme,
                                  ),
                                  _categoryChip(
                                    title: 'Powers & Roots',
                                    isSelected: selectedCategory == MathCategory.powersRoots,
                                    onTap: () {
                                      AppHaptics.selection();
                                      setModalState(
                                          () => selectedCategory = MathCategory.powersRoots);
                                    },
                                    colorScheme: colorScheme,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TangibleButton(
                        text: 'Start Practice',
                        height: 52,
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MathGameScreen(
                                levelNumber: 1,
                                isRandom: true,
                                difficulty: selectedDifficulty,
                                questionCount: selectedQuestions,
                                category: selectedCategory,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _categoryChip({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
    required ColorScheme colorScheme,
  }) {
    return ChoiceChip(
      label: Text(title),
      selected: isSelected,
      onSelected: (_) => onTap(),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
      labelPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      labelStyle: TextStyle(
        fontSize: 12,
        fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
        color: isSelected ? colorScheme.onPrimary : colorScheme.onSurfaceVariant,
      ),
      selectedColor: colorScheme.primary,
      backgroundColor: colorScheme.surfaceContainerHighest,
      showCheckmark: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? colorScheme.primary : colorScheme.outline,
          width: 1.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeViewModelProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final progress = state.progress ?? const UserProgress();
    final today = _todayDateString();
    final isDailyDone = progress.lastDailyDate == today;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 540),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton.filledTonal(
                        icon: const Icon(Icons.insights_rounded, size: 20),
                        onPressed: () {
                          AppHaptics.light();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const StatsView()),
                          ).then((_) => ref.read(homeViewModelProvider.notifier).loadProgress());
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          AppHaptics.light();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const StatsView()),
                          ).then((_) => ref.read(homeViewModelProvider.notifier).loadProgress());
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceContainerHigh,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: colorScheme.outline,
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.bolt_rounded, color: Color(0xFFF59E0B), size: 18),
                              const SizedBox(width: 4),
                              Text(
                                'Level ${progress.playerLevel}',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  color: colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF97316).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFFF97316),
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.local_fire_department_rounded, color: Color(0xFFF97316), size: 16),
                            const SizedBox(width: 3),
                            Text(
                              '${progress.dailyStreak}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFFF97316),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(flex: 2),

                  Text(
                    'Learn Math',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: colorScheme.onSurface,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Think fast, solve smart',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const Spacer(flex: 3),

                  TangibleButton(
                    text: 'Play',
                    height: 58,
                    onPressed: state.isLoading
                        ? null
                        : () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MathGameScreen(
                                  levelNumber: progress.currentLevel,
                                ),
                              ),
                            );
                            ref.read(homeViewModelProvider.notifier).loadProgress();
                          },
                  ),

                  const SizedBox(height: 12),

                  TangibleButton(
                    text: 'Daily Challenge',
                    isSecondary: true,
                    height: 54,
                    icon: isDailyDone ? Icons.check_circle_rounded : Icons.calendar_today_rounded,
                    onPressed: isDailyDone ? null : () => _startDailyChallenge(progress),
                  ),

                  const SizedBox(height: 12),

                  TangibleButton(
                    text: 'Levels',
                    isSecondary: true,
                    height: 54,
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LevelSelectView(),
                        ),
                      );
                      ref.read(homeViewModelProvider.notifier).loadProgress();
                    },
                  ),

                  const SizedBox(height: 12),

                  TangibleButton(
                    text: 'Game Modes',
                    isSecondary: true,
                    height: 54,
                    icon: Icons.sports_esports_rounded,
                    onPressed: () => _showGameModesSheet(context),
                  ),

                  const SizedBox(height: 12),

                  TangibleButton(
                    text: 'Practice Mode',
                    isSecondary: true,
                    height: 54,
                    icon: Icons.tune_rounded,
                    onPressed: () => _showPracticeDialog(context),
                  ),

                  const SizedBox(height: 12),

                  TangibleButton(
                    text: 'Settings',
                    isSecondary: true,
                    height: 54,
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SettingsView()),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
