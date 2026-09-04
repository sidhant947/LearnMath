import 'dart:math' as math;
import 'package:learnmath/domain/models/math_problem.dart';

class MathGameEngine {
  static const int defaultQuestionsPerLevel = 5;
  static const int maxCurriculumLevel = 60;

  static bool isBossLevel(int level) {
    if (level <= 0) return false;
    return level == 4 ||
        level == 14 ||
        level == 24 ||
        level == 34 ||
        level == 44 ||
        level == 54 ||
        level == 59 ||
        level == 60 ||
        (level > 60 && level % 5 == 0);
  }

  static MathCategory getCategoryForLevel(int level) {
    if (level <= 4) return MathCategory.concepts;
    if (level <= 14) return MathCategory.addition;
    if (level <= 24) return MathCategory.subtraction;
    if (level <= 34) return MathCategory.multiplication;
    if (level <= 44) return MathCategory.division;
    if (level <= 54) return MathCategory.powersRoots;
    return MathCategory.master;
  }

  static String getCategoryName(MathCategory category) {
    switch (category) {
      case MathCategory.concepts:
        return 'CONCEPTS';
      case MathCategory.addition:
        return 'ADDITION';
      case MathCategory.subtraction:
        return 'SUBTRACTION';
      case MathCategory.multiplication:
        return 'MULTIPLICATION';
      case MathCategory.division:
        return 'DIVISION';
      case MathCategory.powersRoots:
        return 'POWERS & ROOTS';
      case MathCategory.master:
        return 'MASTER PRACTICE';
    }
  }

  static String getLevelTitle(int level) {
    if (level > maxCurriculumLevel) {
      return 'Master Practice ${level - maxCurriculumLevel}';
    }
    switch (level) {
      case 1:
        return 'What is 0 & Counting (1 to 5)';
      case 2:
        return 'Counting (6 to 10) & Comparing';
      case 3:
        return 'Place Value & Even / Odd';
      case 4:
        return '👑 Number Sense Milestone';
      case 5:
        return '1-Digit Addition (Sums to 5)';
      case 6:
        return '1-Digit Addition (Sums to 10)';
      case 7:
        return 'Addition (Bridging 10)';
      case 8:
        return '2-Digit + 1-Digit (Simple)';
      case 9:
        return '2-Digit + 1-Digit (Carrying)';
      case 10:
        return '2-Digit + 2-Digit (Simple)';
      case 11:
        return '2-Digit + 2-Digit (Carrying)';
      case 12:
        return '3-Digit Addition';
      case 13:
        return '4-Digit Addition';
      case 14:
        return '👑 Addition Master Boss';
      case 15:
        return '1-Digit Subtraction (Within 5)';
      case 16:
        return '1-Digit Subtraction (Within 10)';
      case 17:
        return 'Subtraction Across 10';
      case 18:
        return '2-Digit - 1-Digit (Simple)';
      case 19:
        return '2-Digit - 1-Digit (Borrowing)';
      case 20:
        return '2-Digit - 2-Digit (Simple)';
      case 21:
        return '2-Digit - 2-Digit (Borrowing)';
      case 22:
        return '3-Digit Subtraction';
      case 23:
        return '4-Digit Subtraction';
      case 24:
        return '👑 Subtraction Master Boss';
      case 25:
        return 'Multiplication as Groups';
      case 26:
        return 'Times Tables 2 & 3';
      case 27:
        return 'Times Tables 4 & 5';
      case 28:
        return 'Times Tables 6 & 7';
      case 29:
        return 'Times Tables 8 & 9';
      case 30:
        return 'Times Tables 10, 11 & 12';
      case 31:
        return '2-Digit × 1-Digit (Simple)';
      case 32:
        return '2-Digit × 1-Digit (Advanced)';
      case 33:
        return '2-Digit × 2-Digit';
      case 34:
        return '👑 Multiplication Master Boss';
      case 35:
        return 'Division as Equal Sharing';
      case 36:
        return 'Division by 2, 3 & 4';
      case 37:
        return 'Division by 5 & 10';
      case 38:
        return 'Division by 6, 7, 8 & 9';
      case 39:
        return 'Division by 11 & 12';
      case 40:
        return '2-Digit ÷ 1-Digit (Simple)';
      case 41:
        return '2-Digit ÷ 1-Digit (Advanced)';
      case 42:
        return '3-Digit ÷ 1-Digit';
      case 43:
        return '3-Digit ÷ 2-Digit';
      case 44:
        return '👑 Division Master Boss';
      case 45:
        return 'Squares Basics (1² to 6²)';
      case 46:
        return 'Squares Advanced (7² to 12²)';
      case 47:
        return '2-Digit Squares (13² to 25²)';
      case 48:
        return 'Square Roots (√4 to √49)';
      case 49:
        return 'Square Roots (√64 to √400)';
      case 50:
        return 'Cubes Basics (1³ to 5³)';
      case 51:
        return 'Cubes Advanced (6³ to 10³)';
      case 52:
        return 'Power 4 Basics (1⁴ to 3⁴)';
      case 53:
        return 'Power 4 Advanced (4⁴, 5⁴, 10⁴)';
      case 54:
        return '👑 Powers & Roots Boss';
      case 55:
        return 'Speed Trial: Add & Subtract';
      case 56:
        return 'Speed Trial: Multiply & Divide';
      case 57:
        return 'Speed Trial: Powers & Roots';
      case 58:
        return 'All-Rounder Challenge';
      case 59:
        return '👑 Grand Semi-Final Boss';
      case 60:
        return '👑 The Ultimate Graduation Boss';
      default:
        return 'Master Practice';
    }
  }

