enum ProblemInputType {
  multipleChoice,
  numberPad,
}

enum MathCategory {
  concepts,
  addition,
  subtraction,
  multiplication,
  division,
  powersRoots,
  master,
}

enum MathDifficulty {
  easy,
  medium,
  hard,
}

enum MathVisualType {
  none,
  dots,
  arrayGrid,
  numberLine,
  placeValueBlocks,
  squareGrid,
}

class MathProblem {
  const MathProblem({
    required this.title,
    required this.prompt,
    required this.correctAnswer,
    this.subtitle,
    this.visualCount = 0,
    this.visualType = MathVisualType.none,
    this.visualRows = 0,
    this.visualCols = 0,
    this.numberLineStart = 0,
    this.numberLineEnd = 10,
    this.numberLineStep = 0,
    this.tensCount = 0,
    this.onesCount = 0,
    this.options = const [],
    this.inputType = ProblemInputType.numberPad,
    this.category = MathCategory.addition,
    this.explanationSteps = const [],
  });

  final String title;
  final String prompt;
  final String? subtitle;
  final int visualCount;
  final MathVisualType visualType;
  final int visualRows;
  final int visualCols;
  final int numberLineStart;
  final int numberLineEnd;
  final int numberLineStep;
  final int tensCount;
  final int onesCount;
  final List<String> options;
  final String correctAnswer;
  final ProblemInputType inputType;
  final MathCategory category;
  final List<String> explanationSteps;
}
