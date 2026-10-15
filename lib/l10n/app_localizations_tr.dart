// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Matematik Öğren';

  @override
  String get appTagline => 'Hızlı düşün, akıllıca çöz';

  @override
  String get play => 'Oyna';

  @override
  String get dailyChallenge => 'Günün Görevi';

  @override
  String get level => 'Seviye';

  @override
  String get levels => 'Seviyeler';

  @override
  String levelNumber(int number) {
    return 'Seviye $number';
  }

  @override
  String get specialGameModes => 'Özel Oyun Modları';

  @override
  String get practice => 'Alıştırma';

  @override
  String get settings => 'Ayarlar';

  @override
  String get stats => 'İstatistikler';

  @override
  String get score => 'Puan';

  @override
  String get round => 'Tur';

  @override
  String get preferences => 'TERCİHLER';

  @override
  String get language => 'Dil';

  @override
  String get languageSubtitle => 'Uygulama dilini seçin';

  @override
  String get hapticFeedback => 'Titreşimli Geri Bildirim';

  @override
  String get hapticFeedbackSubtitle =>
      'Düğme dokunuşlarında ve oyun olaylarında titreşim';

  @override
  String get stepExplanations => 'Adım Adım Açıklamalar';

  @override
  String get stepExplanationsSubtitle =>
      'Sorular sırasında yardım simgesini göster';

  @override
  String get aboutAndHelp => 'HAKKINDA & YARDIM';

  @override
  String get githubRepo => 'GitHub Deposu';

  @override
  String get githubRepoSubtitle => 'Açık kaynak kodu & sorun bildirin';

  @override
  String get resetProgress => 'İlerlemeyi Sıfırla';

  @override
  String get resetProgressQuestion => 'İlerleme sıfırlansın mı?';

  @override
  String get resetProgressWarning =>
      'Bu işlem tamamlanan tüm seviyeleri siler ve sizi Seviye 1\'e döndürür. Bu işlem geri alınamaz.';

  @override
  String get cancel => 'İptal';

  @override
  String get reset => 'Sıfırla';

  @override
  String get timeAttackTitle => 'Zamana Karşı Yıldırım';

  @override
  String get timeAttackSubtitle =>
      '60 saniyelik hız yarışı, her doğru cevap için +2 sn zaman bonusu';

  @override
  String get survivalTitle => 'Sonsuz Hayatta Kalma';

  @override
  String get survivalSubtitle =>
      '3 Can. Artan zorluk. Ne kadar hayatta kalabilirsin?';

  @override
  String get duelTitle => '2 Oyunculu Bölünmüş Ekran Düellosu';

  @override
  String get duelSubtitle =>
      'Aynı ekranda 10 puana ulaşmak için bir arkadaşınla yarış';

  @override
  String get target24Title => 'Hedef 24 Bulmacası';

  @override
  String get target24Subtitle =>
      '24\'e eşit bir denklem oluşturmak için 4 sayı ve işlemleri kullan';

  @override
  String get practiceSetup => 'Alıştırma Ayarı';

  @override
  String get difficulty => 'ZORLUK';

  @override
  String get easy => 'KOLAY';

  @override
  String get medium => 'ORTA';

  @override
  String get hard => 'ZOR';

  @override
  String get questions => 'SORULAR';

  @override
  String nQuestions(int count) {
    return '$count Soru';
  }

  @override
  String get category => 'KATEGORİ';

  @override
  String get allMixed => 'Hepsi Karışık';

  @override
  String get startPractice => 'Alıştırmaya Başla';

  @override
  String get newPractice => 'Yeni Alıştırma';

  @override
  String get analyticsAndAchievements => 'Analizler & Başarımlar';

  @override
  String totalXpEarned(int xp) {
    return 'Toplam $xp XP Kazanıldı';
  }

  @override
  String get levelProgress => 'Seviye İlerlemesi';

  @override
  String xpOutOf(int current, int total) {
    return '$current / $total XP';
  }

  @override
  String get accuracy => 'Doğruluk';

  @override
  String get accuracySubtitle => 'Genel problem çözme doğruluğu';

  @override
  String get solvedProblems => 'Çözülen Problemler';

  @override
  String get solvedProblemsSubtitle => 'Toplam tamamlanan matematik problemi';

  @override
  String get dailyStreak => 'Günlük Seri';

  @override
  String dailyStreakDays(int days) {
    return '$days Gün';
  }

  @override
  String get dailyStreakSubtitle => 'Üst üste aktif alıştırma günleri';

  @override
  String get focusRecommendation => 'Odaklanma Önerisi';

  @override
  String focusAreaAccuracy(String category, String percent) {
    return '$category kategorisindeki doğruluk %$percent. Daha hızlı seviye atlamak için bu alanda pratik yapın!';
  }

  @override
  String mistakesSavedForReview(int count) {
    return 'Tekrar için kaydedilmiş $count hatanız var.';
  }

  @override
  String reviewMistakes(int count) {
    return 'Hataları Tekrar Et ($count)';
  }

  @override
  String get mistakesDrill => 'Hata Alıştırması';

  @override
  String get mistakeReview => 'Hata Tekrarı';

  @override
  String get masteryBreakdown => 'Ustalık Dağılımı';

  @override
  String get unplayed => 'Oynanmadı';

  @override
  String get badges => 'Rozetler';

  @override
  String get unlocked => 'kilit açıldı';

  @override
  String get specialSession => 'Özel Oturum';

  @override
  String bossLevel(int number) {
    return 'Canavar Seviyesi $number';
  }

  @override
  String questionProgress(int current, int total) {
    return 'Soru $current / $total';
  }

  @override
  String streakCount(int count) {
    return '$count Seri';
  }

  @override
  String get scratchpad => 'Müsvedde';

  @override
  String get undo => 'Geri Al';

  @override
  String get clear => 'Temizle';

  @override
  String get explainStep => 'Adımı Açıkla';

  @override
  String get stepByStepExplanation => 'Adım Adım Açıklama';

  @override
  String correctAnswerIs(String answer) {
    return 'Doğru cevap $answer.';
  }

  @override
  String get correctAnswer => 'Doğru Cevap:';

  @override
  String nextStep(int current, int total) {
    return 'Sonraki Adım ($current/$total)';
  }

  @override
  String get gotIt => 'Anladım!';

  @override
  String completeWithTitle(String title) {
    return '$title Tamamlandı!';
  }

  @override
  String get practiceComplete => 'Alıştırma Tamamlandı!';

  @override
  String get perfectScore => 'Kusursuz Puan!';

  @override
  String get levelComplete => 'Seviye Tamamlandı!';

  @override
  String solvedCountSummary(int score, int total) {
    return '$total sorudan $score tanesini doğru çözdünüz.';
  }

  @override
  String xpEarned(int xp) {
    return '+$xp XP Kazanıldı';
  }

  @override
  String get nextLevel => 'Sonraki Seviye';

  @override
  String get home => 'Ana Sayfa';

  @override
  String get buyMeACoffee => 'Bir Kahve Ismarla';

  @override
  String get newBestScore => 'Yeni En İyi Skor!';

  @override
  String get timesUp => 'Süre Doldu!';

  @override
  String finalScore(int score) {
    return 'Son Skor: $score';
  }

  @override
  String bestScore(int score) {
    return 'En İyi: $score';
  }

  @override
  String get playAgain => 'Tekrar Oyna';

  @override
  String get exit => 'Çıkış';

  @override
  String get newSurvivalRecord => 'Yeni Hayatta Kalma Rekoru!';

  @override
  String get gameOver => 'Oyun Bitti';

  @override
  String roundsCleared(int rounds) {
    return 'Geçilen Tur: $rounds';
  }

  @override
  String bestRounds(int rounds) {
    return 'En İyi: $rounds Tur';
  }

  @override
  String get tryAgain => 'Tekrar Dene';

  @override
  String playerWins(int player) {
    return 'Oyuncu $player Kazandı!';
  }

  @override
  String duelScoreSummary(int p1, int p2) {
    return 'Skor: O1 ($p1) - O2 ($p2)';
  }

  @override
  String get puzzleHint => 'Bulmaca İpucu';

  @override
  String oneSolutionIs(String solution) {
    return 'Çözümlerden biri:\n\n$solution';
  }

  @override
  String get ok => 'Tamam';

  @override
  String get useAll4Numbers => '4 sayının hepsini kullanın!';

  @override
  String correctEqualsTarget(int target) {
    return 'Doğru! $target elde edildi 🎉';
  }

  @override
  String get invalidExpression => 'Geçersiz ifade';

  @override
  String get invalidMathSyntax => 'Geçersiz matematik sözdizimi';

  @override
  String equalsTarget(String val, int target) {
    return '$val eder (Hedef: $target)';
  }

  @override
  String get mathNovice => 'Matematik Çaylağı';

  @override
  String get apprentice => 'Çırak';

  @override
  String get mathlete => 'Matematik Sporcusu';

  @override
  String get arithmeticMaster => 'Aritmetik Ustası';

  @override
  String get grandmaster => 'Büyük Usta';

  @override
  String get badgeFirstStepTitle => 'İlk Adım';

  @override
  String get badgeFirstStepDesc => 'İlk matematik seviyenizi tamamlayın';

  @override
  String get badgeStreak5Title => 'Ateşli Seri';

  @override
  String get badgeStreak5Desc => 'Üst üste 5 doğru cevap serisine ulaşın';

  @override
  String get badgeStreak15Title => 'Durdurulamaz';

  @override
  String get badgeStreak15Desc => 'Üst üste 15 doğru cevap serisine ulaşın';

  @override
  String get badgeCenturyTitle => '100\'ler Kulübü';

  @override
  String get badgeCenturyDesc => '100 matematik problemini doğru çözün';

  @override
  String get badgeSpeedDemonTitle => 'Hız Canavarı';

  @override
  String get badgeSpeedDemonDesc => 'Zamana Karşı modunda 15+ puan alın';

  @override
  String get badgeSurvivorTitle => 'Hayatta Kalan';

  @override
  String get badgeSurvivorDesc => 'Hayatta Kalma modunda 15+ tur dayanın';

  @override
  String get badgeTargetMasterTitle => 'Sayı Büyücüsü';

  @override
  String get badgeTargetMasterDesc => '5 Hedef 24 bulmacası çözün';

  @override
  String get badgeDailyChampionTitle => 'Azimli Öğrenci';

  @override
  String get badgeDailyChampionDesc => '3 günlük seri yakalayın';

  @override
  String get badgeBossSlayerTitle => 'Canavar Avcısı';

  @override
  String get badgeBossSlayerDesc =>
      'Bir kilometre taşı canavar seviyesini yenin';

  @override
  String get badgeGrandMasterTitle => 'Büyük Usta';

  @override
  String get badgeGrandMasterDesc => 'Tüm 60 müfredat seviyesini tamamlayın';

  @override
  String get categoryConcepts => 'Kavramlar';

  @override
  String get categoryAddition => 'Toplama';

  @override
  String get categorySubtraction => 'Çıkarma';

  @override
  String get categoryMultiplication => 'Çarpma';

  @override
  String get categoryDivision => 'Bölme';

  @override
  String get categoryPowersRoots => 'Kuvvetler & Kökler';

  @override
  String get categoryMaster => 'Usta Alıştırması';

  @override
  String get categoryFractions => 'Kesirler';

  @override
  String get categoryPercentages => 'Yüzdeler';

  @override
  String get categoryPowers => 'Kuvvetler';

  @override
  String get categoryAlgebra => 'Cebir';

  @override
  String playerNumber(int player) {
    return 'Oyuncu $player';
  }

  @override
  String get makeTargetNumber => 'Hedef Sayıyı Oluştur';

  @override
  String puzzlesSolved(int count) {
    return '$count Bulmaca Çözüldü';
  }

  @override
  String targetLabel(int target) {
    return 'Hedef: $target';
  }

  @override
  String get tapNumbersOperators => 'Sayı ve işlemlere dokunun';

  @override
  String get nextPuzzle => 'Sonraki Bulmaca';

  @override
  String get checkEquation => 'Denklemi Kontrol Et';

  @override
  String get newPuzzle => 'Yeni Bulmaca';

  @override
  String get hint => 'İpucu';

  @override
  String playerScore(int player, int score, int target) {
    return 'O$player: $score/$target';
  }

  @override
  String rowsCols(int rows, int cols) {
    return '$rows satır × $cols sütun';
  }

  @override
  String startAt(int value) {
    return '$value değerinden başla';
  }

  @override
  String endAt(int value) {
    return '$value değerinde bitir';
  }

  @override
  String jumpStep(int step) {
    return '$step atlama';
  }

  @override
  String jumpStepPositive(int step) {
    return '+$step atlama';
  }

  @override
  String tensVisual(int count, int value) {
    return '$count Onluk ($value)';
  }

  @override
  String onesVisual(int count, int value) {
    return '$count Birlik ($value)';
  }
}
