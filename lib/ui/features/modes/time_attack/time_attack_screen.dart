import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnmath/domain/models/math_problem.dart';
import 'package:learnmath/ui/core/services/app_haptics.dart';
import 'package:learnmath/ui/core/widgets/tangible_button.dart';
import 'package:learnmath/ui/features/game/math_game/math_game_engine.dart';
import 'package:learnmath/ui/providers.dart';

class TimeAttackScreen extends ConsumerStatefulWidget {
  const TimeAttackScreen({super.key});

  @override
  ConsumerState<TimeAttackScreen> createState() => _TimeAttackScreenState();
}

class _TimeAttackScreenState extends ConsumerState<TimeAttackScreen> {
  static const int _initialTime = 60;
  int _timeLeft = _initialTime;
  Timer? _timer;
  int _score = 0;
  int _streak = 0;
  String _currentInput = '';
  late MathProblem _currentProblem;
  bool _isGameOver = false;
  int _highScore = 0;

  @override
  void initState() {
    super.initState();
    _loadHighScore();
    _nextProblem();
    _startTimer();
  }

  Future<void> _loadHighScore() async {
    final progress = await ref.read(progressRepositoryProvider).getProgress();
    if (mounted) {
      setState(() {
        _highScore = progress.timeAttackHighScore;
      });
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _endGame();
        }
      });
    });
  }

  void _endGame() {
    _timer?.cancel();
    _isGameOver = true;
    AppHaptics.heavy();
    ref.read(progressRepositoryProvider).recordTimeAttackScore(_score);
    _showGameOverDialog();
  }

  void _nextProblem() {
    final diff = _score < 5
        ? MathDifficulty.easy
        : (_score < 15 ? MathDifficulty.medium : MathDifficulty.hard);
    _currentProblem = MathGameEngine.generatePracticeProblems(
      difficulty: diff,
      count: 1,
    ).first;
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
        _score++;
        _streak++;
        _timeLeft = (_timeLeft + 2).clamp(0, 99);
        _nextProblem();
      });
    } else {
      AppHaptics.heavy();
      setState(() {
        _streak = 0;
        _timeLeft = (_timeLeft - 3).clamp(0, 99);
        _currentInput = '';
      });
      if (_timeLeft <= 0) {
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
        _score++;
        _streak++;
        _timeLeft = (_timeLeft + 2).clamp(0, 99);
        _nextProblem();
      });
    } else {
      AppHaptics.heavy();
      setState(() {
        _streak = 0;
        _timeLeft = (_timeLeft - 3).clamp(0, 99);
      });
      if (_timeLeft <= 0) {
        _endGame();
      }
    }
  }

  void _showGameOverDialog() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isNewRecord = _score > _highScore;

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
              isNewRecord ? Icons.military_tech_rounded : Icons.timer_off_rounded,
              size: 48,
              color: isNewRecord ? const Color(0xFFFFB800) : colorScheme.error,
            ),
            const SizedBox(height: 10),
            Text(
              isNewRecord ? 'New Best Score!' : 'Time\'s Up!',
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
              'Final Score: $_score',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Best: ${math.max(_highScore, _score)}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 20),
            TangibleButton(
              text: 'Play Again',
              height: 48,
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _timeLeft = _initialTime;
                  _score = 0;
                  _streak = 0;
                  _isGameOver = false;
                  _nextProblem();
                  _startTimer();
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
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isLowTime = _timeLeft <= 10;

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
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          color: isLowTime
                              ? colorScheme.errorContainer
                              : colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.timer_rounded,
                              size: 16,
                              color: isLowTime ? colorScheme.error : colorScheme.onPrimaryContainer,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${_timeLeft}s',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                                color: isLowTime ? colorScheme.error : colorScheme.onPrimaryContainer,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Score: $_score',
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
                            if (_streak > 2) ...[
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF97316).withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.local_fire_department_rounded, size: 14, color: Color(0xFFF97316)),
                                    const SizedBox(width: 4),
                                    Text(
                                      '$_streak Streak! (+2s)',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFFF97316),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                            ],
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
                                _numButton('⌫', isAction: true, onTap: _onBackspace),
                                const SizedBox(width: 8),
                                _numButton('0'),
                                const SizedBox(width: 8),
                                _numButton('✓', isAction: true, isSubmit: true, onTap: _onSubmit),
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

  Widget _numButton(String label, {bool isAction = false, bool isSubmit = false, VoidCallback? onTap}) {
    final colorScheme = Theme.of(context).colorScheme;
    final bg = isSubmit ? colorScheme.primary : colorScheme.surfaceContainerHighest;
    Widget content = Text(
      label,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: isSubmit ? colorScheme.onPrimary : colorScheme.onSurface,
      ),
    );
    if (label == '⌫') {
      content = Icon(Icons.backspace_rounded, color: colorScheme.error, size: 20);
    } else if (label == '✓') {
      content = Icon(Icons.check_rounded, color: colorScheme.onPrimary, size: 24);
    }

    return Expanded(
      child: Material(
        color: bg,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap ?? () => _onDigit(label),
          child: Container(
            height: 46,
            alignment: Alignment.center,
            child: content,
          ),
        ),
      ),
    );
  }
}