  static List<MathProblem> generateProblemsForLevel(int level, {math.Random? random}) {
    final rng = random ?? math.Random();
    final problems = <MathProblem>[];

    for (int i = 0; i < defaultQuestionsPerLevel; i++) {
      problems.add(_generateSingleProblem(level, i, rng));
    }
    return problems;
  }

  static List<MathProblem> generateDailyProblems(DateTime date) {
    final seed = date.year * 10000 + date.month * 100 + date.day;
    final rng = math.Random(seed);
    final problems = <MathProblem>[];

    final difficulties = [
      MathDifficulty.easy,
      MathDifficulty.easy,
      MathDifficulty.medium,
      MathDifficulty.medium,
      MathDifficulty.medium,
      MathDifficulty.hard,
      MathDifficulty.hard,
      MathDifficulty.hard,
    ];

    for (final diff in difficulties) {
      problems.add(_generatePracticeSingleProblem(diff, null, rng));
    }
    return problems;
  }

  static List<MathProblem> generatePracticeProblems({
    required MathDifficulty difficulty,
    required int count,
    MathCategory? category,
    math.Random? random,
  }) {
    final rng = random ?? math.Random();
    final problems = <MathProblem>[];

    for (int i = 0; i < count; i++) {
      problems.add(_generatePracticeSingleProblem(difficulty, category, rng));
    }
    return problems;
  }

  static MathProblem generateSingleDynamicProblem(int round) {
    final rng = math.Random();
    MathDifficulty diff;
    if (round <= 5) {
      diff = MathDifficulty.easy;
    } else if (round <= 15) {
      diff = MathDifficulty.medium;
    } else {
      diff = MathDifficulty.hard;
    }
    return _generatePracticeSingleProblem(diff, null, rng);
  }

  static MathProblem _generatePracticeSingleProblem(
    MathDifficulty difficulty,
    MathCategory? category,
    math.Random rng,
  ) {
    final effectiveCategory = (category == null || category == MathCategory.master)
        ? _pickRandomCategoryForPractice(difficulty, rng)
        : category;

    switch (effectiveCategory) {
      case MathCategory.concepts:
        return _generateConceptsPractice(difficulty, rng);
      case MathCategory.addition:
        return _generateAdditionPractice(difficulty, rng);
      case MathCategory.subtraction:
        return _generateSubtractionPractice(difficulty, rng);
      case MathCategory.multiplication:
        return _generateMultiplicationPractice(difficulty, rng);
      case MathCategory.division:
        return _generateDivisionPractice(difficulty, rng);
      case MathCategory.powersRoots:
      case MathCategory.master:
        return _generatePowersRootsPractice(difficulty, rng);
    }
  }

  static MathCategory _pickRandomCategoryForPractice(
    MathDifficulty difficulty,
    math.Random rng,
  ) {
    if (difficulty == MathDifficulty.easy) {
      final pool = [
        MathCategory.addition,
        MathCategory.subtraction,
        MathCategory.multiplication,
        MathCategory.division,
      ];
      return pool[rng.nextInt(pool.length)];
    } else {
      final pool = [
        MathCategory.addition,
        MathCategory.subtraction,
        MathCategory.multiplication,
        MathCategory.division,
        MathCategory.powersRoots,
      ];
      return pool[rng.nextInt(pool.length)];
    }
  }

  static MathProblem _generateConceptsPractice(MathDifficulty difficulty, math.Random rng) {
    if (difficulty == MathDifficulty.easy) {
      final count = rng.nextInt(6);
      final pool = ['0', '1', '2', '3', '4', '5'];
      final choices = _generateChoices(count.toString(), pool, rng);
      return MathProblem(
        title: 'Easy Concepts',
        prompt: count == 0 ? 'Which number means ZERO?' : 'Count the dots:',
        visualCount: count,
        visualType: count > 0 ? MathVisualType.dots : MathVisualType.none,
        correctAnswer: count.toString(),
        options: choices,
        inputType: ProblemInputType.multipleChoice,
        category: MathCategory.concepts,
        explanationSteps: [
          count == 0
              ? 'Zero represents an empty set or absence of items.'
              : 'Count each glowing dot one by one to arrive at $count.',
        ],
      );
    } else if (difficulty == MathDifficulty.medium) {
      final tens = 1 + rng.nextInt(9);
      final ones = rng.nextInt(10);
      final num = tens * 10 + ones;
      final choices = _generateChoices(num.toString(), [
        num.toString(),
        (ones * 10 + tens).toString(),
        (num + 10).toString(),
        (num - 1).toString(),
      ], rng);
      return MathProblem(
        title: 'Medium Concepts (Place Value)',
        prompt: 'What number has $tens Tens and $ones Ones?',
        correctAnswer: num.toString(),
        options: choices,
        inputType: ProblemInputType.multipleChoice,
        category: MathCategory.concepts,
        visualType: MathVisualType.placeValueBlocks,
        tensCount: tens,
        onesCount: ones,
        explanationSteps: [
          '$tens Tens = $tens × 10 = ${tens * 10}.',
          '$ones Ones = $ones.',
          'Add them together: ${tens * 10} + $ones = $num.',
        ],
      );
    } else {
      final hundreds = 1 + rng.nextInt(9);
      final tens = rng.nextInt(10);
      final ones = rng.nextInt(10);
      final num = hundreds * 100 + tens * 10 + ones;
      final choices = _generateChoices(num.toString(), [
        num.toString(),
        (hundreds * 100 + ones * 10 + tens).toString(),
        (num + 100).toString(),
        (num - 10).toString(),
      ], rng);
      return MathProblem(
        title: 'Hard Concepts (Place Value)',
        prompt: 'What number is $hundreds Hundreds, $tens Tens & $ones Ones?',
        correctAnswer: num.toString(),
        options: choices,
        inputType: ProblemInputType.multipleChoice,
        category: MathCategory.concepts,
        explanationSteps: [
          '$hundreds Hundreds = ${hundreds * 100}.',
          '$tens Tens = ${tens * 10}.',
          '$ones Ones = $ones.',
          'Sum: ${hundreds * 100} + ${tens * 10} + $ones = $num.',
        ],
      );
    }
  }

