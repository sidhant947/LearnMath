import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnmath/l10n/l10n.dart';
import 'package:learnmath/ui/core/services/app_haptics.dart';
import 'package:learnmath/ui/core/widgets/tangible_button.dart';
import 'package:learnmath/ui/providers.dart';

class Target24Puzzle {
  Target24Puzzle({
    required this.numbers,
    required this.target,
    required this.solution,
  });

  final List<int> numbers;
  final int target;
  final String solution;
}

class Target24Solver {
  static const List<String> _ops = ['+', '-', '*', '/'];

  static Target24Puzzle generateRandomPuzzle({int target = 24, math.Random? random}) {
    final rng = random ?? math.Random();

    while (true) {
      final numbers = List.generate(4, (_) => 1 + rng.nextInt(10));
      final solution = solve(numbers, target);
      if (solution != null) {
        return Target24Puzzle(
          numbers: numbers,
          target: target,
          solution: solution,
        );
      }
    }
  }

  static String? solve(List<int> nums, int target) {
    final perms = _permutations(nums);
    for (final p in perms) {
      final a = p[0].toDouble();
      final b = p[1].toDouble();
      final c = p[2].toDouble();
      final d = p[3].toDouble();

      for (final op1 in _ops) {
        for (final op2 in _ops) {
          for (final op3 in _ops) {
            final v1 = _apply(a, b, op1);
            if (v1 != null) {
              final v2 = _apply(v1, c, op2);
              if (v2 != null) {
                final v3 = _apply(v2, d, op3);
                if (v3 != null && (v3 - target).abs() < 1e-5) {
                  return '((${p[0]} ${_sym(op1)} ${p[1]}) ${_sym(op2)} ${p[2]}) ${_sym(op3)} ${p[3]} = $target';
                }
              }
            }

            final v2_2 = _apply(b, c, op2);
            if (v2_2 != null) {
              final v1_2 = _apply(a, v2_2, op1);
              if (v1_2 != null) {
                final v3_2 = _apply(v1_2, d, op3);
                if (v3_2 != null && (v3_2 - target).abs() < 1e-5) {
                  return '(${p[0]} ${_sym(op1)} (${p[1]} ${_sym(op2)} ${p[2]})) ${_sym(op3)} ${p[3]} = $target';
                }
              }
            }

            if (v2_2 != null) {
              final v3_3 = _apply(v2_2, d, op3);
              if (v3_3 != null) {
                final v1_3 = _apply(a, v3_3, op1);
                if (v1_3 != null && (v1_3 - target).abs() < 1e-5) {
                  return '${p[0]} ${_sym(op1)} ((${p[1]} ${_sym(op2)} ${p[2]}) ${_sym(op3)} ${p[3]}) = $target';
                }
              }
            }

            final v3_4 = _apply(c, d, op3);
            if (v3_4 != null) {
              final v2_4 = _apply(b, v3_4, op2);
              if (v2_4 != null) {
                final v1_4 = _apply(a, v2_4, op1);
                if (v1_4 != null && (v1_4 - target).abs() < 1e-5) {
                  return '${p[0]} ${_sym(op1)} (${p[1]} ${_sym(op2)} (${p[2]} ${_sym(op3)} ${p[3]})) = $target';
                }
              }
            }

            if (v1 != null && v3_4 != null) {
              final v2_5 = _apply(v1, v3_4, op2);
              if (v2_5 != null && (v2_5 - target).abs() < 1e-5) {
                return '(${p[0]} ${_sym(op1)} ${p[1]}) ${_sym(op2)} (${p[2]} ${_sym(op3)} ${p[3]}) = $target';
              }
            }
          }
        }
      }
    }
    return null;
  }

  static double? _apply(double x, double y, String op) {
    switch (op) {
      case '+':
        return x + y;
      case '-':
        return x - y;
      case '*':
        return x * y;
      case '/':
        if (y.abs() < 1e-7) return null;
        return x / y;
      default:
        return null;
    }
  }

  static String _sym(String op) {
    if (op == '*') return '×';
    if (op == '/') return '÷';
    return op;
  }

  static List<List<int>> _permutations(List<int> list) {
    final results = <List<int>>[];
    void permute(List<int> current, List<int> remaining) {
      if (remaining.isEmpty) {
        results.add(List.from(current));
        return;
      }
      for (int i = 0; i < remaining.length; i++) {
        final nextCurrent = List<int>.from(current)..add(remaining[i]);
        final nextRemaining = List<int>.from(remaining)..removeAt(i);
        permute(nextCurrent, nextRemaining);
      }
    }
    permute([], list);
    return results;
  }
}

