import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:learnmath/domain/models/math_problem.dart';
import 'package:learnmath/l10n/l10n.dart';
import 'package:learnmath/ui/core/services/app_haptics.dart';
import 'package:learnmath/ui/core/widgets/tangible_button.dart';
import 'package:learnmath/ui/features/game/math_game/math_game_engine.dart';

class DuelScreen extends StatefulWidget {
  const DuelScreen({super.key});

  @override
  State<DuelScreen> createState() => _DuelScreenState();
}

class _DuelScreenState extends State<DuelScreen> {
  static const int _targetScore = 10;
  int _p1Score = 0;
  int _p2Score = 0;
  late MathProblem _p1Problem;
  late MathProblem _p2Problem;
  bool _isGameOver = false;

  @override
  void initState() {
    super.initState();
    _p1Problem = _generateProblem();
    _p2Problem = _generateProblem();
  }

  MathProblem _generateProblem() {
    final rng = math.Random();
    final p = MathGameEngine.generatePracticeProblems(
      difficulty: MathDifficulty.easy,
      count: 1,
      random: rng,
    ).first;

    if (p.inputType == ProblemInputType.multipleChoice && p.options.isNotEmpty) {
      return p;
    }

    final ans = int.tryParse(p.correctAnswer) ?? 10;
    final options = <String>[
      ans.toString(),
      (ans + 1 + rng.nextInt(3)).toString(),
      (math.max(0, ans - 1 - rng.nextInt(3))).toString(),
      (ans + 4).toString(),
    ]..shuffle(rng);

    return MathProblem(
      title: p.title,
      prompt: p.prompt,
      correctAnswer: p.correctAnswer,
      options: options,
      inputType: ProblemInputType.multipleChoice,
      category: p.category,
    );
  }

  void _onP1Answer(String option) {
    if (_isGameOver) return;
    final isCorrect = option.trim() == _p1Problem.correctAnswer.trim();
    if (isCorrect) {
      AppHaptics.light();
      setState(() {
        _p1Score++;
        if (_p1Score >= _targetScore) {
          _endGame(1);
        } else {
          _p1Problem = _generateProblem();
        }
      });
    } else {
      AppHaptics.heavy();
      setState(() {
        _p1Score = math.max(0, _p1Score - 1);
        _p1Problem = _generateProblem();
      });
    }
  }

  void _onP2Answer(String option) {
    if (_isGameOver) return;
    final isCorrect = option.trim() == _p2Problem.correctAnswer.trim();
    if (isCorrect) {
      AppHaptics.light();
      setState(() {
        _p2Score++;
        if (_p2Score >= _targetScore) {
          _endGame(2);
        } else {
          _p2Problem = _generateProblem();
        }
      });
    } else {
      AppHaptics.heavy();
      setState(() {
        _p2Score = math.max(0, _p2Score - 1);
        _p2Problem = _generateProblem();
      });
    }
  }

  void _endGame(int winner) {
    _isGameOver = true;
    AppHaptics.heavy();
    _showWinnerDialog(winner);
  }

  void _showWinnerDialog(int winner) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = context.l10n;

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
            const Icon(
              Icons.emoji_events_rounded,
              size: 52,
              color: Color(0xFFFFB800),
            ),
            const SizedBox(height: 10),
            Text(
              l10n.playerWins(winner),
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
              l10n.duelScoreSummary(_p1Score, _p2Score),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 20),
            TangibleButton(
              text: l10n.playAgain,
              height: 48,
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _p1Score = 0;
                  _p2Score = 0;
                  _isGameOver = false;
                  _p1Problem = _generateProblem();
                  _p2Problem = _generateProblem();
                });
              },
            ),
            const SizedBox(height: 10),
            TangibleButton(
              text: l10n.exit,
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
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Column(
              children: [
                Expanded(
                  child: Transform.rotate(
                    angle: math.pi,
                    child: _buildPlayerHalf(
                      playerNumber: 2,
                      score: _p2Score,
                      problem: _p2Problem,
                      onSelect: _onP2Answer,
                      colorScheme: colorScheme,
                      accentColor: const Color(0xFFEF4444),
                    ),
                  ),
                ),
                Container(
                  height: 44,
                  color: colorScheme.surfaceContainerHighest,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        context.l10n.playerScore(2, _p2Score, _targetScore),
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Color(0xFFEF4444),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close_rounded, size: 20),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Text(
                        context.l10n.playerScore(1, _p1Score, _targetScore),
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _buildPlayerHalf(
                    playerNumber: 1,
                    score: _p1Score,
                    problem: _p1Problem,
                    onSelect: _onP1Answer,
                    colorScheme: colorScheme,
                    accentColor: colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlayerHalf({
    required int playerNumber,
    required int score,
    required MathProblem problem,
    required ValueChanged<String> onSelect,
    required ColorScheme colorScheme,
    required Color accentColor,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.playerNumber(playerNumber),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: accentColor,
                ),
              ),
              Row(
                children: List.generate(_targetScore, (i) {
                  return Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: i < score ? accentColor : colorScheme.surfaceContainerHighest,
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
            ],
          ),
          const Spacer(),
          Text(
            problem.prompt,
            style: const TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w900,
            ),
          ),
          const Spacer(),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2.2,
            ),
            itemCount: problem.options.length,
            itemBuilder: (context, index) {
              final option = problem.options[index];
              return Material(
                color: colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => onSelect(option),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                        width: 1.5,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      option,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
