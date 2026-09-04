import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:learnmath/domain/models/math_problem.dart';
import 'package:learnmath/ui/core/services/app_haptics.dart';
import 'package:learnmath/ui/core/widgets/rich_math_visualizer.dart';
import 'package:learnmath/ui/core/widgets/scratchpad_modal.dart';
import 'package:learnmath/ui/core/widgets/step_explanation_modal.dart';
import 'package:learnmath/ui/core/widgets/tangible_button.dart';
import 'package:learnmath/ui/features/game/math_game/math_game_engine.dart';
import 'package:learnmath/ui/features/game/math_game/math_game_provider.dart';
import 'package:learnmath/ui/features/home/view_models/home_view_model.dart';

class MathGameScreen extends ConsumerStatefulWidget {
  const MathGameScreen({
    super.key,
    required this.levelNumber,
    this.isRandom = false,
    this.difficulty = MathDifficulty.medium,
    this.questionCount = 5,
    this.category,
    this.customProblems,
    this.customTitle,
    this.isDailyChallenge = false,
  });

  final int levelNumber;
  final bool isRandom;
  final MathDifficulty difficulty;
  final int questionCount;
  final MathCategory? category;
  final List<MathProblem>? customProblems;
  final String? customTitle;
  final bool isDailyChallenge;

  @override
  ConsumerState<MathGameScreen> createState() => _MathGameScreenState();
}