class Target24Screen extends ConsumerStatefulWidget {
  const Target24Screen({super.key});

  @override
  ConsumerState<Target24Screen> createState() => _Target24ScreenState();
}

class _Target24ScreenState extends ConsumerState<Target24Screen> {
  late Target24Puzzle _currentPuzzle;
  final List<String> _tokens = [];
  final List<bool> _usedNumbers = [false, false, false, false];
  String? _statusMessage;
  bool _isSuccess = false;
  int _solvedStreak = 0;

  @override
  void initState() {
    super.initState();
    _currentPuzzle = Target24Solver.generateRandomPuzzle();
  }

  void _onNumberTap(int index) {
    if (_usedNumbers[index]) return;
    AppHaptics.light();
    setState(() {
      _usedNumbers[index] = true;
      _tokens.add(_currentPuzzle.numbers[index].toString());
      _statusMessage = null;
    });
  }

  void _onOperatorTap(String op) {
    AppHaptics.light();
    setState(() {
      _tokens.add(op);
      _statusMessage = null;
    });
  }

  void _onBackspace() {
    if (_tokens.isEmpty) return;
    AppHaptics.light();
    setState(() {
      final lastToken = _tokens.removeLast();
      final numVal = int.tryParse(lastToken);
      if (numVal != null) {
        for (int i = 0; i < _currentPuzzle.numbers.length; i++) {
          if (_usedNumbers[i] && _currentPuzzle.numbers[i] == numVal) {
            _usedNumbers[i] = false;
            break;
          }
        }
      }
      _statusMessage = null;
    });
  }

  void _onClear() {
    AppHaptics.medium();
    setState(() {
      _tokens.clear();
      for (int i = 0; i < _usedNumbers.length; i++) {
        _usedNumbers[i] = false;
      }
      _statusMessage = null;
    });
  }

  void _evaluateExpression() {
    final l10n = context.l10n;
    if (_usedNumbers.contains(false)) {
      AppHaptics.heavy();
      setState(() {
        _statusMessage = l10n.useAll4Numbers;
        _isSuccess = false;
      });
      return;
    }

    try {
      final expr = _tokens.join(' ').replaceAll('×', '*').replaceAll('÷', '/');
      final result = _calculateSimple(expr);
      if (result != null && (result - _currentPuzzle.target).abs() < 0.001) {
        AppHaptics.heavy();
        setState(() {
          _statusMessage = l10n.correctEqualsTarget(_currentPuzzle.target);
          _isSuccess = true;
          _solvedStreak++;
        });
        ref.read(progressRepositoryProvider).recordTarget24Solved();
      } else {
        AppHaptics.heavy();
        setState(() {
          _statusMessage = result == null
              ? l10n.invalidExpression
              : l10n.equalsTarget(result.toStringAsFixed(1), _currentPuzzle.target);
          _isSuccess = false;
        });
      }
    } catch (e) {
      AppHaptics.heavy();
      setState(() {
        _statusMessage = l10n.invalidMathSyntax;
        _isSuccess = false;
      });
    }
  }

  double? _calculateSimple(String expr) {
    try {
      final sanitized = expr.replaceAll(' ', '');
      return _parseAddSub(sanitized);
    } catch (_) {
      return null;
    }
  }

  double _parseAddSub(String s) {
    int bracketCount = 0;
    for (int i = s.length - 1; i >= 0; i--) {
      if (s[i] == ')') bracketCount++;
      if (s[i] == '(') bracketCount--;
      if (bracketCount == 0 && (s[i] == '+' || s[i] == '-') && i > 0) {
        final left = s.substring(0, i);
        final right = s.substring(i + 1);
        return s[i] == '+' ? _parseAddSub(left) + _parseMulDiv(right) : _parseAddSub(left) - _parseMulDiv(right);
      }
    }
    return _parseMulDiv(s);
  }

