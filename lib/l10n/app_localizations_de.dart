// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Mathe Lernen';

  @override
  String get appTagline => 'Schnell denken, schlau lösen';

  @override
  String get play => 'Spielen';

  @override
  String get dailyChallenge => 'Tägliche Herausforderung';

  @override
  String get level => 'Level';

  @override
  String get levels => 'Level';

  @override
  String levelNumber(int number) {
    return 'Level $number';
  }

  @override
  String get specialGameModes => 'Spezielle Spielmodi';

  @override
  String get practice => 'Üben';

  @override
  String get settings => 'Einstellungen';

  @override
  String get stats => 'Statistik';

  @override
  String get score => 'Punkte';

  @override
  String get round => 'Runde';

  @override
  String get preferences => 'EINSTELLUNGEN';

  @override
  String get language => 'Sprache';

  @override
  String get languageSubtitle => 'App-Sprache auswählen';

  @override
  String get hapticFeedback => 'Haptisches Feedback';

  @override
  String get hapticFeedbackSubtitle =>
      'Vibration bei Tastendruck und Spielereignissen';

  @override
  String get stepExplanations => 'Schritt-Erklärungen';

  @override
  String get stepExplanationsSubtitle => 'Hilfesymbol bei Fragen anzeigen';

  @override
  String get aboutAndHelp => 'ÜBER & HILFE';

  @override
  String get githubRepo => 'GitHub-Repository';

  @override
  String get githubRepoSubtitle => 'Quellcode & Probleme melden';

  @override
  String get resetProgress => 'Fortschritt zurücksetzen';

  @override
  String get resetProgressQuestion => 'Fortschritt zurücksetzen?';

  @override
  String get resetProgressWarning =>
      'Dies löscht alle abgeschlossenen Level und setzt dich auf Level 1 zurück. Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get reset => 'Zurücksetzen';

  @override
  String get timeAttackTitle => 'Blitz-Zeitangriff';

  @override
  String get timeAttackSubtitle =>
      '60 Sekunden mit +2s Zeitbonus pro richtiger Antwort';

  @override
  String get survivalTitle => 'Endlos-Überleben';

  @override
  String get survivalSubtitle =>
      '3 Herzen. Steigender Schwierigkeitsgrad. Wie lange überlebst du?';

  @override
  String get duelTitle => '2-Spieler Duell';

  @override
  String get duelSubtitle =>
      'Tritt gegen einen Freund auf demselben Bildschirm bis 10 Punkte an';

  @override
  String get target24Title => 'Ziel 24 Rätsel';

  @override
  String get target24Subtitle =>
      'Nutze 4 Zahlen und Rechenzeichen, um 24 zu bilden';

  @override
  String get practiceSetup => 'Übung konfigurieren';

  @override
  String get difficulty => 'SCHWIERIGKEIT';

  @override
  String get easy => 'LEICHT';

  @override
  String get medium => 'MITTEL';

  @override
  String get hard => 'SCHWER';

  @override
  String get questions => 'FRAGEN';

  @override
  String nQuestions(int count) {
    return '$count Fragen';
  }

  @override
  String get category => 'KATEGORIE';

  @override
  String get allMixed => 'Alle gemischt';

  @override
  String get startPractice => 'Übung starten';

  @override
  String get newPractice => 'Neue Übung';

  @override
  String get analyticsAndAchievements => 'Analysen & Erfolge';

  @override
  String totalXpEarned(int xp) {
    return '$xp Gesamt-XP verdient';
  }

  @override
  String get levelProgress => 'Level-Fortschritt';

  @override
  String xpOutOf(int current, int total) {
    return '$current / $total XP';
  }

  @override
  String get accuracy => 'Genauigkeit';

  @override
  String get accuracySubtitle => 'Gesamte Lösungsgenauigkeit';

  @override
  String get solvedProblems => 'Gelöste Aufgaben';

  @override
  String get solvedProblemsSubtitle => 'Insgesamt gelöste Matheaufgaben';

  @override
  String get dailyStreak => 'Tägliche Serie';

  @override
  String dailyStreakDays(int days) {
    return '$days Tage';
  }

  @override
  String get dailyStreakSubtitle => 'Aufeinanderfolgende aktive Übungstage';

  @override
  String get focusRecommendation => 'Fokus-Empfehlung';

  @override
  String focusAreaAccuracy(String category, String percent) {
    return 'Genauigkeit bei $category liegt bei $percent%. Übe diesen Bereich, um schneller aufzusteigen!';
  }

  @override
  String mistakesSavedForReview(int count) {
    return 'Du hast $count Fehler zur Wiederholung gespeichert.';
  }

  @override
  String reviewMistakes(int count) {
    return 'Fehler wiederholen ($count)';
  }

  @override
  String get mistakesDrill => 'Fehler-Training';

  @override
  String get mistakeReview => 'Fehler-Wiederholung';

  @override
  String get masteryBreakdown => 'Meisterschafts-Übersicht';

  @override
  String get unplayed => 'Ungespielt';

  @override
  String get badges => 'Abzeichen';

  @override
  String get unlocked => 'freigeschaltet';

  @override
  String get specialSession => 'Spezielle Sitzung';

  @override
  String bossLevel(int number) {
    return 'Boss-Level $number';
  }

  @override
  String questionProgress(int current, int total) {
    return 'Frage $current von $total';
  }

  @override
  String streakCount(int count) {
    return '${count}er Serie';
  }

  @override
  String get scratchpad => 'Notizblock';

  @override
  String get undo => 'Rückgängig';

  @override
  String get clear => 'Löschen';

  @override
  String get explainStep => 'Schritt erklären';

  @override
  String get stepByStepExplanation => 'Schritt-für-Schritt-Erklärung';

  @override
  String correctAnswerIs(String answer) {
    return 'Die richtige Antwort ist $answer.';
  }

  @override
  String get correctAnswer => 'Richtige Antwort:';

  @override
  String nextStep(int current, int total) {
    return 'Nächster Schritt ($current/$total)';
  }

  @override
  String get gotIt => 'Verstanden!';

  @override
  String completeWithTitle(String title) {
    return '$title abgeschlossen!';
  }

  @override
  String get practiceComplete => 'Übung abgeschlossen!';

  @override
  String get perfectScore => 'Perfekte Punktzahl!';

  @override
  String get levelComplete => 'Level abgeschlossen!';

  @override
  String solvedCountSummary(int score, int total) {
    return 'Du hast $score von $total Fragen richtig gelöst.';
  }

  @override
  String xpEarned(int xp) {
    return '+$xp XP verdient';
  }

  @override
  String get nextLevel => 'Nächstes Level';

  @override
  String get home => 'Startseite';

  @override
  String get buyMeACoffee => 'Kaffee spendieren';

  @override
  String get newBestScore => 'Neuer Rekord!';

  @override
  String get timesUp => 'Zeit abgelaufen!';

  @override
  String finalScore(int score) {
    return 'Endstand: $score';
  }

  @override
  String bestScore(int score) {
    return 'Bester: $score';
  }

  @override
  String get playAgain => 'Nochmal spielen';

  @override
  String get exit => 'Beenden';

  @override
  String get newSurvivalRecord => 'Neuer Überlebensrekord!';

  @override
  String get gameOver => 'Spiel vorbei';

  @override
  String roundsCleared(int rounds) {
    return 'Runden überstanden: $rounds';
  }

  @override
  String bestRounds(int rounds) {
    return 'Beste: $rounds Runden';
  }

  @override
  String get tryAgain => 'Erneut versuchen';

  @override
  String playerWins(int player) {
    return 'Spieler $player gewinnt!';
  }

  @override
  String duelScoreSummary(int p1, int p2) {
    return 'Punkte: P1 ($p1) vs P2 ($p2)';
  }

  @override
  String get puzzleHint => 'Rätsel-Hinweis';

  @override
  String oneSolutionIs(String solution) {
    return 'Eine Lösung ist:\n\n$solution';
  }

  @override
  String get ok => 'OK';

  @override
  String get useAll4Numbers => 'Nutze alle 4 Zahlen!';

  @override
  String correctEqualsTarget(int target) {
    return 'Richtig! Ergibt $target 🎉';
  }

  @override
  String get invalidExpression => 'Ungültiger Ausdruck';

  @override
  String get invalidMathSyntax => 'Ungültige mathematische Syntax';

  @override
  String equalsTarget(String val, int target) {
    return 'Ergibt $val (Ziel: $target)';
  }

  @override
  String get mathNovice => 'Mathe-Neuling';

  @override
  String get apprentice => 'Lehrling';

  @override
  String get mathlete => 'Mathe-Athlet';

  @override
  String get arithmeticMaster => 'Arithmetik-Meister';

  @override
  String get grandmaster => 'Großmeister';

  @override
  String get badgeFirstStepTitle => 'Erster Schritt';

  @override
  String get badgeFirstStepDesc => 'Schließe dein erstes Mathe-Level ab';

  @override
  String get badgeStreak5Title => 'Heiße Serie';

  @override
  String get badgeStreak5Desc =>
      'Erreiche eine Serie von 5 richtigen Antworten';

  @override
  String get badgeStreak15Title => 'Unaufhaltsam';

  @override
  String get badgeStreak15Desc =>
      'Erreiche eine Serie von 15 richtigen Antworten';

  @override
  String get badgeCenturyTitle => 'Hunderter-Club';

  @override
  String get badgeCenturyDesc => 'Löse 100 Matheaufgaben richtig';

  @override
  String get badgeSpeedDemonTitle => 'Geschwindigkeitsteufel';

  @override
  String get badgeSpeedDemonDesc => 'Erreiche 15+ Punkte im Zeitangriff-Modus';

  @override
  String get badgeSurvivorTitle => 'Überlebenskünstler';

  @override
  String get badgeSurvivorDesc => 'Überlebe 15+ Runden im Überlebensmodus';

  @override
  String get badgeTargetMasterTitle => 'Zahlenzauberer';

  @override
  String get badgeTargetMasterDesc => 'Löse 5 Ziel-24-Rätsel';

  @override
  String get badgeDailyChampionTitle => 'Fleißiger Lerner';

  @override
  String get badgeDailyChampionDesc =>
      'Halte eine 3-Tage-Tagesherausforderung-Serie';

  @override
  String get badgeBossSlayerTitle => 'Boss-Bezwinger';

  @override
  String get badgeBossSlayerDesc => 'Besiege ein Meilenstein-Bosslevel';

  @override
  String get badgeGrandMasterTitle => 'Großmeister';

  @override
  String get badgeGrandMasterDesc => 'Schließe alle 60 Lehrplan-Level ab';

  @override
  String get categoryConcepts => 'Konzepte';

  @override
  String get categoryAddition => 'Addition';

  @override
  String get categorySubtraction => 'Subtraktion';

  @override
  String get categoryMultiplication => 'Multiplikation';

  @override
  String get categoryDivision => 'Division';

  @override
  String get categoryPowersRoots => 'Potenzen & Wurzeln';

  @override
  String get categoryMaster => 'Meister-Übung';

  @override
  String get categoryFractions => 'Brüche';

  @override
  String get categoryPercentages => 'Prozente';

  @override
  String get categoryPowers => 'Potenzen';

  @override
  String get categoryAlgebra => 'Algebra';

  @override
  String playerNumber(int player) {
    return 'Spieler $player';
  }

  @override
  String get makeTargetNumber => 'Bilde die Zielzahl';

  @override
  String puzzlesSolved(int count) {
    return '$count Rätsel gelöst';
  }

  @override
  String targetLabel(int target) {
    return 'Ziel: $target';
  }

  @override
  String get tapNumbersOperators => 'Zahlen & Operatoren antippen';

  @override
  String get nextPuzzle => 'Nächstes Rätsel';

  @override
  String get checkEquation => 'Gleichung prüfen';

  @override
  String get newPuzzle => 'Neues Rätsel';

  @override
  String get hint => 'Hinweis';

  @override
  String playerScore(int player, int score, int target) {
    return 'S$player: $score/$target';
  }

  @override
  String rowsCols(int rows, int cols) {
    return '$rows Zeilen × $cols Spalten';
  }

  @override
  String startAt(int value) {
    return 'Start bei $value';
  }

  @override
  String endAt(int value) {
    return 'Ende bei $value';
  }

  @override
  String jumpStep(int step) {
    return '$step Sprung';
  }

  @override
  String jumpStepPositive(int step) {
    return '+$step Sprung';
  }

  @override
  String tensVisual(int count, int value) {
    return '$count Zehner ($value)';
  }

  @override
  String onesVisual(int count, int value) {
    return '$count Einer ($value)';
  }
}