  static MathProblem _generateAdditionPractice(MathDifficulty difficulty, math.Random rng) {
    int a;
    int b;
    String title;

    if (difficulty == MathDifficulty.easy) {
      title = 'Easy Addition';
      if (rng.nextBool()) {
        a = 1 + rng.nextInt(9);
        b = 1 + rng.nextInt(9);
      } else {
        a = 10 + rng.nextInt(30);
        b = 1 + rng.nextInt(9);
      }
    } else if (difficulty == MathDifficulty.medium) {
      title = 'Medium Addition';
      if (rng.nextBool()) {
        a = 25 + rng.nextInt(75);
        b = 25 + rng.nextInt(75);
      } else {
        a = 100 + rng.nextInt(899);
        b = 100 + rng.nextInt(899);
      }
    } else {
      title = 'Hard Addition';
      if (rng.nextBool()) {
        a = 1000 + rng.nextInt(8999);
        b = 1000 + rng.nextInt(8999);
      } else {
        a = 10000 + rng.nextInt(89999);
        b = 10000 + rng.nextInt(89999);
      }
    }

    final sum = a + b;
    return MathProblem(
      title: title,
      prompt: '$a + $b = ?',
      correctAnswer: sum.toString(),
      inputType: ProblemInputType.numberPad,
      category: MathCategory.addition,
      visualType: (a <= 10 && b <= 10) ? MathVisualType.numberLine : MathVisualType.none,
      numberLineStart: a,
      numberLineEnd: sum,
      numberLineStep: b,
      explanationSteps: [
        'Line up the numbers: $a and $b.',
        'Add the ones column: (${a % 10} + ${b % 10} = ${(a % 10) + (b % 10)}).',
        'Add remaining tens and hundreds with any carry.',
        'Result: $a + $b = $sum.',
      ],
    );
  }

  static MathProblem _generateSubtractionPractice(MathDifficulty difficulty, math.Random rng) {
    int a;
    int b;
    String title;

    if (difficulty == MathDifficulty.easy) {
      title = 'Easy Subtraction';
      if (rng.nextBool()) {
        a = 5 + rng.nextInt(15);
        b = 1 + rng.nextInt(a);
      } else {
        a = 20 + rng.nextInt(40);
        b = 1 + rng.nextInt(9);
      }
    } else if (difficulty == MathDifficulty.medium) {
      title = 'Medium Subtraction';
      if (rng.nextBool()) {
        a = 40 + rng.nextInt(60);
        b = 15 + rng.nextInt(a - 20);
      } else {
        a = 200 + rng.nextInt(799);
        b = 100 + rng.nextInt(a - 100);
      }
    } else {
      title = 'Hard Subtraction';
      if (rng.nextBool()) {
        a = 3000 + rng.nextInt(6999);
        b = 1000 + rng.nextInt(a - 1000);
      } else {
        a = 20000 + rng.nextInt(79999);
        b = 10000 + rng.nextInt(a - 10000);
      }
    }

    final diff = a - b;
    return MathProblem(
      title: title,
      prompt: '$a - $b = ?',
      correctAnswer: diff.toString(),
      inputType: ProblemInputType.numberPad,
      category: MathCategory.subtraction,
      visualType: (a <= 20) ? MathVisualType.numberLine : MathVisualType.none,
      numberLineStart: a,
      numberLineEnd: diff,
      numberLineStep: -b,
      explanationSteps: [
        'Start with the larger number: $a.',
        'Subtract $b by counting down or subtracting column by column.',
        'Result: $a - $b = $diff.',
      ],
    );
  }

  static MathProblem _generateMultiplicationPractice(MathDifficulty difficulty, math.Random rng) {
    int a;
    int b;
    String title;

    if (difficulty == MathDifficulty.easy) {
      title = 'Easy Multiplication';
      a = 2 + rng.nextInt(9);
      b = 1 + rng.nextInt(10);
    } else if (difficulty == MathDifficulty.medium) {
      title = 'Medium Multiplication';
      if (rng.nextBool()) {
        a = 12 + rng.nextInt(88);
        b = 3 + rng.nextInt(7);
      } else {
        a = 11 + rng.nextInt(15);
        b = 11 + rng.nextInt(15);
      }
    } else {
      title = 'Hard Multiplication';
      if (rng.nextBool()) {
        a = 35 + rng.nextInt(65);
        b = 25 + rng.nextInt(75);
      } else {
        a = 120 + rng.nextInt(380);
        b = 15 + rng.nextInt(35);
      }
    }

    final product = a * b;
    return MathProblem(
      title: title,
      prompt: '$a × $b = ?',
      correctAnswer: product.toString(),
      inputType: ProblemInputType.numberPad,
      category: MathCategory.multiplication,
      visualType: (a <= 6 && b <= 6) ? MathVisualType.arrayGrid : MathVisualType.none,
      visualRows: a <= 6 ? a : 0,
      visualCols: b <= 6 ? b : 0,
      explanationSteps: [
        '$a × $b means adding $a repeatedly $b times.',
        if (a > 10) 'Break it down: ($a = ${(a ~/ 10) * 10} + ${a % 10}) × $b = (${(a ~/ 10) * 10 * b}) + (${(a % 10) * b}) = $product.',
        'Result: $a × $b = $product.',
      ],
    );
  }

