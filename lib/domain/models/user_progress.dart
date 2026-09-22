import 'dart:math' as math;
import 'package:flutter/material.dart';

@immutable
class UserProgress {
  const UserProgress({
    this.currentLevel = 1,
    this.highestLevelCompleted = 0,
    this.totalXp = 0,
    this.unlockedBadges = const [],
    this.dailyStreak = 0,
    this.lastDailyDate = '',
    this.timeAttackHighScore = 0,
    this.survivalHighScore = 0,
    this.target24HighScore = 0,
    this.totalSolved = 0,
    this.totalCorrect = 0,
    this.categorySolvedCount = const {},
    this.categoryCorrectCount = const {},
    this.savedMistakes = const [],
    this.hapticsEnabled = true,
    this.showStepExplanation = true,
    this.languageCode = 'en',
  });

  final int currentLevel;
  final int highestLevelCompleted;
  final int totalXp;
  final List<String> unlockedBadges;
  final int dailyStreak;
  final String lastDailyDate;
  final int timeAttackHighScore;
  final int survivalHighScore;
  final int target24HighScore;
  final int totalSolved;
  final int totalCorrect;
  final Map<String, int> categorySolvedCount;
  final Map<String, int> categoryCorrectCount;
  final List<String> savedMistakes;
  final bool hapticsEnabled;
  final bool showStepExplanation;
  final String languageCode;

  int get playerLevel => (totalXp / 100).floor() + 1;
  int get currentLevelXp => totalXp % 100;
  double get playerLevelProgress => (totalXp % 100) / 100.0;

  double get overallAccuracy {
    if (totalSolved == 0) return 1.0;
    return (totalCorrect / totalSolved).clamp(0.0, 1.0);
  }

  UserProgress copyWith({
    int? currentLevel,
    int? highestLevelCompleted,
    int? totalXp,
    List<String>? unlockedBadges,
    int? dailyStreak,
    String? lastDailyDate,
    int? timeAttackHighScore,
    int? survivalHighScore,
    int? target24HighScore,
    int? totalSolved,
    int? totalCorrect,
    Map<String, int>? categorySolvedCount,
    Map<String, int>? categoryCorrectCount,
    List<String>? savedMistakes,
    bool? hapticsEnabled,
    bool? showStepExplanation,
    String? languageCode,
  }) {
    return UserProgress(
      currentLevel: currentLevel ?? this.currentLevel,
      highestLevelCompleted:
          highestLevelCompleted ?? this.highestLevelCompleted,
      totalXp: totalXp ?? this.totalXp,
      unlockedBadges: unlockedBadges ?? this.unlockedBadges,
      dailyStreak: dailyStreak ?? this.dailyStreak,
      lastDailyDate: lastDailyDate ?? this.lastDailyDate,
      timeAttackHighScore:
          timeAttackHighScore ?? this.timeAttackHighScore,
      survivalHighScore: survivalHighScore ?? this.survivalHighScore,
      target24HighScore: target24HighScore ?? this.target24HighScore,
      totalSolved: totalSolved ?? this.totalSolved,
      totalCorrect: totalCorrect ?? this.totalCorrect,
      categorySolvedCount:
          categorySolvedCount ?? this.categorySolvedCount,
      categoryCorrectCount:
          categoryCorrectCount ?? this.categoryCorrectCount,
      savedMistakes: savedMistakes ?? this.savedMistakes,
      hapticsEnabled: hapticsEnabled ?? this.hapticsEnabled,
      showStepExplanation: showStepExplanation ?? this.showStepExplanation,
      languageCode: languageCode ?? this.languageCode,
    );
  }

  UserProgress incrementLevel() {
    return copyWith(
      currentLevel: currentLevel + 1,
      highestLevelCompleted: math.max(highestLevelCompleted, currentLevel),
      totalXp: totalXp + 25,
    );
  }
}
