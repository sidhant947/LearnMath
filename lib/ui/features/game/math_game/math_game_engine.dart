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
              ? 'Zero means nothing or an empty space — there are no items to count!'
              : 'Count each glowing dot one by one: 1, 2, 3... until you reach $count.',
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
          'First, $tens Tens means $tens groups of 10, which equals ${tens * 10}.',
          'Next, $ones Ones simply equals $ones.',
          'Finally, combine them together: ${tens * 10} plus $ones gives $num.',
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
          'First, $hundreds Hundreds means $hundreds groups of 100 = ${hundreds * 100}.',
          'Next, $tens Tens means $tens groups of 10 = ${tens * 10}.',
          'Then, $ones Ones equals $ones.',
          'Add them all up: ${hundreds * 100} + ${tens * 10} + $ones = $num.',
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
        'Line up the numbers: starting with $a and adding $b.',
        'First, add the ones digits: ${a % 10} + ${b % 10} = ${(a % 10) + (b % 10)}.',
        'Next, add the remaining digits (tens and hundreds) along with any carry over.',
        'Putting it all together: $a + $b = $sum.',
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
        'Start at the total amount: $a.',
        'Count backward or take away $b step by step.',
        'You are left with: $diff.',
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
        'Multiplication ($a × $b) means adding $a a total of $b times.',
        if (a <= 10) 'Think of making $b groups with $a items in each group: $a + ... = $product.'
        else 'Break $a into parts: ${(a ~/ 10) * 10} + ${a % 10}.',
        if (a > 10) 'Multiply tens: ${(a ~/ 10) * 10} × $b = ${(a ~/ 10) * 10 * b}, then ones: ${a % 10} × $b = ${(a % 10) * b}.',
        if (a > 10) 'Add the parts: ${(a ~/ 10) * 10 * b} + ${(a % 10) * b} = $product.'
        else 'Final product: $product.',
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
        'Division ($dividend ÷ $divisor) means splitting a total of $dividend into $divisor equal groups.',
        'Ask: How many times does $divisor fit into $dividend?',
        'Verify with multiplication: $quotient × $divisor = $dividend.',
        'Result: Each group receives $quotient.',
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
            'The square root symbol (√) asks: "What number multiplied by ITSELF equals $sq?"',
            'Test candidate: $b × $b = $sq.',
            'Therefore, √$sq = $b.',
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
            'The small ² exponent means "square" — multiply $b by itself ($b × $b).',
            'Calculation: $b × $b = ${b * b}.',
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
          visualType: MathVisualType.squareGrid,
          visualRows: b <= 8 ? b : 0,
          explanationSteps: [
            '$b² means multiplying $b by itself ($b × $b).',
            'Break $b into 10 + ${b % 10}: ($b × 10 = ${b * 10}) plus ($b × ${b % 10} = ${b * (b % 10)}).',
            'Add them together: ${b * 10} + ${b * (b % 10)} = ${b * b}.',
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
            'The square root (√$sq) asks what mystery number times itself equals $sq.',
            'Check: $b × $b = $sq.',
            'So the square root of $sq is $b.',
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
            'The ³ exponent means "cube" — multiply $b by itself 3 times ($b × $b × $b).',
            'Step 1 (square): $b × $b = ${b * b}.',
            'Step 2 (cube): ${b * b} × $b = ${b * b * b}.',
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
            '$b² means multiplying $b by itself: $b × $b.',
            'Final calculation: $b × $b = ${b * b}.',
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
            'Find the mystery number that gives $sq when multiplied by itself.',
            'Since $b × $b = $sq, √$sq = $b.',
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
            '$b³ means multiplying $b by itself 3 times ($b × $b × $b).',
            'Step 1: $b × $b = ${b * b}.',
            'Step 2: Multiply ${b * b} × $b = ${b * b * b}.',
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
            '$b⁴ means multiplying $b by itself 4 times ($b × $b × $b × $b).',
            'Step 1 (square): $b × $b = ${b * b}.',
            'Step 2 (power of 4): Square ${b * b} again: ${b * b} × ${b * b} = ${b * b * b * b}.',
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
        'First, add the ones digits: ${a % 10} + ${b % 10} = ${(a % 10) + (b % 10)}.',
        if (a >= 10 || b >= 10) 'Next, add the tens digits: ${(a ~/ 10) * 10} + ${(b ~/ 10) * 10} = ${((a ~/ 10) + (b ~/ 10)) * 10}.',
        'Add them together to get the final sum: $sum.',
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
        'Start with the starting amount of $a.',
        'Take away $b step by step.',
        'You are left with $diff.',
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
        'Think of $a × $b as adding $a to itself $b times.',
        'Counting up all $b groups of $a gives $product.',
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
        'Imagine dividing $dividend into $divisor equal parts.',
        'Because $divisor × $quotient = $dividend, the result is $quotient.',
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
        explanationSteps: [
          'Squaring ($b²) means multiplying $b by itself.',
          'Result: $b × $b = ${b * b}.',
        ],
      );
    } else if (level == 46) {
      final b = 7 + rng.nextInt(6);
      return MathProblem(
        title: 'Squares Advanced',
        prompt: '$b² = ?',
        correctAnswer: (b * b).toString(),
        inputType: ProblemInputType.numberPad,
        category: MathCategory.powersRoots,
        explanationSteps: [
          'Multiply $b by itself: $b × $b.',
          'Result: $b × $b = ${b * b}.',
        ],
      );
    } else if (level == 47) {
      final b = 13 + rng.nextInt(13);
      return MathProblem(
        title: '2-Digit Squares',
        prompt: '$b² = ?',
        correctAnswer: (b * b).toString(),
        inputType: ProblemInputType.numberPad,
        category: MathCategory.powersRoots,
        explanationSteps: [
          'Multiply $b by itself ($b × $b).',
          'Result: ${b * b}.',
        ],
      );
    } else if (level == 48) {
      final b = 2 + rng.nextInt(6);
      return MathProblem(
        title: 'Square Roots Basics',
        prompt: '√${b * b} = ?',
        correctAnswer: b.toString(),
        inputType: ProblemInputType.numberPad,
        category: MathCategory.powersRoots,
        explanationSteps: [
          'Ask: What number times itself equals ${b * b}?',
          'Since $b × $b = ${b * b}, the answer is $b.',
        ],
      );
    } else if (level == 49) {
      final b = 8 + rng.nextInt(13);
      return MathProblem(
        title: 'Square Roots Advanced',
        prompt: '√${b * b} = ?',
        correctAnswer: b.toString(),
        inputType: ProblemInputType.numberPad,
        category: MathCategory.powersRoots,
        explanationSteps: [
          'Find the number that gives ${b * b} when multiplied by itself.',
          'Because $b × $b = ${b * b}, √${b * b} = $b.',
        ],
      );
    } else if (level == 50) {
      final b = 1 + rng.nextInt(5);
      return MathProblem(
        title: 'Cubes Basics',
        prompt: '$b³ = ?',
        correctAnswer: (b * b * b).toString(),
        inputType: ProblemInputType.numberPad,
        category: MathCategory.powersRoots,
        explanationSteps: [
          'Cubing ($b³) means multiplying $b by itself 3 times.',
          'First, $b × $b = ${b * b}.',
          'Then, ${b * b} × $b = ${b * b * b}.',
        ],
      );
    } else if (level == 51) {
      final b = 6 + rng.nextInt(5);
      return MathProblem(
        title: 'Cubes Advanced',
        prompt: '$b³ = ?',
        correctAnswer: (b * b * b).toString(),
        inputType: ProblemInputType.numberPad,
        category: MathCategory.powersRoots,
        explanationSteps: [
          'Multiply $b by itself 3 times: $b × $b × $b.',
          'Result: ${b * b * b}.',
        ],
      );
    } else if (level == 52) {
      final b = 1 + rng.nextInt(3);
      return MathProblem(
        title: 'Power 4 Basics',
        prompt: '$b⁴ = ?',
        correctAnswer: (b * b * b * b).toString(),
        inputType: ProblemInputType.numberPad,
        category: MathCategory.powersRoots,
        explanationSteps: [
          'Multiply $b by itself 4 times: $b × $b × $b × $b.',
          'Result: ${b * b * b * b}.',
        ],
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
