// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'Ucz się Matematyki';

  @override
  String get appTagline => 'Myśl szybko, rozwiązuj mądrze';

  @override
  String get play => 'Graj';

  @override
  String get dailyChallenge => 'Wyzwanie dnia';

  @override
  String get level => 'Poziom';

  @override
  String get levels => 'Poziomy';

  @override
  String levelNumber(int number) {
    return 'Poziom $number';
  }

  @override
  String get specialGameModes => 'Tryby specjalne';

  @override
  String get practice => 'Ćwiczenia';

  @override
  String get settings => 'Ustawienia';

  @override
  String get stats => 'Statystyki';

  @override
  String get score => 'Wynik';

  @override
  String get round => 'Runda';

  @override
  String get preferences => 'PREFERENCJE';

  @override
  String get language => 'Język';

  @override
  String get languageSubtitle => 'Wybierz język aplikacji';

  @override
  String get hapticFeedback => 'Wibracje';

  @override
  String get hapticFeedbackSubtitle =>
      'Wibracje przy dotknięciach i zdarzeniach w grze';

  @override
  String get stepExplanations => 'Wyjaśnienia krok po kroku';

  @override
  String get stepExplanationsSubtitle => 'Pokaż ikonę pomocy podczas pytań';

  @override
  String get aboutAndHelp => 'O APLIKACJI / POMOC';

  @override
  String get githubRepo => 'Repozytorium GitHub';

  @override
  String get githubRepoSubtitle => 'Kod źródłowy i zgłaszanie problemów';

  @override
  String get resetProgress => 'Zresetuj postępy';

  @override
  String get resetProgressQuestion => 'Zresetować postępy?';

  @override
  String get resetProgressWarning =>
      'Spowoduje to usunięcie wszystkich ukończonych poziomów i powrót do poziomu 1. Tej operacji nie można cofnąć.';

  @override
  String get cancel => 'Anuluj';

  @override
  String get reset => 'Resetuj';

  @override
  String get timeAttackTitle => 'Atak na czas';

  @override
  String get timeAttackSubtitle =>
      '60 sekund szybkiej gry z bonusem +2s za poprawną odpowiedź';

  @override
  String get survivalTitle => 'Nieskończone przetrwanie';

  @override
  String get survivalSubtitle =>
      '3 serca. Rosnąca trudność. Jak długo przetrwasz?';

  @override
  String get duelTitle => 'Pojedynek 2 graczy na podzielonym ekranie';

  @override
  String get duelSubtitle =>
      'Ścigaj się z kolegą na tym samym ekranie do 10 punktów';

  @override
  String get target24Title => 'Cel 24';

  @override
  String get target24Subtitle =>
      'Użyj 4 liczb i działań, aby ułożyć równanie równe 24';

  @override
  String get practiceSetup => 'Konfiguracja ćwiczenia';

  @override
  String get difficulty => 'POZIOM TRUDNOŚCI';

  @override
  String get easy => 'ŁATWY';

  @override
  String get medium => 'ŚREDNI';

  @override
  String get hard => 'TRUDNY';

  @override
  String get questions => 'PYTANIA';

  @override
  String nQuestions(int count) {
    return 'Liczba pytań: $count';
  }

  @override
  String get category => 'KATEGORIA';

  @override
  String get allMixed => 'Wszystkiego po trochu';

  @override
  String get startPractice => 'Rozpocznij ćwiczenie';

  @override
  String get newPractice => 'Nowe ćwiczenie';

  @override
  String get analyticsAndAchievements => 'Analizy i osiągnięcia';

  @override
  String totalXpEarned(int xp) {
    return 'Łącznie zdobyte XP: $xp';
  }

  @override
  String get levelProgress => 'Postęp poziomu';

  @override
  String xpOutOf(int current, int total) {
    return '$current / $total XP';
  }

  @override
  String get accuracy => 'Dokładność';

  @override
  String get accuracySubtitle => 'Ogólna dokładność rozwiązywania zadań';

  @override
  String get solvedProblems => 'Rozwiązane zadania';

  @override
  String get solvedProblemsSubtitle => 'Łączna liczba ukończonych zadań';

  @override
  String get dailyStreak => 'Seria dni';

  @override
  String dailyStreakDays(int days) {
    return '$days dni';
  }

  @override
  String get dailyStreakSubtitle => 'Kolejne dni aktywnej nauki';

  @override
  String get focusRecommendation => 'Zalecenie skupienia';

  @override
  String focusAreaAccuracy(String category, String percent) {
    return 'Dokładność w kategorii $category wynosi $percent%. Ćwicz ten obszar, aby szybciej awansować!';
  }

  @override
  String mistakesSavedForReview(int count) {
    return 'Zapisane błędy do powtórki: $count.';
  }

  @override
  String reviewMistakes(int count) {
    return 'Powtórz błędy ($count)';
  }

  @override
  String get mistakesDrill => 'Powtórka błędów';

  @override
  String get mistakeReview => 'Przegląd błędów';

  @override
  String get masteryBreakdown => 'Poziom opanowania';

  @override
  String get unplayed => 'Niegrane';

  @override
  String get badges => 'Odznaki';

  @override
  String get unlocked => 'odblokowano';

  @override
  String get specialSession => 'Sesja specjalna';

  @override
  String bossLevel(int number) {
    return 'Poziom bossa $number';
  }

  @override
  String questionProgress(int current, int total) {
    return 'Pytanie $current z $total';
  }

  @override
  String streakCount(int count) {
    return 'Seria $count';
  }

  @override
  String get scratchpad => 'Brudnopis';

  @override
  String get undo => 'Cofnij';

  @override
  String get clear => 'Wyczyść';

  @override
  String get explainStep => 'Wyjaśnij krok';

  @override
  String get stepByStepExplanation => 'Wyjaśnienie krok po kroku';

  @override
  String correctAnswerIs(String answer) {
    return 'Poprawna odpowiedź to $answer.';
  }

  @override
  String get correctAnswer => 'Poprawna odpowiedź:';

  @override
  String nextStep(int current, int total) {
    return 'Następny krok ($current/$total)';
  }

  @override
  String get gotIt => 'Rozumiem!';

  @override
  String completeWithTitle(String title) {
    return '$title ukończone!';
  }

  @override
  String get practiceComplete => 'Ćwiczenie ukończone!';

  @override
  String get perfectScore => 'Perfekcyjny wynik!';

  @override
  String get levelComplete => 'Poziom ukończony!';

  @override
  String solvedCountSummary(int score, int total) {
    return 'Rozwiązałeś poprawnie $score z $total pytań.';
  }

  @override
  String xpEarned(int xp) {
    return '+$xp zdobytych XP';
  }

  @override
  String get nextLevel => 'Następny poziom';

  @override
  String get home => 'Strona główna';

  @override
  String get buyMeACoffee => 'Postaw mi kawę';

  @override
  String get newBestScore => 'Nowy najlepszy wynik!';

  @override
  String get timesUp => 'Czas minął!';

  @override
  String finalScore(int score) {
    return 'Wynik końcowy: $score';
  }

  @override
  String bestScore(int score) {
    return 'Najlepszy: $score';
  }

  @override
  String get playAgain => 'Zagraj ponownie';

  @override
  String get exit => 'Wyjdź';

  @override
  String get newSurvivalRecord => 'Nowy rekord przetrwania!';

  @override
  String get gameOver => 'Koniec gry';

  @override
  String roundsCleared(int rounds) {
    return 'Ukończone rundy: $rounds';
  }

  @override
  String bestRounds(int rounds) {
    return 'Najlepszy wynik: $rounds';
  }

  @override
  String get tryAgain => 'Spróbuj ponownie';

  @override
  String playerWins(int player) {
    return 'Gracz $player wygrywa!';
  }

  @override
  String duelScoreSummary(int p1, int p2) {
    return 'Wynik: P1 ($p1) vs P2 ($p2)';
  }

  @override
  String get puzzleHint => 'Podpowiedź';

  @override
  String oneSolutionIs(String solution) {
    return 'Jedno z rozwiązań to:\n\n$solution';
  }

  @override
  String get ok => 'OK';

  @override
  String get useAll4Numbers => 'Użyj wszystkich 4 liczb!';

  @override
  String correctEqualsTarget(int target) {
    return 'Poprawnie! Wynik $target 🎉';
  }

  @override
  String get invalidExpression => 'Nieprawidłowe wyrażenie';

  @override
  String get invalidMathSyntax => 'Nieprawidłowa składnia matematyczna';

  @override
  String equalsTarget(String val, int target) {
    return 'Wynik $val (Cel: $target)';
  }

  @override
  String get mathNovice => 'Nowicjusz matematyczny';

  @override
  String get apprentice => 'Uczeń';

  @override
  String get mathlete => 'Matematyk';

  @override
  String get arithmeticMaster => 'Mistrz arytmetyki';

  @override
  String get grandmaster => 'Arcymistrz';

  @override
  String get badgeFirstStepTitle => 'Pierwszy krok';

  @override
  String get badgeFirstStepDesc => 'Ukończ pierwszy poziom matematyki';

  @override
  String get badgeStreak5Title => 'Gorąca seria';

  @override
  String get badgeStreak5Desc => 'Osiągnij serię 5 poprawnych odpowiedzi';

  @override
  String get badgeStreak15Title => 'Nie do zatrzymania';

  @override
  String get badgeStreak15Desc => 'Osiągnij serię 15 poprawnych odpowiedzi';

  @override
  String get badgeCenturyTitle => 'Klub setki';

  @override
  String get badgeCenturyDesc => 'Rozwiąż poprawnie 100 zadań';

  @override
  String get badgeSpeedDemonTitle => 'Demon szybkości';

  @override
  String get badgeSpeedDemonDesc => 'Zdobądź 15+ punktów w trybie Atak na czas';

  @override
  String get badgeSurvivorTitle => 'Ocalały';

  @override
  String get badgeSurvivorDesc => 'Przetrwaj 15+ rund w trybie Przetrwania';

  @override
  String get badgeTargetMasterTitle => 'Czarodziej liczb';

  @override
  String get badgeTargetMasterDesc => 'Rozwiąż 5 łamigłówek Cel 24';

  @override
  String get badgeDailyChampionTitle => 'Wytrwały uczeń';

  @override
  String get badgeDailyChampionDesc => 'Utrzymaj 3-dniową serię';

  @override
  String get badgeBossSlayerTitle => 'Pogromca bossów';

  @override
  String get badgeBossSlayerDesc => 'Pokonaj bossa z kamienia milowego';

  @override
  String get badgeGrandMasterTitle => 'Arcymistrz';

  @override
  String get badgeGrandMasterDesc => 'Ukończ wszystkie 60 poziomów programu';

  @override
  String get categoryConcepts => 'Pojęcia';

  @override
  String get categoryAddition => 'Dodawanie';

  @override
  String get categorySubtraction => 'Odejmowanie';

  @override
  String get categoryMultiplication => 'Mnożenie';

  @override
  String get categoryDivision => 'Dzielenie';

  @override
  String get categoryPowersRoots => 'Potęgi i pierwiastki';

  @override
  String get categoryMaster => 'Trening mistrzowski';

  @override
  String get categoryFractions => 'Ułamki';

  @override
  String get categoryPercentages => 'Procenty';

  @override
  String get categoryPowers => 'Potęgi';

  @override
  String get categoryAlgebra => 'Algebra';

  @override
  String playerNumber(int player) {
    return 'Gracz $player';
  }

  @override
  String get makeTargetNumber => 'Utwórz liczbę docelową';

  @override
  String puzzlesSolved(int count) {
    return 'Rozwiązane łamigłówki: $count';
  }

  @override
  String targetLabel(int target) {
    return 'Cel: $target';
  }

  @override
  String get tapNumbersOperators => 'Dotknij liczb i operatorów';

  @override
  String get nextPuzzle => 'Następna łamigłówka';

  @override
  String get checkEquation => 'Sprawdź równanie';

  @override
  String get newPuzzle => 'Nowa łamigłówka';

  @override
  String get hint => 'Podpowiedź';

  @override
  String playerScore(int player, int score, int target) {
    return 'P$player: $score/$target';
  }

  @override
  String rowsCols(int rows, int cols) {
    return '$rows wierszy × $cols kolumn';
  }

  @override
  String startAt(int value) {
    return 'Zacznij od $value';
  }

  @override
  String endAt(int value) {
    return 'Zakończ na $value';
  }

  @override
  String jumpStep(int step) {
    return 'skok o $step';
  }

  @override
  String jumpStepPositive(int step) {
    return '+$step skok';
  }

  @override
  String tensVisual(int count, int value) {
    return '$count dziesiątek ($value)';
  }

  @override
  String onesVisual(int count, int value) {
    return '$count jedności ($value)';
  }
}
