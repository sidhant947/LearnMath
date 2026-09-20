import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnmath/domain/models/math_problem.dart';
import 'package:learnmath/ui/core/services/app_haptics.dart';
import 'package:learnmath/ui/core/widgets/tangible_button.dart';
import 'package:learnmath/ui/features/game/math_game/math_game_engine.dart';
import 'package:learnmath/ui/providers.dart';

class SurvivalScreen extends ConsumerStatefulWidget {
  const SurvivalScreen({super.key});

  @override
  ConsumerState<SurvivalScreen> createState() => _SurvivalScreenState();
}

class _SurvivalScreenState extends ConsumerState<SurvivalScreen> {
  int _lives = 3;
  int _round = 1;
  int _highScore = 0;
  String _currentInput = '';
  late MathProblem _currentProblem;
  bool _isGameOver = false;

  @override
  void initState() {
    super.initState();
    _loadHighScore();
    _nextProblem();
  }

  Future<void> _loadHighScore() async {
    final progress = await ref.read(progressRepositoryProvider).getProgress();
    if (mounted) {
      setState(() {
        _highScore = progress.survivalHighScore;
      });
    }
  }

  void _nextProblem() {
    _currentProblem = MathGameEngine.generateSingleDynamicProblem(_round);
    _currentInput = '';
  }

  void _onDigit(String digit) {
    if (_isGameOver || _currentInput.length >= 6) return;
    AppHaptics.light();
    setState(() {
      _currentInput += digit;
    });
  }

  void _onBackspace() {
    if (_isGameOver || _currentInput.isEmpty) return;
    AppHaptics.light();
    setState(() {
      _currentInput = _currentInput.substring(0, _currentInput.length - 1);
    });
  }

  void _onSubmit() {
    if (_isGameOver || _currentInput.isEmpty) return;

    final isCorrect = _currentInput.trim() == _currentProblem.correctAnswer.trim();
    if (isCorrect) {
      AppHaptics.medium();
      setState(() {
        _round++;
        _nextProblem();
      });
    } else {
      AppHaptics.heavy();
      setState(() {
        _lives--;
        _currentInput = '';
      });
      if (_lives <= 0) {
        _endGame();
      }
    }
  }

  void _onOptionTap(String option) {
    if (_isGameOver) return;
    final isCorrect = option.trim() == _currentProblem.correctAnswer.trim();
    if (isCorrect) {
      AppHaptics.medium();
      setState(() {
        _round++;
        _nextProblem();
      });
    } else {
      AppHaptics.heavy();
      setState(() {
        _lives--;
      });
      if (_lives <= 0) {
        _endGame();
      }
    }
  }

  void _endGame() {
    _isGameOver = true;
    AppHaptics.heavy();
    final completedRounds = _round - 1;
    ref.read(progressRepositoryProvider).recordSurvivalScore(completedRounds);
    _showGameOverDialog(completedRounds);
  }

  void _showGameOverDialog(int completedRounds) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isNewRecord = completedRounds > _highScore;

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
            Icon(
              isNewRecord ? Icons.emoji_events_rounded : Icons.heart_broken_rounded,
              size: 48,
              color: isNewRecord ? const Color(0xFFFFB800) : colorScheme.error,
            ),
            const SizedBox(height: 10),
            Text(
              isNewRecord ? 'New Survival Record!' : 'Game Over',
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
              'Rounds Cleared: $completedRounds',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Best: ${math.max(_highScore, completedRounds)} Rounds',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 20),
            TangibleButton(
              text: 'Try Again',
              height: 48,
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _lives = 3;
                  _round = 1;
                  _isGameOver = false;
                  _nextProblem();
                });
              },
            ),
            const SizedBox(height: 10),
            TangibleButton(
              text: 'Exit',
              isSecondary: true,
              height: 48,
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1050),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isLandscape = constraints.maxWidth > 700 && constraints.maxWidth > constraints.maxHeight;

                final headerWidget = Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton.filledTonal(
                        icon: const Icon(Icons.close_rounded, size: 18),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Row(
                        children: List.generate(3, (index) {
                          final hasHeart = index < _lives;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            child: Icon(
                              hasHeart ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                              color: hasHeart ? const Color(0xFFEF4444) : colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                              size: 26,
                            ),
                          );
                        }),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Round $_round',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                );

                final questionWidget = Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainer,
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: colorScheme.outlineVariant.withValues(alpha: 0.4),
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _currentProblem.prompt,
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w900,
                                color: colorScheme.onSurface,
                              ),
                            ),
                            if (_currentProblem.inputType == ProblemInputType.numberPad) ...[
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                                decoration: BoxDecoration(
                                  color: colorScheme.surfaceContainerHighest,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: _currentInput.isNotEmpty
                                        ? colorScheme.primary
                                        : colorScheme.outlineVariant.withValues(alpha: 0.5),
                                    width: 2,
                                  ),
                                ),
                                child: Text(
                                  _currentInput.isNotEmpty ? _currentInput : '?',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: _currentInput.isNotEmpty
                                        ? colorScheme.onSurface
                                        : colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                );

                final inputWidget = _currentProblem.inputType == ProblemInputType.multipleChoice
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(20, 6, 20, 16),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 2.3,
                          ),
                          itemCount: _currentProblem.options.length,
                          itemBuilder: (context, index) {
                            final option = _currentProblem.options[index];
                            return Material(
                              color: colorScheme.surfaceContainer,
                              borderRadius: BorderRadius.circular(18),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(18),
                                onTap: () => _onOptionTap(option),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    border: Border.all(
                                      color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                                      width: 1.5,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    option,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      color: colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.fromLTRB(20, 2, 20, 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                _numButton('1'),
                                const SizedBox(width: 8),
                                _numButton('2'),
                                const SizedBox(width: 8),
                                _numButton('3'),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                _numButton('4'),
                                const SizedBox(width: 8),
                                _numButton('5'),
                                const SizedBox(width: 8),
                                _numButton('6'),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                _numButton('7'),
                                const SizedBox(width: 8),
                                _numButton('8'),
                                const SizedBox(width: 8),
                                _numButton('9'),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: Material(
                                    color: colorScheme.surfaceContainerHighest,
                                    borderRadius: BorderRadius.circular(16),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(16),
                                      onTap: _onBackspace,
                                      child: Container(
                                        height: 46,
                                        alignment: Alignment.center,
                                        child: Icon(Icons.backspace_rounded, color: colorScheme.error, size: 20),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                _numButton('0'),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Material(
                                    color: colorScheme.primary,
                                    borderRadius: BorderRadius.circular(16),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(16),
                                      onTap: _onSubmit,
                                      child: Container(
                                        height: 46,
                                        alignment: Alignment.center,
                                        child: Icon(Icons.check_rounded, color: colorScheme.onPrimary, size: 24),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );

                if (isLandscape) {
                  return Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            headerWidget,
                            questionWidget,
                          ],
                        ),
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 420),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            inputWidget,
                          ],
                        ),
                      ),
                    ],
                  );
                }

                return Column(
                  children: [
                    headerWidget,
                    const SizedBox(height: 10),
                    questionWidget,
                    inputWidget,
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _numButton(String label) {
    final colorScheme = Theme.of(context).colorScheme;
    return Expanded(
      child: Material(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _onDigit(label),
          child: Container(
            height: 46,
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