  static MathProblem _generateDivisionPractice(MathDifficulty difficulty, math.Random rng) {
    int divisor;
    int quotient;
    String title;

    if (difficulty == MathDifficulty.easy) {
      title = 'Easy Division';
      divisor = 2 + rng.nextInt(9);
      quotient = 1 + rng.nextInt(10);
    } else if (difficulty == MathDifficulty.medium) {
      title = 'Medium Division';
      divisor = 4 + rng.nextInt(12);
      quotient = 12 + rng.nextInt(38);
    } else {
      title = 'Hard Division';
      divisor = 15 + rng.nextInt(35);
      quotient = 25 + rng.nextInt(75);
    }

    final dividend = divisor * quotient;
    return MathProblem(
      title: title,
      prompt: '$dividend ÷ $divisor = ?',
      correctAnswer: quotient.toString(),
      inputType: ProblemInputType.numberPad,
      category: MathCategory.division,
      explanationSteps: [
        'Ask: How many times does $divisor fit into $dividend?',
        'Check with multiplication: $divisor × $quotient = $dividend.',
        'Result: $dividend ÷ $divisor = $quotient.',
      ],
    );
  }

  static MathProblem _generatePowersRootsPractice(MathDifficulty difficulty, math.Random rng) {
    if (difficulty == MathDifficulty.easy) {
      final isRoot = rng.nextBool();
      if (isRoot) {
        final b = 2 + rng.nextInt(9);
        final sq = b * b;
        return MathProblem(
          title: 'Easy Square Root',
          prompt: '√$sq = ?',
          correctAnswer: b.toString(),
          inputType: ProblemInputType.numberPad,
          category: MathCategory.powersRoots,
          explanationSteps: [
            'Find a number multiplied by itself that gives $sq.',
            '$b × $b = $sq, so √$sq = $b.',
          ],
        );
      } else {
        final b = 2 + rng.nextInt(9);
        return MathProblem(
          title: 'Easy Square',
          prompt: '$b² = ?',
          correctAnswer: (b * b).toString(),
          inputType: ProblemInputType.numberPad,
          category: MathCategory.powersRoots,
          visualType: MathVisualType.squareGrid,
          visualRows: b <= 8 ? b : 0,
          explanationSteps: [
            '$b² means multiplying $b by itself ($b × $b).',
            'Result: $b × $b = ${b * b}.',
          ],
        );
      }
    } else if (difficulty == MathDifficulty.medium) {
      final type = rng.nextInt(3);
      if (type == 0) {
        final b = 11 + rng.nextInt(10);
        return MathProblem(
          title: 'Medium Square',
          prompt: '$b² = ?',
          correctAnswer: (b * b).toString(),
          inputType: ProblemInputType.numberPad,
          category: MathCategory.powersRoots,
          explanationSteps: [
            '$b² = $b × $b.',
            'Breakdown: ($b × 10) + ($b × ${b % 10}) = ${b * 10} + ${b * (b % 10)} = ${b * b}.',
          ],
        );
      } else if (type == 1) {
        final b = 11 + rng.nextInt(10);
        final sq = b * b;
        return MathProblem(
          title: 'Medium Square Root',
          prompt: '√$sq = ?',
          correctAnswer: b.toString(),
          inputType: ProblemInputType.numberPad,
          category: MathCategory.powersRoots,
          explanationSteps: [
            'Find which number squared is $sq.',
            '$b × $b = $sq, so √$sq = $b.',
          ],
        );
      } else {
        final b = 2 + rng.nextInt(6);
        return MathProblem(
          title: 'Medium Cube',
          prompt: '$b³ = ?',
          correctAnswer: (b * b * b).toString(),
          inputType: ProblemInputType.numberPad,
          category: MathCategory.powersRoots,
          explanationSteps: [
            '$b³ means $b × $b × $b.',
            '$b × $b = ${b * b}.',
            '${b * b} × $b = ${b * b * b}.',
          ],
        );
      }
    } else {
      final type = rng.nextInt(4);
      if (type == 0) {
        final b = 21 + rng.nextInt(30);
        return MathProblem(
          title: 'Hard Square',
          prompt: '$b² = ?',
          correctAnswer: (b * b).toString(),
          inputType: ProblemInputType.numberPad,
          category: MathCategory.powersRoots,
          explanationSteps: [
            '$b² = $b × $b = ${b * b}.',
          ],
        );
      } else if (type == 1) {
        final b = 25 + rng.nextInt(26);
        final sq = b * b;
        return MathProblem(
          title: 'Hard Square Root',
          prompt: '√$sq = ?',
          correctAnswer: b.toString(),
          inputType: ProblemInputType.numberPad,
          category: MathCategory.powersRoots,
          explanationSteps: [
            '$b × $b = $sq, therefore √$sq = $b.',
          ],
        );
      } else if (type == 2) {
        final b = 7 + rng.nextInt(9);
        return MathProblem(
          title: 'Hard Cube',
          prompt: '$b³ = ?',
          correctAnswer: (b * b * b).toString(),
          inputType: ProblemInputType.numberPad,
          category: MathCategory.powersRoots,
          explanationSteps: [
            '$b³ = $b × $b × $b = ${b * b} × $b = ${b * b * b}.',
          ],
        );
      } else {
        final b = 4 + rng.nextInt(5);
        return MathProblem(
          title: 'Hard Power 4',
          prompt: '$b⁴ = ?',
          correctAnswer: (b * b * b * b).toString(),
          inputType: ProblemInputType.numberPad,
          category: MathCategory.powersRoots,
          explanationSteps: [
            '$b⁴ = ($b²)² = (${b * b})² = ${b * b * b * b}.',
          ],
        );
      }
    }
  }