  double _parseMulDiv(String s) {
    int bracketCount = 0;
    for (int i = s.length - 1; i >= 0; i--) {
      if (s[i] == ')') bracketCount++;
      if (s[i] == '(') bracketCount--;
      if (bracketCount == 0 && (s[i] == '*' || s[i] == '/') && i > 0) {
        final left = s.substring(0, i);
        final right = s.substring(i + 1);
        final rightVal = _parsePrimary(right);
        if (s[i] == '/') {
          if (rightVal == 0) throw Exception('Div0');
          return _parseMulDiv(left) / rightVal;
        }
        return _parseMulDiv(left) * rightVal;
      }
    }
    return _parsePrimary(s);
  }

  double _parsePrimary(String s) {
    if (s.startsWith('(') && s.endsWith(')')) {
      return _parseAddSub(s.substring(1, s.length - 1));
    }
    return double.parse(s);
  }

  void _nextPuzzle() {
    setState(() {
      _currentPuzzle = Target24Solver.generateRandomPuzzle();
      _onClear();
      _isSuccess = false;
    });
  }

  void _showHint() {
    final l10n = context.l10n;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(l10n.puzzleHint),
        content: Text(l10n.oneSolutionIs(_currentPuzzle.solution)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.ok),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.target24Title),
        actions: [
          IconButton(
            tooltip: context.l10n.newPuzzle,
            icon: const Icon(Icons.refresh_rounded),
            onPressed: _nextPuzzle,
          ),
          IconButton(
            tooltip: context.l10n.hint,
            icon: const Icon(Icons.lightbulb_outline_rounded),
            onPressed: _showHint,
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHigh,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context.l10n.makeTargetNumber,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                            if (_solvedStreak > 0)
                              Text(
                                context.l10n.puzzlesSolved(_solvedStreak),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 11,
                                  color: Color(0xFF10B981),
                                ),
                              ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            context.l10n.targetLabel(_currentPuzzle.target),
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                              color: colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(4, (index) {
                      final num = _currentPuzzle.numbers[index];
                      final isUsed = _usedNumbers[index];
                      return GestureDetector(
                        onTap: isUsed ? null : () => _onNumberTap(index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: 68,
                          height: 68,
                          decoration: BoxDecoration(
                            color: isUsed
                                ? colorScheme.surfaceContainerHighest.withValues(alpha: 0.3)
                                : colorScheme.primary,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: isUsed
                                ? null
                                : [
                                    BoxShadow(
                                      color: colorScheme.primary.withValues(alpha: 0.35),
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            num.toString(),
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                              color: isUsed
                                  ? colorScheme.onSurfaceVariant.withValues(alpha: 0.3)
                                  : colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    constraints: const BoxConstraints(minHeight: 70),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: colorScheme.outlineVariant.withValues(alpha: 0.5),
                        width: 1.5,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      _tokens.isEmpty ? context.l10n.tapNumbersOperators : _tokens.join(' '),
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.5,
                        color: _tokens.isEmpty
                            ? colorScheme.onSurfaceVariant.withValues(alpha: 0.4)
                            : colorScheme.onSurface,
                      ),
                    ),
                  ),
                  if (_statusMessage != null) ...[
                    const SizedBox(height: 10),
                    Text(
                      _statusMessage!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: _isSuccess ? const Color(0xFF10B981) : colorScheme.error,
                      ),
                    ),
                  ],
                  const Spacer(),
                  Row(
                    children: [
                      _opButton('+', () => _onOperatorTap('+')),
                      const SizedBox(width: 8),
                      _opButton('-', () => _onOperatorTap('-')),
                      const SizedBox(width: 8),
                      _opButton('×', () => _onOperatorTap('×')),
                      const SizedBox(width: 8),
                      _opButton('÷', () => _onOperatorTap('÷')),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _opButton('(', () => _onOperatorTap('(')),
                      const SizedBox(width: 8),
                      _opButton(')', () => _onOperatorTap(')')),
                      const SizedBox(width: 8),
                      _opButton('⌫', _onBackspace, isError: true),
                      const SizedBox(width: 8),
                      _opButton('C', _onClear),
                    ],
                  ),
                  const SizedBox(height: 14),
                  if (_isSuccess)
                    TangibleButton(
                      text: context.l10n.nextPuzzle,
                      height: 48,
                      onPressed: _nextPuzzle,
                    )
                  else
                    TangibleButton(
                      text: context.l10n.checkEquation,
                      height: 48,
                      onPressed: _evaluateExpression,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _opButton(String label, VoidCallback onTap, {bool isError = false}) {
    final colorScheme = Theme.of(context).colorScheme;
    return Expanded(
      child: Material(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Container(
            height: 46,
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: isError ? colorScheme.error : colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
