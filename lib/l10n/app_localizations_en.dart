// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Learn Math';

  @override
  String get appTagline => 'Think fast, solve smart';

  @override
  String get play => 'Play';

  @override
  String get dailyChallenge => 'Daily Challenge';

  @override
  String get level => 'Level';

  @override
  String get levels => 'Levels';

  @override
  String levelNumber(int number) {
    return 'Level $number';
  }

  @override
  String get specialGameModes => 'Special Game Modes';

  @override
  String get practice => 'Practice';

  @override
  String get settings => 'Settings';

  @override
  String get stats => 'Stats';

  @override
  String get score => 'Score';

  @override
  String get round => 'Round';

  @override
  String get preferences => 'PREFERENCES';

  @override
  String get language => 'Language';

  @override
  String get languageSubtitle => 'Select application language';

  @override
  String get hapticFeedback => 'Haptic Feedback';

  @override
  String get hapticFeedbackSubtitle => 'Vibrate on button taps and game events';

  @override
  String get stepExplanations => 'Step Explanations';

  @override
  String get stepExplanationsSubtitle => 'Show help icon during questions';

  @override
  String get aboutAndHelp => 'ABOUT & HELP';

  @override
  String get githubRepo => 'GitHub Repository';

  @override
  String get githubRepoSubtitle => 'Open source code & report issues';

  @override
  String get resetProgress => 'Reset Progress';

  @override
  String get resetProgressQuestion => 'Reset Progress?';

  @override
  String get resetProgressWarning =>
      'This clears all completed levels and returns you to Level 1. This action cannot be undone.';

  @override
  String get cancel => 'Cancel';

  @override
  String get reset => 'Reset';

  @override
  String get timeAttackTitle => 'Time Attack Blitz';

  @override
  String get timeAttackSubtitle =>
      '60 seconds speed rush with +2s time bonus per correct answer';

  @override
  String get survivalTitle => 'Endless Survival';

  @override
  String get survivalSubtitle =>
      '3 Hearts. Increasing difficulty. How far can you survive?';

  @override
  String get duelTitle => '2-Player Split-Screen Duel';

  @override
  String get duelSubtitle =>
      'Race a friend head-to-head on the same screen to 10 points';

  @override
  String get target24Title => 'Target 24 Puzzle';

  @override
  String get target24Subtitle =>
      'Use 4 numbers and operations to build an equation that equals 24';

  @override
  String get practiceSetup => 'Practice Setup';

  @override
  String get difficulty => 'DIFFICULTY';

  @override
  String get easy => 'EASY';

  @override
  String get medium => 'MEDIUM';

  @override
  String get hard => 'HARD';

  @override
  String get questions => 'QUESTIONS';

  @override
  String nQuestions(int count) {
    return '$count Questions';
  }

  @override
  String get category => 'CATEGORY';

  @override
  String get allMixed => 'All Mixed';

  @override
  String get startPractice => 'Start Practice';

  @override
  String get newPractice => 'New Practice';

  @override
  String get analyticsAndAchievements => 'Analytics & Achievements';

  @override
  String totalXpEarned(int xp) {
    return '$xp Total XP Earned';
  }

  @override
  String get levelProgress => 'Level Progress';

  @override
  String xpOutOf(int current, int total) {
    return '$current / $total XP';
  }

  @override
  String get accuracy => 'Accuracy';

  @override
  String get accuracySubtitle => 'Overall problem solving accuracy';

  @override
  String get solvedProblems => 'Solved Problems';

  @override
  String get solvedProblemsSubtitle => 'Total math problems completed';

  @override
  String get dailyStreak => 'Daily Streak';

  @override
  String dailyStreakDays(int days) {
    return '$days Days';
  }

  @override
  String get dailyStreakSubtitle => 'Consecutive active practice days';

  @override
  String get focusRecommendation => 'Focus Recommendation';

  @override
  String focusAreaAccuracy(String category, String percent) {
    return 'Accuracy on $category is $percent%. Practice this area to level up faster!';
  }

  @override
  String mistakesSavedForReview(int count) {
    return 'You have $count mistakes saved for review.';
  }

  @override
  String reviewMistakes(int count) {
    return 'Review Mistakes ($count)';
  }

  @override
  String get mistakesDrill => 'Mistakes Drill';

  @override
  String get mistakeReview => 'Mistake Review';

  @override
  String get masteryBreakdown => 'Mastery Breakdown';

  @override
  String get unplayed => 'Unplayed';

  @override
  String get badges => 'Badges';

  @override
  String get unlocked => 'unlocked';

  @override
  String get specialSession => 'Special Session';

  @override
  String bossLevel(int number) {
    return 'Boss Level $number';
  }

  @override
  String questionProgress(int current, int total) {
    return 'Question $current of $total';
  }

  @override
  String streakCount(int count) {
    return '$count Streak';
  }

  @override
  String get scratchpad => 'Scratchpad';

  @override
  String get undo => 'Undo';

  @override
  String get clear => 'Clear';

  @override
  String get explainStep => 'Explain Step';

  @override
  String get stepByStepExplanation => 'Step-by-Step Explanation';

  @override
  String correctAnswerIs(String answer) {
    return 'The correct answer is $answer.';
  }

  @override
  String get correctAnswer => 'Correct Answer:';

  @override
  String nextStep(int current, int total) {
    return 'Next Step ($current/$total)';
  }

  @override
  String get gotIt => 'Got It!';

  @override
  String completeWithTitle(String title) {
    return '$title Complete!';
  }

  @override
  String get practiceComplete => 'Practice Complete!';

  @override
  String get perfectScore => 'Perfect Score!';

  @override
  String get levelComplete => 'Level Complete!';

  @override
  String solvedCountSummary(int score, int total) {
    return 'You solved $score of $total questions correctly.';
  }

  @override
  String xpEarned(int xp) {
    return '+$xp XP Earned';
  }

  @override
  String get nextLevel => 'Next Level';

  @override
  String get home => 'Home';

  @override
  String get buyMeACoffee => 'Buy Me a Coffee';

  @override
  String get newBestScore => 'New Best Score!';

  @override
  String get timesUp => 'Time\'s Up!';

  @override
  String finalScore(int score) {
    return 'Final Score: $score';
  }

  @override
  String bestScore(int score) {
    return 'Best: $score';
  }

  @override
  String get playAgain => 'Play Again';

  @override
  String get exit => 'Exit';

  @override
  String get newSurvivalRecord => 'New Survival Record!';

  @override
  String get gameOver => 'Game Over';

  @override
  String roundsCleared(int rounds) {
    return 'Rounds Cleared: $rounds';
  }

  @override
  String bestRounds(int rounds) {
    return 'Best: $rounds Rounds';
  }

  @override
  String get tryAgain => 'Try Again';

  @override
  String playerWins(int player) {
    return 'Player $player Wins!';
  }

  @override
  String duelScoreSummary(int p1, int p2) {
    return 'Score: P1 ($p1) vs P2 ($p2)';
  }

  @override
  String get puzzleHint => 'Puzzle Hint';

  @override
  String oneSolutionIs(String solution) {
    return 'One solution is:\n\n$solution';
  }

  @override
  String get ok => 'OK';

  @override
  String get useAll4Numbers => 'Use all 4 numbers!';

  @override
  String correctEqualsTarget(int target) {
    return 'Correct! Equals $target 🎉';
  }

  @override
  String get invalidExpression => 'Invalid expression';

  @override
  String get invalidMathSyntax => 'Invalid math syntax';

  @override
  String equalsTarget(String val, int target) {
    return 'Equals $val (Target: $target)';
  }

  @override
  String get mathNovice => 'Math Novice';

  @override
  String get apprentice => 'Apprentice';

  @override
  String get mathlete => 'Mathlete';

  @override
  String get arithmeticMaster => 'Arithmetic Master';

  @override
  String get grandmaster => 'Grandmaster';

  @override
  String get badgeFirstStepTitle => 'First Step';

  @override
  String get badgeFirstStepDesc => 'Complete your first math level';

  @override
  String get badgeStreak5Title => 'Hot Streak';

  @override
  String get badgeStreak5Desc => 'Reach a streak of 5 correct answers';

  @override
  String get badgeStreak15Title => 'Unstoppable';

  @override
  String get badgeStreak15Desc => 'Reach a streak of 15 correct answers';

  @override
  String get badgeCenturyTitle => 'Century Club';

  @override
  String get badgeCenturyDesc => 'Solve 100 math problems correctly';

  @override
  String get badgeSpeedDemonTitle => 'Speed Demon';

  @override
  String get badgeSpeedDemonDesc => 'Score 15+ in Time Attack mode';

  @override
  String get badgeSurvivorTitle => 'Survivor';

  @override
  String get badgeSurvivorDesc => 'Survive 15+ rounds in Survival mode';

  @override
  String get badgeTargetMasterTitle => 'Number Wizard';

  @override
  String get badgeTargetMasterDesc => 'Solve 5 Target 24 puzzles';

  @override
  String get badgeDailyChampionTitle => 'Dedicated Learner';

  @override
  String get badgeDailyChampionDesc => 'Maintain a 3-day daily streak';

  @override
  String get badgeBossSlayerTitle => 'Boss Slayer';

  @override
  String get badgeBossSlayerDesc => 'Defeat a milestone review boss level';

  @override
  String get badgeGrandMasterTitle => 'Grandmaster';

  @override
  String get badgeGrandMasterDesc => 'Complete all 60 curriculum levels';

  @override
  String get categoryConcepts => 'Concepts';

  @override
  String get categoryAddition => 'Addition';

  @override
  String get categorySubtraction => 'Subtraction';

  @override
  String get categoryMultiplication => 'Multiplication';

  @override
  String get categoryDivision => 'Division';

  @override
  String get categoryPowersRoots => 'Powers & Roots';

  @override
  String get categoryMaster => 'Master Practice';

  @override
  String get categoryFractions => 'Fractions';

  @override
  String get categoryPercentages => 'Percentages';

  @override
  String get categoryPowers => 'Powers';

  @override
  String get categoryAlgebra => 'Algebra';

  @override
  String playerNumber(int player) {
    return 'Player $player';
  }

  @override
  String get makeTargetNumber => 'Make the Target Number';

  @override
  String puzzlesSolved(int count) {
    return '$count Puzzles Solved';
  }

  @override
  String targetLabel(int target) {
    return 'Target: $target';
  }

  @override
  String get tapNumbersOperators => 'Tap numbers & operators';

  @override
  String get nextPuzzle => 'Next Puzzle';

  @override
  String get checkEquation => 'Check Equation';

  @override
  String get newPuzzle => 'New Puzzle';

  @override
  String get hint => 'Hint';

  @override
  String playerScore(int player, int score, int target) {
    return 'P$player: $score/$target';
  }

  @override
  String rowsCols(int rows, int cols) {
    return '$rows rows × $cols columns';
  }

  @override
  String startAt(int value) {
    return 'Start at $value';
  }

  @override
  String endAt(int value) {
    return 'End at $value';
  }

  @override
  String jumpStep(int step) {
    return '$step jump';
  }

  @override
  String jumpStepPositive(int step) {
    return '+$step jump';
  }

  @override
  String tensVisual(int count, int value) {
    return '$count Tens ($value)';
  }

  @override
  String onesVisual(int count, int value) {
    return '$count Ones ($value)';
  }
}