  static MathProblem _generateSingleProblem(int level, int index, math.Random rng) {
    if (level <= 4) {
      return _generateConceptProblem(level, index, rng);
    } else if (level <= 14) {
      return _generateAdditionProblem(level, index, rng);
    } else if (level <= 24) {
      return _generateSubtractionProblem(level, index, rng);
    } else if (level <= 34) {
      return _generateMultiplicationProblem(level, index, rng);
    } else if (level <= 44) {
      return _generateDivisionProblem(level, index, rng);
    } else if (level <= 54) {
      return _generatePowersAndRootsProblem(level, index, rng);
    } else {
      return _generateMasterPracticeProblem(level, rng);
    }
  }

  static MathProblem _generateConceptProblem(int level, int index, math.Random rng) {
    switch (level) {
      case 1:
        final count = rng.nextInt(6);
        final pool = ['0', '1', '2', '3', '4', '5'];
        final choices = _generateChoices(count.toString(), pool, rng);
        return MathProblem(
          title: 'Counting (0 to 5)',
          prompt: count == 0 ? 'Which number means ZERO (nothing)?' : 'Count the glowing dots:',
          subtitle: count == 0 ? 'No dots shown below' : null,
          visualCount: count,
          visualType: count > 0 ? MathVisualType.dots : MathVisualType.none,
          correctAnswer: count.toString(),
          options: choices,
          inputType: ProblemInputType.multipleChoice,
          category: MathCategory.concepts,
          explanationSteps: [
            count == 0
                ? 'Zero means nothing or empty.'
                : 'There are $count dots shown on the screen.',
          ],
        );
      case 2:
        final isCompare = rng.nextBool();
        if (isCompare) {
          final a = 1 + rng.nextInt(10);
          int b = 1 + rng.nextInt(10);
          while (b == a) {
            b = 1 + rng.nextInt(10);
          }
          final isBigger = rng.nextBool();
          final ans = isBigger ? math.max(a, b) : math.min(a, b);
          final choices = _generateChoices(ans.toString(), [a.toString(), b.toString(), (ans - 1).clamp(1, 10).toString(), (ans + 1).clamp(1, 10).toString()], rng);
          return MathProblem(
            title: isBigger ? 'Find the Larger' : 'Find the Smaller',
            prompt: isBigger ? 'Which number is LARGER?' : 'Which number is SMALLER?',
            subtitle: '$a  or  $b',
            correctAnswer: ans.toString(),
            options: choices,
            inputType: ProblemInputType.multipleChoice,
            category: MathCategory.concepts,
            explanationSteps: [
              'Comparing $a and $b.',
              isBigger
                  ? '$ans is greater because it comes further along the number line.'
                  : '$ans is smaller because it is closer to 0.',
            ],
          );
        } else {
          final count = 6 + rng.nextInt(5);
          final pool = ['6', '7', '8', '9', '10', '11'];
          final choices = _generateChoices(count.toString(), pool, rng);
          return MathProblem(
            title: 'Counting (6 to 10)',
            prompt: 'Count the glowing dots:',
            visualCount: count,
            visualType: MathVisualType.dots,
            correctAnswer: count.toString(),
            options: choices,
            inputType: ProblemInputType.multipleChoice,
            category: MathCategory.concepts,
            explanationSteps: [
              'Counting every glowing dot totals $count.',
            ],
          );
        }
      case 3:
        final isPlaceValue = rng.nextBool();
        if (isPlaceValue) {
          final tens = 1 + rng.nextInt(9);
          final ones = rng.nextInt(10);
          final num = tens * 10 + ones;
          final choices = _generateChoices(num.toString(), [
            num.toString(),
            (ones * 10 + tens).toString(),
            (num + 10).toString(),
            (num - 1).toString(),
          ], rng);
          return MathProblem(
            title: 'Tens & Ones',
            prompt: 'What number has $tens Tens and $ones Ones?',
            correctAnswer: num.toString(),
            options: choices,
            inputType: ProblemInputType.multipleChoice,
            category: MathCategory.concepts,
            visualType: MathVisualType.placeValueBlocks,
            tensCount: tens,
            onesCount: ones,
            explanationSteps: [
              '$tens Tens = ${tens * 10}.',
              '$ones Ones = $ones.',
              '${tens * 10} + $ones = $num.',
            ],
          );
        } else {
          final n = 1 + rng.nextInt(20);
          final isEven = n % 2 == 0;
          final ans = isEven ? 'Even' : 'Odd';
          return MathProblem(
            title: 'Even or Odd?',
            prompt: 'Is the number $n Even or Odd?',
            subtitle: 'Even pairs equally (2, 4, 6...); Odd has one left over.',
            correctAnswer: ans,
            options: ['Even', 'Odd'],
            inputType: ProblemInputType.multipleChoice,
            category: MathCategory.concepts,
            explanationSteps: [
              'Divide $n by 2: $n ÷ 2 = ${n ~/ 2} with remainder ${n % 2}.',
              isEven
                  ? 'Since there is no remainder, $n is Even.'
                  : 'Since 1 is left over, $n is Odd.',
            ],
          );
        }
      case 4:
      default:
        final pool = [
          _generateConceptProblem(1, index, rng),
          _generateConceptProblem(2, index, rng),
          _generateConceptProblem(3, index, rng),
        ];
        final picked = pool[rng.nextInt(pool.length)];
        return MathProblem(
          title: '👑 Concepts Milestone',
          prompt: picked.prompt,
          subtitle: picked.subtitle,
          visualCount: picked.visualCount,
          visualType: picked.visualType,
          tensCount: picked.tensCount,
          onesCount: picked.onesCount,
          correctAnswer: picked.correctAnswer,
          options: picked.options,
          inputType: ProblemInputType.multipleChoice,
          category: MathCategory.concepts,
          explanationSteps: picked.explanationSteps,
        );
    }
  }

