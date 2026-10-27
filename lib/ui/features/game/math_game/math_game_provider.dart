import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnmath/domain/models/math_problem.dart';
import 'package:learnmath/ui/features/game/math_game/math_game_engine.dart';
import 'package:learnmath/ui/providers.dart';

class MathGameState {
  const MathGameState({
    this.levelNumber = 1,
    this.isRandom = false,
    this.difficulty = MathDifficulty.medium,
    this.category,
    this.problems = const [],
    this.currentQuestionIndex = 0,
    this.currentInput = '',
    this.selectedOption,
    this.isSolved = false,
    this.lastAnswerCorrect,
    this.correctCount = 0,
    this.streak = 0,
    this.isChecking = false,
    this.earnedXp = 0,
    this.sessionMistakes = const [],
    this.isReviewPhase = false,
    this.reviewQueue = const [],
  });

  final int levelNumber;
  final bool isRandom;
  final MathDifficulty difficulty;
  final MathCategory? category;
  final List<MathProblem> problems;
  final int currentQuestionIndex;
  final String currentInput;
  final String? selectedOption;
  final bool isSolved;
  final bool? lastAnswerCorrect;
  final int correctCount;
  final int streak;
  final bool isChecking;
  final int earnedXp;
  final List<MathProblem> sessionMistakes;
  final bool isReviewPhase;
  final List<MathProblem> reviewQueue;

  MathProblem? get currentProblem {
    if (isReviewPhase) {
      return reviewQueue.isNotEmpty ? reviewQueue.first : null;
    }
    return (problems.isNotEmpty && currentQuestionIndex < problems.length)
        ? problems[currentQuestionIndex]
        : null;
  }

  int get totalQuestions => problems.length;

  MathGameState copyWith({
    int? levelNumber,
    bool? isRandom,
    MathDifficulty? difficulty,
    MathCategory? category,
    List<MathProblem>? problems,
    int? currentQuestionIndex,
    String? currentInput,
    String? selectedOption,
    bool? isSolved,
    bool? lastAnswerCorrect,
    int? correctCount,
    int? streak,
    bool? isChecking,
    int? earnedXp,
    List<MathProblem>? sessionMistakes,
    bool? isReviewPhase,
    List<MathProblem>? reviewQueue,
    bool clearSelectedOption = false,
    bool clearLastAnswer = false,
  }) {
    return MathGameState(
      levelNumber: levelNumber ?? this.levelNumber,
      isRandom: isRandom ?? this.isRandom,
      difficulty: difficulty ?? this.difficulty,
      category: category ?? this.category,
      problems: problems ?? this.problems,
      currentQuestionIndex:
          currentQuestionIndex ?? this.currentQuestionIndex,
      currentInput: currentInput ?? this.currentInput,
      selectedOption: clearSelectedOption
          ? null
          : (selectedOption ?? this.selectedOption),
      isSolved: isSolved ?? this.isSolved,
      lastAnswerCorrect: clearLastAnswer
          ? null
          : (lastAnswerCorrect ?? this.lastAnswerCorrect),
      correctCount: correctCount ?? this.correctCount,
      streak: streak ?? this.streak,
      isChecking: isChecking ?? this.isChecking,
      earnedXp: earnedXp ?? this.earnedXp,
      sessionMistakes: sessionMistakes ?? this.sessionMistakes,
      isReviewPhase: isReviewPhase ?? this.isReviewPhase,
      reviewQueue: reviewQueue ?? this.reviewQueue,
    );
  }
}

class MathGameViewModel extends Notifier<MathGameState> {
  @override
  MathGameState build() {
    return const MathGameState();
  }

  void initGame({
    required int levelNumber,
    bool isRandom = false,
    MathDifficulty difficulty = MathDifficulty.medium,
    MathCategory? category,
    int questionCount = 5,
    List<MathProblem>? customProblems,
  }) {
    List<MathProblem> problems;
    if (customProblems != null && customProblems.isNotEmpty) {
      problems = customProblems;
    } else if (isRandom) {
      problems = MathGameEngine.generatePracticeProblems(
        difficulty: difficulty,
        count: questionCount,
        category: category,
      );
    } else {
      problems = MathGameEngine.generateProblemsForLevel(levelNumber);
    }

    state = MathGameState(
      levelNumber: levelNumber,
      isRandom: isRandom,
      difficulty: difficulty,
      category: category,
      problems: problems,
      currentQuestionIndex: 0,
      currentInput: '',
      isSolved: false,
      correctCount: 0,
      streak: 0,
      isChecking: false,
      earnedXp: 0,
      sessionMistakes: const [],
      isReviewPhase: false,
      reviewQueue: const [],
    );
  }