class _MathGameScreenState extends ConsumerState<MathGameScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 380),
      vsync: this,
    );
    _shakeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.easeInOut),
    );

    Future.microtask(() {
      ref.read(mathGameViewModelProvider.notifier).initGame(
            levelNumber: widget.levelNumber,
            isRandom: widget.isRandom,
            difficulty: widget.difficulty,
            category: widget.category,
            questionCount: widget.questionCount,
            customProblems: widget.customProblems,
          );
    });
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  void _openScratchpad() {
    AppHaptics.light();
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => const ScratchpadModal(),
      ),
    );
  }

  void _openExplanation(MathProblem problem) {
    AppHaptics.light();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => StepExplanationModal(problem: problem),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mathGameViewModelProvider);
    final notifier = ref.read(mathGameViewModelProvider.notifier);
    final isBoss = MathGameEngine.isBossLevel(widget.levelNumber) && !widget.isRandom;
    final problem = state.currentProblem;

    ref.listen<MathGameState>(mathGameViewModelProvider, (previous, next) {
      if (next.lastAnswerCorrect == false && previous?.lastAnswerCorrect != false) {
        AppHaptics.heavy();
        _shakeController.forward(from: 0.0);
      } else if (next.lastAnswerCorrect == true && previous?.lastAnswerCorrect != true) {
        AppHaptics.medium();
      }
      if (next.isSolved && !(previous?.isSolved ?? false)) {
        AppHaptics.heavy();
        if (widget.isDailyChallenge) {
          final now = DateTime.now();
          final today = '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
          ref.read(homeViewModelProvider.notifier).completeDailyChallenge(today);
        } else if (!widget.isRandom && widget.customProblems == null) {
          ref.read(homeViewModelProvider.notifier).completeLevel(widget.levelNumber);
        } else {
          ref.read(homeViewModelProvider.notifier).loadProgress();
        }
        _showCompletionDialog(next.correctCount, next.totalQuestions, next.earnedXp);
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildTopAppBar(context, isBoss, state, notifier),
            _buildSegmentedProgress(context, state),
            Expanded(
              child: AnimatedBuilder(
                animation: _shakeAnimation,
                builder: (context, child) {
                  final offset = math.sin(_shakeAnimation.value * math.pi * 4) * 8 * (1 - _shakeAnimation.value);
                  return Transform.translate(
                    offset: Offset(offset, 0),
                    child: child,
                  );
                },
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.04, 0.0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: problem == null
                      ? const Center(child: CircularProgressIndicator())
                      : _buildQuestionCard(
                          key: ValueKey(state.currentQuestionIndex),
                          context: context,
                          state: state,
                          problem: problem,
                          notifier: notifier,
                        ),
                ),
              ),
            ),
            if (problem != null)
              problem.inputType == ProblemInputType.multipleChoice
                  ? _buildMultipleChoiceArea(context, state, problem, notifier)
                  : _buildKeypadArea(context, state, notifier),
          ],
        ),
      ),
    );
  }

  Widget _buildTopAppBar(
    BuildContext context,
    bool isBoss,
    MathGameState state,
    MathGameViewModel notifier,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    String title;
    String subtitle;

    if (widget.customTitle != null) {
      title = widget.customTitle!;
      subtitle = 'Special Session';
    } else if (widget.isRandom) {
      title = 'Practice (${state.difficulty.name.toUpperCase()})';
      subtitle = state.category != null
          ? MathGameEngine.getCategoryName(state.category!)
          : 'Mixed Practice';
    } else {
      title = isBoss
          ? 'Boss Level ${widget.levelNumber}'
          : 'Level ${widget.levelNumber}';
      subtitle = MathGameEngine.getLevelTitle(widget.levelNumber);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton.filledTonal(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 16),
            onPressed: () => Navigator.pop(context),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isBoss) ...[
                      const Icon(Icons.workspace_premium_rounded,
                          size: 16, color: Color(0xFFFFB800)),
                      const SizedBox(width: 4),
                    ],
                    Flexible(
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: isBoss ? const Color(0xFFFFB800) : colorScheme.onSurface,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  subtitle,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isBoss
                        ? const Color(0xFFFFB800).withValues(alpha: 0.85)
                        : colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton.filledTonal(
                tooltip: 'Scratchpad',
                icon: const Icon(Icons.draw_rounded, size: 18),
                onPressed: _openScratchpad,
              ),
              const SizedBox(width: 6),
              IconButton.filledTonal(
                icon: const Icon(Icons.refresh_rounded, size: 18),
                onPressed: () {
                  AppHaptics.light();
                  notifier.restartLevel();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentedProgress(BuildContext context, MathGameState state) {
    final colorScheme = Theme.of(context).colorScheme;
    final total = state.totalQuestions == 0 ? 5 : state.totalQuestions;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Question ${state.currentQuestionIndex + 1} of $total',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              Row(
                children: [
                  if (state.streak > 1) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF97316).withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFF97316).withValues(alpha: 0.4),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.local_fire_department_rounded,
                            size: 14,
                            color: Color(0xFFF97316),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            '${state.streak} Streak',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFFF97316),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    '${state.correctCount}/$total',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (total <= 10)
            Row(
              children: List.generate(total, (index) {
                final isAnswered = index < state.currentQuestionIndex;
                final isCurrent = index == state.currentQuestionIndex;

                Color segmentColor = colorScheme.surfaceContainerHighest;
                if (isAnswered) {
                  segmentColor = colorScheme.primary;
                } else if (isCurrent) {
                  segmentColor = colorScheme.primary.withValues(alpha: 0.4);
                }

                return Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    height: 6,
                    margin: EdgeInsets.only(right: index == total - 1 ? 0 : 6),
                    decoration: BoxDecoration(
                      color: segmentColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                );
              }),
            )
          else
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: total > 0 ? (state.currentQuestionIndex / total) : 0.0,
                minHeight: 6,
                backgroundColor: colorScheme.surfaceContainerHighest,
                valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard({
    required Key key,
    required BuildContext context,
    required MathGameState state,
    required MathProblem problem,
    required MathGameViewModel notifier,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Color cardBorderColor = colorScheme.outlineVariant.withValues(alpha: 0.35);
    Color cardBg = colorScheme.surfaceContainer;

    if (state.isChecking) {
      if (state.lastAnswerCorrect == true) {
        cardBorderColor = const Color(0xFF10B981);
        cardBg = const Color(0xFF10B981).withValues(alpha: 0.15);
      } else if (state.lastAnswerCorrect == false) {
        cardBorderColor = colorScheme.error;
        cardBg = colorScheme.errorContainer.withValues(alpha: 0.2);
      }
    }

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: cardBorderColor, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _getCategoryIcon(problem.category),
                          size: 13,
                          color: colorScheme.onPrimaryContainer,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          MathGameEngine.getCategoryName(problem.category),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: colorScheme.onPrimaryContainer,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (ref.watch(homeViewModelProvider).progress?.showStepExplanation ?? true)
                    IconButton(
                      visualDensity: VisualDensity.compact,
                      tooltip: 'Explain Step',
                      icon: Icon(
                        Icons.help_outline_rounded,
                        size: 20,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      onPressed: () => _openExplanation(problem),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                problem.prompt,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: problem.prompt.length > 15 ? 26 : 34,
                  fontWeight: FontWeight.w800,
                  color: colorScheme.onSurface,
                  letterSpacing: -0.5,
                  height: 1.2,
                ),
              ),
              if (problem.subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  problem.subtitle!,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.3,
                  ),
                ),
              ],
              const SizedBox(height: 12),
              RichMathVisualizer(problem: problem),
              if (problem.inputType == ProblemInputType.numberPad) ...[
                const SizedBox(height: 14),
                _buildAnswerBox(context, state),
              ],
            ],
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(MathCategory category) {
    switch (category) {
      case MathCategory.concepts:
        return Icons.lightbulb_outline_rounded;
      case MathCategory.addition:
        return Icons.add_rounded;
      case MathCategory.subtraction:
        return Icons.remove_rounded;
      case MathCategory.multiplication:
        return Icons.close_rounded;
      case MathCategory.division:
        return Icons.percent_rounded;
      case MathCategory.powersRoots:
        return Icons.superscript_rounded;
      case MathCategory.master:
        return Icons.auto_awesome_rounded;
    }
  }

  Widget _buildAnswerBox(BuildContext context, MathGameState state) {
    final colorScheme = Theme.of(context).colorScheme;
    final hasInput = state.currentInput.isNotEmpty;

    Color boxBorder = hasInput
        ? colorScheme.primary
        : colorScheme.outlineVariant.withValues(alpha: 0.6);

    if (state.isChecking) {
      boxBorder = state.lastAnswerCorrect == true
          ? const Color(0xFF10B981)
          : colorScheme.error;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: boxBorder, width: 2.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            hasInput ? state.currentInput : '?',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: hasInput
                  ? colorScheme.onSurface
                  : colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
              letterSpacing: 2.0,
              height: 1.1,
            ),
          ),
          if (hasInput && !state.isChecking) ...[
            const SizedBox(width: 2),
            Container(
              width: 2.5,
              height: 24,
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMultipleChoiceArea(
    BuildContext context,
    MathGameState state,
    MathProblem problem,
    MathGameViewModel notifier,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 6, 20, 14),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 2.3,
        ),
        itemCount: problem.options.length,
        itemBuilder: (context, index) {
          final option = problem.options[index];
          final isSelected = state.selectedOption == option;

          Color tileBg = colorScheme.surfaceContainer;
          Color borderColor = colorScheme.outlineVariant.withValues(alpha: 0.5);
          Color textColor = colorScheme.onSurface;

          if (isSelected && state.isChecking) {
            if (state.lastAnswerCorrect == true) {
              tileBg = const Color(0xFF10B981).withValues(alpha: 0.2);
              borderColor = const Color(0xFF10B981);
              textColor = const Color(0xFF10B981);
            } else {
              tileBg = colorScheme.errorContainer;
              borderColor = colorScheme.error;
              textColor = colorScheme.onErrorContainer;
            }
          }

          return Material(
            color: tileBg,
            borderRadius: BorderRadius.circular(18),
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: state.isChecking
                  ? null
                  : () {
                      AppHaptics.light();
                      notifier.selectOption(option);
                    },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: borderColor, width: 1.5),
                ),
                alignment: Alignment.center,
                child: Text(
                  option,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                    height: 1.2,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildKeypadArea(
    BuildContext context,
    MathGameState state,
    MathGameViewModel notifier,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 2, 20, 10),
      child: Column(
        children: [
          Row(
            children: [
              _keypadButton(context, '1', () => notifier.appendDigit('1')),
              const SizedBox(width: 8),
              _keypadButton(context, '2', () => notifier.appendDigit('2')),
              const SizedBox(width: 8),
              _keypadButton(context, '3', () => notifier.appendDigit('3')),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _keypadButton(context, '4', () => notifier.appendDigit('4')),
              const SizedBox(width: 8),
              _keypadButton(context, '5', () => notifier.appendDigit('5')),
              const SizedBox(width: 8),
              _keypadButton(context, '6', () => notifier.appendDigit('6')),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _keypadButton(context, '7', () => notifier.appendDigit('7')),
              const SizedBox(width: 8),
              _keypadButton(context, '8', () => notifier.appendDigit('8')),
              const SizedBox(width: 8),
              _keypadButton(context, '9', () => notifier.appendDigit('9')),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _keypadButton(
                context,
                '⌫',
                () => notifier.deleteDigit(),
                textColor: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(width: 8),
              _keypadButton(context, '0', () => notifier.appendDigit('0')),
              const SizedBox(width: 8),
              _keypadButton(
                context,
                '✓',
                () {
                  AppHaptics.medium();
                  notifier.submitInput();
                },
                isPrimary: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _keypadButton(
    BuildContext context,
    String label,
    VoidCallback onTap, {
    bool isPrimary = false,
    Color? textColor,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Expanded(
      child: Material(
        color: isPrimary
            ? colorScheme.primary
            : colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            AppHaptics.light();
            onTap();
          },
          child: Container(
            height: 46,
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: isPrimary
                    ? colorScheme.onPrimary
                    : (textColor ?? colorScheme.onSurface),
                height: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showCompletionDialog(int score, int total, int xpEarned) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isPerfect = score == total;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: colorScheme.surfaceContainerHigh,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        title: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: isPerfect
                    ? const Color(0xFFFFB800).withValues(alpha: 0.2)
                    : colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  isPerfect
                      ? Icons.emoji_events_rounded
                      : Icons.check_circle_rounded,
                  size: 32,
                  color: isPerfect
                      ? const Color(0xFFFFB800)
                      : colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.customTitle != null
                  ? '${widget.customTitle} Complete!'
                  : (widget.isRandom
                      ? 'Practice Complete!'
                      : (isPerfect ? 'Perfect Score!' : 'Level Complete!')),
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'You solved $score of $total questions correctly.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.4,
              ),
            ),
            if (xpEarned > 0) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFF59E0B).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFF59E0B).withValues(alpha: 0.4),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.bolt_rounded, color: Color(0xFFF59E0B), size: 18),
                    const SizedBox(width: 4),
                    Text(
                      '+$xpEarned XP Earned',
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Color(0xFFF59E0B),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 20),
            if (!widget.isRandom && widget.customProblems == null) ...[
              TangibleButton(
                text: 'Next Level',
                height: 48,
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MathGameScreen(
                        levelNumber: widget.levelNumber + 1,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
            ],
            if (widget.isRandom) ...[
              TangibleButton(
                text: 'New Practice',
                height: 48,
                onPressed: () {
                  Navigator.pop(context);
                  ref.read(mathGameViewModelProvider.notifier).initGame(
                        levelNumber: widget.levelNumber,
                        isRandom: true,
                        difficulty: widget.difficulty,
                        category: widget.category,
                        questionCount: widget.questionCount,
                      );
                },
              ),
              const SizedBox(height: 10),
              TangibleButton(
                text: 'Home',
                isSecondary: true,
                height: 48,
                icon: Icons.home_rounded,
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ] else ...[
              TangibleButton(
                text: 'Home',
                isSecondary: true,
                height: 48,
                icon: Icons.home_rounded,
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
            const SizedBox(height: 10),
            TangibleButton(
              text: 'Buy Me a Coffee',
              isSecondary: true,
              height: 48,
              icon: Icons.favorite_rounded,
              onPressed: () async {
                final Uri url = Uri.parse('https://ko-fi.com/sidhant947');
                try {
                  final launched = await launchUrl(
                    url,
                    mode: LaunchMode.externalApplication,
                  );
                  if (!launched) {
                    await launchUrl(url);
                  }
                } catch (_) {
                  await launchUrl(url);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