  static MathProblem _generateAdditionProblem(int level, int index, math.Random rng) {
    int a = 0;
    int b = 0;
    String sub = '1-Digit Addition';

    switch (level) {
      case 5:
        a = 1 + rng.nextInt(3);
        b = 1 + rng.nextInt(3);
        break;
      case 6:
        a = 1 + rng.nextInt(5);
        b = 1 + rng.nextInt(5);
        break;
      case 7:
        a = 5 + rng.nextInt(5);
        b = 5 + rng.nextInt(5);
        break;
      case 8:
        sub = '2-Digit + 1-Digit';
        a = 10 + rng.nextInt(40);
        b = 1 + rng.nextInt(math.max(1, 9 - (a % 10)));
        break;
      case 9:
        sub = '2-Digit + 1-Digit (Carrying)';
        a = 15 + rng.nextInt(75);
        b = math.max(1, (10 - (a % 10))) + rng.nextInt(math.max(1, math.min(9, a % 10 + 1)));
        break;
      case 10:
        sub = '2-Digit + 2-Digit';
        a = 11 + rng.nextInt(38);
        b = 11 + rng.nextInt(38);
        break;
      case 11:
        sub = '2-Digit + 2-Digit (Carrying)';
        a = 25 + rng.nextInt(65);
        b = 25 + rng.nextInt(65);
        break;
      case 12:
        sub = '3-Digit Addition';
        a = 100 + rng.nextInt(899);
        b = 100 + rng.nextInt(899);
        break;
      case 13:
        sub = '4-Digit Addition';
        a = 1000 + rng.nextInt(8999);
        b = 1000 + rng.nextInt(8999);
        break;
      case 14:
      default:
        sub = '👑 Addition Boss';
        a = 1000 + rng.nextInt(8999);
        b = 1000 + rng.nextInt(8999);
        break;
    }

    final sum = a + b;
    return MathProblem(
      title: sub,
      prompt: '$a + $b = ?',
      correctAnswer: sum.toString(),
      inputType: ProblemInputType.numberPad,
      category: MathCategory.addition,
      visualType: (a <= 10 && b <= 10) ? MathVisualType.numberLine : MathVisualType.none,
      numberLineStart: a,
      numberLineEnd: sum,
      numberLineStep: b,
      explanationSteps: [
        'Add the units column: ${a % 10} + ${b % 10} = ${(a % 10) + (b % 10)}.',
        if (a >= 10 || b >= 10) 'Add the tens: ${(a ~/ 10) * 10} + ${(b ~/ 10) * 10} = ${((a ~/ 10) + (b ~/ 10)) * 10}.',
        'Total sum = $sum.',
      ],
    );
  }

  static MathProblem _generateSubtractionProblem(int level, int index, math.Random rng) {
    int a = 0;
    int b = 0;
    String sub = '1-Digit Subtraction';

    switch (level) {
      case 15:
        a = 2 + rng.nextInt(4);
        b = 1 + rng.nextInt(a);
        break;
      case 16:
        a = 5 + rng.nextInt(5);
        b = 1 + rng.nextInt(a);
        break;
      case 17:
        a = 11 + rng.nextInt(8);
        b = (a - 9) + rng.nextInt(math.max(1, 9 - (a - 10)));
        break;
      case 18:
        sub = '2-Digit - 1-Digit';
        a = 21 + rng.nextInt(68);
        b = 1 + rng.nextInt(a % 10 + 1);
        break;
      case 19:
        sub = '2-Digit - 1-Digit (Borrowing)';
        a = 20 + rng.nextInt(70);
        b = (a % 10 + 1) + rng.nextInt(math.max(1, 9 - (a % 10)));
        break;
      case 20:
        sub = '2-Digit - 2-Digit';
        a = 30 + rng.nextInt(60);
        b = 10 + rng.nextInt(math.max(1, a - 15));
        break;
      case 21:
        sub = '2-Digit - 2-Digit (Borrowing)';
        a = 32 + rng.nextInt(60);
        b = 15 + rng.nextInt(math.max(1, a - 20));
        break;
      case 22:
        sub = '3-Digit Subtraction';
        a = 200 + rng.nextInt(799);
        b = 100 + rng.nextInt(math.max(1, a - 100));
        break;
      case 23:
        sub = '4-Digit Subtraction';
        a = 2000 + rng.nextInt(7999);
        b = 1000 + rng.nextInt(math.max(1, a - 1000));
        break;
      case 24:
      default:
        sub = '👑 Subtraction Boss';
        a = 2000 + rng.nextInt(7999);
        b = 1000 + rng.nextInt(math.max(1, a - 1000));
        break;
    }

    final diff = a - b;
    return MathProblem(
      title: sub,
      prompt: '$a - $b = ?',
      correctAnswer: diff.toString(),
      inputType: ProblemInputType.numberPad,
      category: MathCategory.subtraction,
      visualType: (a <= 20) ? MathVisualType.numberLine : MathVisualType.none,
      numberLineStart: a,
      numberLineEnd: diff,
      numberLineStep: -b,
      explanationSteps: [
        'Subtract $b from $a.',
        'Result = $diff.',
      ],
    );
  }