  void appendDigit(String digit) {
    if (state.isChecking || state.isSolved) return;
    if (state.currentInput.length >= 8) return;
    state = state.copyWith(currentInput: state.currentInput + digit);
  }

  void deleteDigit() {
    if (state.isChecking || state.isSolved) return;
    if (state.currentInput.isNotEmpty) {
      state = state.copyWith(
        currentInput: state.currentInput.substring(
          0,
          state.currentInput.length - 1,
        ),
      );
    }
  }

  void clearInput() {
    if (state.isChecking || state.isSolved) return;
    state = state.copyWith(currentInput: '');
  }

  Future<void> submitInput() async {
    if (state.isChecking || state.isSolved) return;
    final problem = state.currentProblem;
    if (problem == null || state.currentInput.isEmpty) return;

    final isCorrect = state.currentInput.trim() == problem.correctAnswer.trim();
    await _handleAnswer(isCorrect);
  }

  Future<void> selectOption(String option) async {
    if (state.isChecking || state.isSolved) return;
    final problem = state.currentProblem;
    if (problem == null) return;

    final isCorrect = option.trim() == problem.correctAnswer.trim();
    state = state.copyWith(selectedOption: option);
    await _handleAnswer(isCorrect);
  }

  Future<void> _handleAnswer(bool isCorrect) async {
    final problem = state.currentProblem;
    final newStreak = isCorrect ? state.streak + 1 : 0;
    final xpThisQuestion = isCorrect ? (10 + (newStreak >= 3 ? 5 : 0)) : 0;

    List<MathProblem> mistakes = List.of(state.sessionMistakes);
    if (!state.isReviewPhase && !isCorrect && problem != null && !mistakes.contains(problem)) {
      mistakes.add(problem);
    }

    state = state.copyWith(
      isChecking: true,
      lastAnswerCorrect: isCorrect,
      correctCount: (!state.isReviewPhase && isCorrect)
          ? state.correctCount + 1
          : state.correctCount,
      streak: newStreak,
      earnedXp: state.earnedXp + xpThisQuestion,
      sessionMistakes: mistakes,
    );

    if (problem != null) {
      final promptText = problem.prompt.endsWith(' = ?')
          ? problem.prompt.substring(0, problem.prompt.length - 4).trim()
          : problem.prompt;
      final mistakeData = '$promptText = ${problem.correctAnswer}';
      ref.read(progressRepositoryProvider).recordAnswer(
        categoryKey: problem.category.name,
        isCorrect: isCorrect,
        streak: newStreak,
        mistakeData: mistakeData,
      );
    }

    await Future.delayed(const Duration(milliseconds: 550));

    if (state.isReviewPhase) {
      final queue = List<MathProblem>.of(state.reviewQueue);
      if (queue.isNotEmpty) {
        final current = queue.removeAt(0);
        if (!isCorrect) {
          queue.add(current);
        }
      }

      if (queue.isEmpty) {
        state = state.copyWith(
          isSolved: true,
          isChecking: false,
          reviewQueue: const [],
          clearSelectedOption: true,
          clearLastAnswer: true,
        );
      } else {
        state = state.copyWith(
          reviewQueue: queue,
          currentInput: '',
          isChecking: false,
          clearSelectedOption: true,
          clearLastAnswer: true,
        );
      }
      return;
    }

    final nextIndex = state.currentQuestionIndex + 1;
    if (nextIndex >= state.totalQuestions) {
      if (state.sessionMistakes.isNotEmpty) {
        state = state.copyWith(
          isReviewPhase: true,
          reviewQueue: List.of(state.sessionMistakes),
          currentInput: '',
          isChecking: false,
          clearSelectedOption: true,
          clearLastAnswer: true,
        );
      } else {
        state = state.copyWith(
          isSolved: true,
          isChecking: false,
          clearSelectedOption: true,
          clearLastAnswer: true,
        );
      }
    } else {
      state = state.copyWith(
        currentQuestionIndex: nextIndex,
        currentInput: '',
        isChecking: false,
        clearSelectedOption: true,
        clearLastAnswer: true,
      );
    }
  }

  void restartLevel() {
    initGame(
      levelNumber: state.levelNumber,
      isRandom: state.isRandom,
      difficulty: state.difficulty,
      category: state.category,
      questionCount: state.totalQuestions,
      customProblems: state.isRandom ? null : state.problems,
    );
  }
}

final mathGameViewModelProvider =
    NotifierProvider<MathGameViewModel, MathGameState>(
  MathGameViewModel.new,
);
