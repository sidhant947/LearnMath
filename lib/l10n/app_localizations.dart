import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Learn Math'**
  String get appTitle;

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'Think fast, solve smart'**
  String get appTagline;

  /// No description provided for @play.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get play;

  /// No description provided for @dailyChallenge.
  ///
  /// In en, this message translates to:
  /// **'Daily Challenge'**
  String get dailyChallenge;

  /// No description provided for @level.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get level;

  /// No description provided for @levels.
  ///
  /// In en, this message translates to:
  /// **'Levels'**
  String get levels;

  /// No description provided for @levelNumber.
  ///
  /// In en, this message translates to:
  /// **'Level {number}'**
  String levelNumber(int number);

  /// No description provided for @specialGameModes.
  ///
  /// In en, this message translates to:
  /// **'Special Game Modes'**
  String get specialGameModes;

  /// No description provided for @practice.
  ///
  /// In en, this message translates to:
  /// **'Practice'**
  String get practice;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @stats.
  ///
  /// In en, this message translates to:
  /// **'Stats'**
  String get stats;

  /// No description provided for @score.
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get score;

  /// No description provided for @round.
  ///
  /// In en, this message translates to:
  /// **'Round'**
  String get round;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'PREFERENCES'**
  String get preferences;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select application language'**
  String get languageSubtitle;

  /// No description provided for @hapticFeedback.
  ///
  /// In en, this message translates to:
  /// **'Haptic Feedback'**
  String get hapticFeedback;

  /// No description provided for @hapticFeedbackSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Vibrate on button taps and game events'**
  String get hapticFeedbackSubtitle;

  /// No description provided for @stepExplanations.
  ///
  /// In en, this message translates to:
  /// **'Step Explanations'**
  String get stepExplanations;

  /// No description provided for @stepExplanationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Show help icon during questions'**
  String get stepExplanationsSubtitle;

  /// No description provided for @aboutAndHelp.
  ///
  /// In en, this message translates to:
  /// **'ABOUT & HELP'**
  String get aboutAndHelp;

  /// No description provided for @githubRepo.
  ///
  /// In en, this message translates to:
  /// **'GitHub Repository'**
  String get githubRepo;

  /// No description provided for @githubRepoSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Open source code & report issues'**
  String get githubRepoSubtitle;

  /// No description provided for @resetProgress.
  ///
  /// In en, this message translates to:
  /// **'Reset Progress'**
  String get resetProgress;

  /// No description provided for @resetProgressQuestion.
  ///
  /// In en, this message translates to:
  /// **'Reset Progress?'**
  String get resetProgressQuestion;

  /// No description provided for @resetProgressWarning.
  ///
  /// In en, this message translates to:
  /// **'This clears all completed levels and returns you to Level 1. This action cannot be undone.'**
  String get resetProgressWarning;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @timeAttackTitle.
  ///
  /// In en, this message translates to:
  /// **'Time Attack Blitz'**
  String get timeAttackTitle;

  /// No description provided for @timeAttackSubtitle.
  ///
  /// In en, this message translates to:
  /// **'60 seconds speed rush with +2s time bonus per correct answer'**
  String get timeAttackSubtitle;

  /// No description provided for @survivalTitle.
  ///
  /// In en, this message translates to:
  /// **'Endless Survival'**
  String get survivalTitle;

  /// No description provided for @survivalSubtitle.
  ///
  /// In en, this message translates to:
  /// **'3 Hearts. Increasing difficulty. How far can you survive?'**
  String get survivalSubtitle;

  /// No description provided for @duelTitle.
  ///
  /// In en, this message translates to:
  /// **'2-Player Split-Screen Duel'**
  String get duelTitle;

  /// No description provided for @duelSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Race a friend head-to-head on the same screen to 10 points'**
  String get duelSubtitle;

  /// No description provided for @target24Title.
  ///
  /// In en, this message translates to:
  /// **'Target 24 Puzzle'**
  String get target24Title;

  /// No description provided for @target24Subtitle.
  ///
  /// In en, this message translates to:
  /// **'Use 4 numbers and operations to build an equation that equals 24'**
  String get target24Subtitle;

  /// No description provided for @practiceSetup.
  ///
  /// In en, this message translates to:
  /// **'Practice Setup'**
  String get practiceSetup;

  /// No description provided for @difficulty.
  ///
  /// In en, this message translates to:
  /// **'DIFFICULTY'**
  String get difficulty;

  /// No description provided for @easy.
  ///
  /// In en, this message translates to:
  /// **'EASY'**
  String get easy;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'MEDIUM'**
  String get medium;

  /// No description provided for @hard.
  ///
  /// In en, this message translates to:
  /// **'HARD'**
  String get hard;

  /// No description provided for @questions.
  ///
  /// In en, this message translates to:
  /// **'QUESTIONS'**
  String get questions;

  /// No description provided for @nQuestions.
  ///
  /// In en, this message translates to:
  /// **'{count} Questions'**
  String nQuestions(int count);

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'CATEGORY'**
  String get category;

  /// No description provided for @allMixed.
  ///
  /// In en, this message translates to:
  /// **'All Mixed'**
  String get allMixed;

  /// No description provided for @startPractice.
  ///
  /// In en, this message translates to:
  /// **'Start Practice'**
  String get startPractice;

  /// No description provided for @newPractice.
  ///
  /// In en, this message translates to:
  /// **'New Practice'**
  String get newPractice;

  /// No description provided for @analyticsAndAchievements.
  ///
  /// In en, this message translates to:
  /// **'Analytics & Achievements'**
  String get analyticsAndAchievements;

  /// No description provided for @totalXpEarned.
  ///
  /// In en, this message translates to:
  /// **'{xp} Total XP Earned'**
  String totalXpEarned(int xp);

  /// No description provided for @levelProgress.
  ///
  /// In en, this message translates to:
  /// **'Level Progress'**
  String get levelProgress;

  /// No description provided for @xpOutOf.
  ///
  /// In en, this message translates to:
  /// **'{current} / {total} XP'**
  String xpOutOf(int current, int total);

  /// No description provided for @accuracy.
  ///
  /// In en, this message translates to:
  /// **'Accuracy'**
  String get accuracy;

  /// No description provided for @accuracySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Overall problem solving accuracy'**
  String get accuracySubtitle;

  /// No description provided for @solvedProblems.
  ///
  /// In en, this message translates to:
  /// **'Solved Problems'**
  String get solvedProblems;

  /// No description provided for @solvedProblemsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Total math problems completed'**
  String get solvedProblemsSubtitle;

  /// No description provided for @dailyStreak.
  ///
  /// In en, this message translates to:
  /// **'Daily Streak'**
  String get dailyStreak;

  /// No description provided for @dailyStreakDays.
  ///
  /// In en, this message translates to:
  /// **'{days} Days'**
  String dailyStreakDays(int days);

  /// No description provided for @dailyStreakSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Consecutive active practice days'**
  String get dailyStreakSubtitle;

  /// No description provided for @focusRecommendation.
  ///
  /// In en, this message translates to:
  /// **'Focus Recommendation'**
  String get focusRecommendation;

  /// No description provided for @focusAreaAccuracy.
  ///
  /// In en, this message translates to:
  /// **'Accuracy on {category} is {percent}%. Practice this area to level up faster!'**
  String focusAreaAccuracy(String category, String percent);

  /// No description provided for @mistakesSavedForReview.
  ///
  /// In en, this message translates to:
  /// **'You have {count} mistakes saved for review.'**
  String mistakesSavedForReview(int count);

  /// No description provided for @reviewMistakes.
  ///
  /// In en, this message translates to:
  /// **'Review Mistakes ({count})'**
  String reviewMistakes(int count);

  /// No description provided for @mistakesDrill.
  ///
  /// In en, this message translates to:
  /// **'Mistakes Drill'**
  String get mistakesDrill;

  /// No description provided for @mistakeReview.
  ///
  /// In en, this message translates to:
  /// **'Mistake Review'**
  String get mistakeReview;

  /// No description provided for @masteryBreakdown.
  ///
  /// In en, this message translates to:
  /// **'Mastery Breakdown'**
  String get masteryBreakdown;

  /// No description provided for @unplayed.
  ///
  /// In en, this message translates to:
  /// **'Unplayed'**
  String get unplayed;

  /// No description provided for @badges.
  ///
  /// In en, this message translates to:
  /// **'Badges'**
  String get badges;

  /// No description provided for @unlocked.
  ///
  /// In en, this message translates to:
  /// **'unlocked'**
  String get unlocked;

  /// No description provided for @specialSession.
  ///
  /// In en, this message translates to:
  /// **'Special Session'**
  String get specialSession;

  /// No description provided for @bossLevel.
  ///
  /// In en, this message translates to:
  /// **'Boss Level {number}'**
  String bossLevel(int number);

  /// No description provided for @questionProgress.
  ///
  /// In en, this message translates to:
  /// **'Question {current} of {total}'**
  String questionProgress(int current, int total);

  /// No description provided for @streakCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Streak'**
  String streakCount(int count);

  /// No description provided for @scratchpad.
  ///
  /// In en, this message translates to:
  /// **'Scratchpad'**
  String get scratchpad;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @explainStep.
  ///
  /// In en, this message translates to:
  /// **'Explain Step'**
  String get explainStep;

  /// No description provided for @stepByStepExplanation.
  ///
  /// In en, this message translates to:
  /// **'Step-by-Step Explanation'**
  String get stepByStepExplanation;

  /// No description provided for @correctAnswerIs.
  ///
  /// In en, this message translates to:
  /// **'The correct answer is {answer}.'**
  String correctAnswerIs(String answer);

  /// No description provided for @correctAnswer.
  ///
  /// In en, this message translates to:
  /// **'Correct Answer:'**
  String get correctAnswer;

  /// No description provided for @nextStep.
  ///
  /// In en, this message translates to:
  /// **'Next Step ({current}/{total})'**
  String nextStep(int current, int total);

  /// No description provided for @gotIt.
  ///
  /// In en, this message translates to:
  /// **'Got It!'**
  String get gotIt;

  /// No description provided for @completeWithTitle.
  ///
  /// In en, this message translates to:
  /// **'{title} Complete!'**
  String completeWithTitle(String title);

  /// No description provided for @practiceComplete.
  ///
  /// In en, this message translates to:
  /// **'Practice Complete!'**
  String get practiceComplete;

  /// No description provided for @perfectScore.
  ///
  /// In en, this message translates to:
  /// **'Perfect Score!'**
  String get perfectScore;

  /// No description provided for @levelComplete.
  ///
  /// In en, this message translates to:
  /// **'Level Complete!'**
  String get levelComplete;

  /// No description provided for @solvedCountSummary.
  ///
  /// In en, this message translates to:
  /// **'You solved {score} of {total} questions correctly.'**
  String solvedCountSummary(int score, int total);

  /// No description provided for @xpEarned.
  ///
  /// In en, this message translates to:
  /// **'+{xp} XP Earned'**
  String xpEarned(int xp);

  /// No description provided for @nextLevel.
  ///
  /// In en, this message translates to:
  /// **'Next Level'**
  String get nextLevel;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @buyMeACoffee.
  ///
  /// In en, this message translates to:
  /// **'Buy Me a Coffee'**
  String get buyMeACoffee;

  /// No description provided for @newBestScore.
  ///
  /// In en, this message translates to:
  /// **'New Best Score!'**
  String get newBestScore;

  /// No description provided for @timesUp.
  ///
  /// In en, this message translates to:
  /// **'Time\'s Up!'**
  String get timesUp;

  /// No description provided for @finalScore.
  ///
  /// In en, this message translates to:
  /// **'Final Score: {score}'**
  String finalScore(int score);

  /// No description provided for @bestScore.
  ///
  /// In en, this message translates to:
  /// **'Best: {score}'**
  String bestScore(int score);

  /// No description provided for @playAgain.
  ///
  /// In en, this message translates to:
  /// **'Play Again'**
  String get playAgain;

  /// No description provided for @exit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit;

  /// No description provided for @newSurvivalRecord.
  ///
  /// In en, this message translates to:
  /// **'New Survival Record!'**
  String get newSurvivalRecord;

  /// No description provided for @gameOver.
  ///
  /// In en, this message translates to:
  /// **'Game Over'**
  String get gameOver;

  /// No description provided for @roundsCleared.
  ///
  /// In en, this message translates to:
  /// **'Rounds Cleared: {rounds}'**
  String roundsCleared(int rounds);

  /// No description provided for @bestRounds.
  ///
  /// In en, this message translates to:
  /// **'Best: {rounds} Rounds'**
  String bestRounds(int rounds);

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @playerWins.
  ///
  /// In en, this message translates to:
  /// **'Player {player} Wins!'**
  String playerWins(int player);

  /// No description provided for @duelScoreSummary.
  ///
  /// In en, this message translates to:
  /// **'Score: P1 ({p1}) vs P2 ({p2})'**
  String duelScoreSummary(int p1, int p2);

  /// No description provided for @puzzleHint.
  ///
  /// In en, this message translates to:
  /// **'Puzzle Hint'**
  String get puzzleHint;

  /// No description provided for @oneSolutionIs.
  ///
  /// In en, this message translates to:
  /// **'One solution is:\n\n{solution}'**
  String oneSolutionIs(String solution);

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @useAll4Numbers.
  ///
  /// In en, this message translates to:
  /// **'Use all 4 numbers!'**
  String get useAll4Numbers;

  /// No description provided for @correctEqualsTarget.
  ///
  /// In en, this message translates to:
  /// **'Correct! Equals {target} 🎉'**
  String correctEqualsTarget(int target);

  /// No description provided for @invalidExpression.
  ///
  /// In en, this message translates to:
  /// **'Invalid expression'**
  String get invalidExpression;

  /// No description provided for @invalidMathSyntax.
  ///
  /// In en, this message translates to:
  /// **'Invalid math syntax'**
  String get invalidMathSyntax;

  /// No description provided for @equalsTarget.
  ///
  /// In en, this message translates to:
  /// **'Equals {val} (Target: {target})'**
  String equalsTarget(String val, int target);

  /// No description provided for @mathNovice.
  ///
  /// In en, this message translates to:
  /// **'Math Novice'**
  String get mathNovice;

  /// No description provided for @apprentice.
  ///
  /// In en, this message translates to:
  /// **'Apprentice'**
  String get apprentice;

  /// No description provided for @mathlete.
  ///
  /// In en, this message translates to:
  /// **'Mathlete'**
  String get mathlete;

  /// No description provided for @arithmeticMaster.
  ///
  /// In en, this message translates to:
  /// **'Arithmetic Master'**
  String get arithmeticMaster;

  /// No description provided for @grandmaster.
  ///
  /// In en, this message translates to:
  /// **'Grandmaster'**
  String get grandmaster;

  /// No description provided for @badgeFirstStepTitle.
  ///
  /// In en, this message translates to:
  /// **'First Step'**
  String get badgeFirstStepTitle;

  /// No description provided for @badgeFirstStepDesc.
  ///
  /// In en, this message translates to:
  /// **'Complete your first math level'**
  String get badgeFirstStepDesc;

  /// No description provided for @badgeStreak5Title.
  ///
  /// In en, this message translates to:
  /// **'Hot Streak'**
  String get badgeStreak5Title;

  /// No description provided for @badgeStreak5Desc.
  ///
  /// In en, this message translates to:
  /// **'Reach a streak of 5 correct answers'**
  String get badgeStreak5Desc;

  /// No description provided for @badgeStreak15Title.
  ///
  /// In en, this message translates to:
  /// **'Unstoppable'**
  String get badgeStreak15Title;

  /// No description provided for @badgeStreak15Desc.
  ///
  /// In en, this message translates to:
  /// **'Reach a streak of 15 correct answers'**
  String get badgeStreak15Desc;

  /// No description provided for @badgeCenturyTitle.
  ///
  /// In en, this message translates to:
  /// **'Century Club'**
  String get badgeCenturyTitle;

  /// No description provided for @badgeCenturyDesc.
  ///
  /// In en, this message translates to:
  /// **'Solve 100 math problems correctly'**
  String get badgeCenturyDesc;

  /// No description provided for @badgeSpeedDemonTitle.
  ///
  /// In en, this message translates to:
  /// **'Speed Demon'**
  String get badgeSpeedDemonTitle;

  /// No description provided for @badgeSpeedDemonDesc.
  ///
  /// In en, this message translates to:
  /// **'Score 15+ in Time Attack mode'**
  String get badgeSpeedDemonDesc;

  /// No description provided for @badgeSurvivorTitle.
  ///
  /// In en, this message translates to:
  /// **'Survivor'**
  String get badgeSurvivorTitle;

  /// No description provided for @badgeSurvivorDesc.
  ///
  /// In en, this message translates to:
  /// **'Survive 15+ rounds in Survival mode'**
  String get badgeSurvivorDesc;

  /// No description provided for @badgeTargetMasterTitle.
  ///
  /// In en, this message translates to:
  /// **'Number Wizard'**
  String get badgeTargetMasterTitle;

  /// No description provided for @badgeTargetMasterDesc.
  ///
  /// In en, this message translates to:
  /// **'Solve 5 Target 24 puzzles'**
  String get badgeTargetMasterDesc;

  /// No description provided for @badgeDailyChampionTitle.
  ///
  /// In en, this message translates to:
  /// **'Dedicated Learner'**
  String get badgeDailyChampionTitle;

  /// No description provided for @badgeDailyChampionDesc.
  ///
  /// In en, this message translates to:
  /// **'Maintain a 3-day daily streak'**
  String get badgeDailyChampionDesc;

  /// No description provided for @badgeBossSlayerTitle.
  ///
  /// In en, this message translates to:
  /// **'Boss Slayer'**
  String get badgeBossSlayerTitle;

  /// No description provided for @badgeBossSlayerDesc.
  ///
  /// In en, this message translates to:
  /// **'Defeat a milestone review boss level'**
  String get badgeBossSlayerDesc;

  /// No description provided for @badgeGrandMasterTitle.
  ///
  /// In en, this message translates to:
  /// **'Grandmaster'**
  String get badgeGrandMasterTitle;

  /// No description provided for @badgeGrandMasterDesc.
  ///
  /// In en, this message translates to:
  /// **'Complete all 60 curriculum levels'**
  String get badgeGrandMasterDesc;

  /// No description provided for @categoryConcepts.
  ///
  /// In en, this message translates to:
  /// **'Concepts'**
  String get categoryConcepts;

  /// No description provided for @categoryAddition.
  ///
  /// In en, this message translates to:
  /// **'Addition'**
  String get categoryAddition;

  /// No description provided for @categorySubtraction.
  ///
  /// In en, this message translates to:
  /// **'Subtraction'**
  String get categorySubtraction;

  /// No description provided for @categoryMultiplication.
  ///
  /// In en, this message translates to:
  /// **'Multiplication'**
  String get categoryMultiplication;

  /// No description provided for @categoryDivision.
  ///
  /// In en, this message translates to:
  /// **'Division'**
  String get categoryDivision;

  /// No description provided for @categoryPowersRoots.
  ///
  /// In en, this message translates to:
  /// **'Powers & Roots'**
  String get categoryPowersRoots;

  /// No description provided for @categoryMaster.
  ///
  /// In en, this message translates to:
  /// **'Master Practice'**
  String get categoryMaster;

  /// No description provided for @categoryFractions.
  ///
  /// In en, this message translates to:
  /// **'Fractions'**
  String get categoryFractions;

  /// No description provided for @categoryPercentages.
  ///
  /// In en, this message translates to:
  /// **'Percentages'**
  String get categoryPercentages;

  /// No description provided for @categoryPowers.
  ///
  /// In en, this message translates to:
  /// **'Powers'**
  String get categoryPowers;

  /// No description provided for @categoryAlgebra.
  ///
  /// In en, this message translates to:
  /// **'Algebra'**
  String get categoryAlgebra;

  /// No description provided for @playerNumber.
  ///
  /// In en, this message translates to:
  /// **'Player {player}'**
  String playerNumber(int player);

  /// No description provided for @makeTargetNumber.
  ///
  /// In en, this message translates to:
  /// **'Make the Target Number'**
  String get makeTargetNumber;

  /// No description provided for @puzzlesSolved.
  ///
  /// In en, this message translates to:
  /// **'{count} Puzzles Solved'**
  String puzzlesSolved(int count);

  /// No description provided for @targetLabel.
  ///
  /// In en, this message translates to:
  /// **'Target: {target}'**
  String targetLabel(int target);

  /// No description provided for @tapNumbersOperators.
  ///
  /// In en, this message translates to:
  /// **'Tap numbers & operators'**
  String get tapNumbersOperators;

  /// No description provided for @nextPuzzle.
  ///
  /// In en, this message translates to:
  /// **'Next Puzzle'**
  String get nextPuzzle;

  /// No description provided for @checkEquation.
  ///
  /// In en, this message translates to:
  /// **'Check Equation'**
  String get checkEquation;

  /// No description provided for @newPuzzle.
  ///
  /// In en, this message translates to:
  /// **'New Puzzle'**
  String get newPuzzle;

  /// No description provided for @hint.
  ///
  /// In en, this message translates to:
  /// **'Hint'**
  String get hint;

  /// No description provided for @playerScore.
  ///
  /// In en, this message translates to:
  /// **'P{player}: {score}/{target}'**
  String playerScore(int player, int score, int target);

  /// No description provided for @rowsCols.
  ///
  /// In en, this message translates to:
  /// **'{rows} rows × {cols} columns'**
  String rowsCols(int rows, int cols);

  /// No description provided for @startAt.
  ///
  /// In en, this message translates to:
  /// **'Start at {value}'**
  String startAt(int value);

  /// No description provided for @endAt.
  ///
  /// In en, this message translates to:
  /// **'End at {value}'**
  String endAt(int value);

  /// No description provided for @jumpStep.
  ///
  /// In en, this message translates to:
  /// **'{step} jump'**
  String jumpStep(int step);

  /// No description provided for @jumpStepPositive.
  ///
  /// In en, this message translates to:
  /// **'+{step} jump'**
  String jumpStepPositive(int step);

  /// No description provided for @tensVisual.
  ///
  /// In en, this message translates to:
  /// **'{count} Tens ({value})'**
  String tensVisual(int count, int value);

  /// No description provided for @onesVisual.
  ///
  /// In en, this message translates to:
  /// **'{count} Ones ({value})'**
  String onesVisual(int count, int value);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