  static MathProblem _generateMultiplicationProblem(int level, int index, math.Random rng) {
    int a = 0;
    int b = 0;
    String sub = 'Multiplication';

    switch (level) {
      case 25:
        a = 2 + rng.nextInt(4);
        b = 2 + rng.nextInt(4);
        sub = 'Groups of Numbers';
        break;
      case 26:
        a = rng.nextBool() ? 2 : 3;
        b = 1 + rng.nextInt(10);
        sub = 'Times Table $a';
        break;
      case 27:
        a = rng.nextBool() ? 4 : 5;
        b = 1 + rng.nextInt(10);
        sub = 'Times Table $a';
        break;
      case 28:
        a = rng.nextBool() ? 6 : 7;
        b = 1 + rng.nextInt(10);
        sub = 'Times Table $a';
        break;
      case 29:
        a = rng.nextBool() ? 8 : 9;
        b = 1 + rng.nextInt(10);
        sub = 'Times Table $a';
        break;
      case 30:
        a = 10 + rng.nextInt(3);
        b = 1 + rng.nextInt(10);
        sub = 'Times Table $a';
        break;
      case 31:
        a = 12 + rng.nextInt(30);
        b = 2 + rng.nextInt(4);
        sub = '2-Digit × 1-Digit';
        break;
      case 32:
        a = 35 + rng.nextInt(60);
        b = 4 + rng.nextInt(6);
        sub = '2-Digit × 1-Digit (Advanced)';
        break;
      case 33:
        a = 12 + rng.nextInt(25);
        b = 12 + rng.nextInt(25);
        sub = '2-Digit × 2-Digit';
        break;
      case 34:
      default:
        a = 25 + rng.nextInt(75);
        b = 15 + rng.nextInt(85);
        sub = '👑 Multiplication Boss';
        break;
    }

    final product = a * b;
    return MathProblem(
      title: sub,
      prompt: '$a × $b = ?',
      correctAnswer: product.toString(),
      inputType: ProblemInputType.numberPad,
      category: MathCategory.multiplication,
      visualType: (a <= 6 && b <= 6) ? MathVisualType.arrayGrid : MathVisualType.none,
      visualRows: a <= 6 ? a : 0,
      visualCols: b <= 6 ? b : 0,
      explanationSteps: [
        '$a × $b is $b groups of $a.',
        'Total = $product.',
      ],
    );
  }

  static MathProblem _generateDivisionProblem(int level, int index, math.Random rng) {
    int divisor = 2;
    int quotient = 2;
    String sub = 'Division';

    switch (level) {
      case 35:
        divisor = 2 + rng.nextInt(3);
        quotient = 2 + rng.nextInt(4);
        sub = 'Equal Sharing';
        break;
      case 36:
        divisor = [2, 3, 4][rng.nextInt(3)];
        quotient = 1 + rng.nextInt(10);
        sub = 'Dividing by $divisor';
        break;
      case 37:
        divisor = rng.nextBool() ? 5 : 10;
        quotient = 1 + rng.nextInt(10);
        sub = 'Dividing by $divisor';
        break;
      case 38:
        divisor = 6 + rng.nextInt(4);
        quotient = 1 + rng.nextInt(10);
        sub = 'Dividing by $divisor';
        break;
      case 39:
        divisor = rng.nextBool() ? 11 : 12;
        quotient = 1 + rng.nextInt(10);
        sub = 'Dividing by $divisor';
        break;
      case 40:
        divisor = 3 + rng.nextInt(7);
        quotient = 11 + rng.nextInt(15);
        sub = '2-Digit ÷ 1-Digit';
        break;
      case 41:
        divisor = 6 + rng.nextInt(4);
        quotient = 15 + rng.nextInt(35);
        sub = '2-Digit ÷ 1-Digit (Advanced)';
        break;
      case 42:
        divisor = 3 + rng.nextInt(7);
        quotient = 100 + rng.nextInt(150);
        sub = '3-Digit ÷ 1-Digit';
        break;
      case 43:
        divisor = 12 + rng.nextInt(15);
        quotient = 12 + rng.nextInt(30);
        sub = '3-Digit ÷ 2-Digit';
        break;
      case 44:
      default:
        divisor = 15 + rng.nextInt(35);
        quotient = 25 + rng.nextInt(75);
        sub = '👑 Division Boss';
        break;
    }

    final dividend = divisor * quotient;
    return MathProblem(
      title: sub,
      prompt: '$dividend ÷ $divisor = ?',
      correctAnswer: quotient.toString(),
      inputType: ProblemInputType.numberPad,
      category: MathCategory.division,
      explanationSteps: [
        'How many $divisor\'s are in $dividend?',
        'Since $divisor × $quotient = $dividend, the answer is $quotient.',
      ],
    );
  }

  static MathProblem _generatePowersAndRootsProblem(int level, int index, math.Random rng) {
    if (level == 45) {
      final b = 1 + rng.nextInt(6);
      return MathProblem(
        title: 'Squares Basics',
        prompt: '$b² = ?',
        correctAnswer: (b * b).toString(),
        inputType: ProblemInputType.numberPad,
        category: MathCategory.powersRoots,
        visualType: MathVisualType.squareGrid,
        visualRows: b <= 8 ? b : 0,
        explanationSteps: ['$b² = $b × $b = ${b * b}.'],
      );
    } else if (level == 46) {
      final b = 7 + rng.nextInt(6);
      return MathProblem(
        title: 'Squares Advanced',
        prompt: '$b² = ?',
        correctAnswer: (b * b).toString(),
        inputType: ProblemInputType.numberPad,
        category: MathCategory.powersRoots,
        explanationSteps: ['$b² = $b × $b = ${b * b}.'],
      );
    } else if (level == 47) {
      final b = 13 + rng.nextInt(13);
      return MathProblem(
        title: '2-Digit Squares',
        prompt: '$b² = ?',
        correctAnswer: (b * b).toString(),
        inputType: ProblemInputType.numberPad,
        category: MathCategory.powersRoots,
        explanationSteps: ['$b² = $b × $b = ${b * b}.'],
      );
    } else if (level == 48) {
      final b = 2 + rng.nextInt(6);
      return MathProblem(
        title: 'Square Roots Basics',
        prompt: '√${b * b} = ?',
        correctAnswer: b.toString(),
        inputType: ProblemInputType.numberPad,
        category: MathCategory.powersRoots,
        explanationSteps: ['What number squared is ${b * b}? $b × $b = ${b * b}, so answer is $b.'],
      );
    } else if (level == 49) {
      final b = 8 + rng.nextInt(13);
      return MathProblem(
        title: 'Square Roots Advanced',
        prompt: '√${b * b} = ?',
        correctAnswer: b.toString(),
        inputType: ProblemInputType.numberPad,
        category: MathCategory.powersRoots,
        explanationSteps: ['$b × $b = ${b * b}, so √${b * b} = $b.'],
      );
    } else if (level == 50) {
      final b = 1 + rng.nextInt(5);
      return MathProblem(
        title: 'Cubes Basics',
        prompt: '$b³ = ?',
        correctAnswer: (b * b * b).toString(),
        inputType: ProblemInputType.numberPad,
        category: MathCategory.powersRoots,
        explanationSteps: ['$b³ = $b × $b × $b = ${b * b * b}.'],
      );
    } else if (level == 51) {
      final b = 6 + rng.nextInt(5);
      return MathProblem(
        title: 'Cubes Advanced',
        prompt: '$b³ = ?',
        correctAnswer: (b * b * b).toString(),
        inputType: ProblemInputType.numberPad,
        category: MathCategory.powersRoots,
        explanationSteps: ['$b³ = $b × $b × $b = ${b * b * b}.'],
      );
    } else if (level == 52) {
      final b = 1 + rng.nextInt(3);
      return MathProblem(
        title: 'Power 4 Basics',
        prompt: '$b⁴ = ?',
        correctAnswer: (b * b * b * b).toString(),
        inputType: ProblemInputType.numberPad,
        category: MathCategory.powersRoots,
        explanationSteps: ['$b⁴ = ($b²)² = ${b * b * b * b}.'],
      );
    } else if (level == 53) {
      final b = [4, 5, 10][rng.nextInt(3)];
      return MathProblem(
        title: 'Power 4 Advanced',
        prompt: '$b⁴ = ?',
        correctAnswer: (b * b * b * b).toString(),
        inputType: ProblemInputType.numberPad,
        category: MathCategory.powersRoots,
        explanationSteps: ['$b⁴ = ${b * b * b * b}.'],
      );
    } else {
      final pool = [
        _generatePowersAndRootsProblem(46, index, rng),
        _generatePowersAndRootsProblem(49, index, rng),
        _generatePowersAndRootsProblem(51, index, rng),
        _generatePowersAndRootsProblem(53, index, rng),
      ];
      final picked = pool[rng.nextInt(pool.length)];
      return MathProblem(
        title: '👑 Powers & Roots Boss',
        prompt: picked.prompt,
        correctAnswer: picked.correctAnswer,
        inputType: ProblemInputType.numberPad,
        category: MathCategory.powersRoots,
        explanationSteps: picked.explanationSteps,
      );
    }
  }

  static MathProblem _generateMasterPracticeProblem(int level, math.Random rng) {
    if (level == 55) {
      return rng.nextBool()
          ? _generateAdditionPractice(MathDifficulty.hard, rng)
          : _generateSubtractionPractice(MathDifficulty.hard, rng);
    } else if (level == 56) {
      return rng.nextBool()
          ? _generateMultiplicationPractice(MathDifficulty.hard, rng)
          : _generateDivisionPractice(MathDifficulty.hard, rng);
    } else if (level == 57) {
      return _generatePowersRootsPractice(MathDifficulty.hard, rng);
    } else if (level == 58) {
      return _generatePracticeSingleProblem(MathDifficulty.hard, null, rng);
    } else if (level == 59) {
      final p = _generatePracticeSingleProblem(MathDifficulty.hard, null, rng);
      return MathProblem(
        title: '👑 Grand Semi-Final Boss',
        prompt: p.prompt,
        correctAnswer: p.correctAnswer,
        options: p.options,
        inputType: p.inputType,
        category: p.category,
        explanationSteps: p.explanationSteps,
      );
    } else if (level == 60) {
      final p = _generatePracticeSingleProblem(MathDifficulty.hard, null, rng);
      return MathProblem(
        title: '👑 Graduation Boss',
        prompt: p.prompt,
        correctAnswer: p.correctAnswer,
        options: p.options,
        inputType: p.inputType,
        category: p.category,
        explanationSteps: p.explanationSteps,
      );
    } else {
      return _generatePracticeSingleProblem(MathDifficulty.hard, null, rng);
    }
  }

  static List<String> _generateChoices(
    String correct,
    List<String> pool,
    math.Random rng,
  ) {
    final choices = <String>{correct};
    final available = List<String>.from(pool)..remove(correct);
    available.shuffle(rng);

    for (final item in available) {
      if (choices.length >= 4) break;
      choices.add(item);
    }

    final list = choices.toList()..shuffle(rng);
    return list;
  }
}
