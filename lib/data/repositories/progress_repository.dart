import 'dart:math' as math;
import 'package:learnmath/domain/models/user_progress.dart';
import 'package:learnmath/ui/core/services/app_haptics.dart';
import '../services/hive_service.dart';

class ProgressRepository {
  ProgressRepository({required this._hiveService});

  final HiveService _hiveService;
  UserProgress? _cachedProgress;

  Future<UserProgress> getProgress() async {
    if (_cachedProgress != null) {
      AppHaptics.isEnabled = _cachedProgress!.hapticsEnabled;
      return _cachedProgress!;
    }
    _cachedProgress = await _hiveService.getProgress();
    AppHaptics.isEnabled = _cachedProgress!.hapticsEnabled;
    return _cachedProgress!;
  }

  Future<void> saveProgress(UserProgress progress) async {
    _cachedProgress = progress;
    AppHaptics.isEnabled = progress.hapticsEnabled;
    await _hiveService.saveProgress(progress);
  }

  Future<void> setHapticsEnabled(bool enabled) async {
    final current = await getProgress();
    AppHaptics.isEnabled = enabled;
    await saveProgress(current.copyWith(hapticsEnabled: enabled));
  }

  Future<void> setShowStepExplanation(bool enabled) async {
    final current = await getProgress();
    await saveProgress(current.copyWith(showStepExplanation: enabled));
  }

  Future<void> completeLevel(int levelNumber, {int xpEarned = 25}) async {
    final current = await getProgress();
    final newHighest = math.max(current.highestLevelCompleted, levelNumber);
    final newCurrent =
        levelNumber >= current.currentLevel ? levelNumber + 1 : current.currentLevel;
    
    final updatedBadges = List<String>.from(current.unlockedBadges);
    if (!updatedBadges.contains('first_step')) {
      updatedBadges.add('first_step');
    }
    if (levelNumber >= 60 && !updatedBadges.contains('grand_master')) {
      updatedBadges.add('grand_master');
    }
    if ([4, 14, 24, 34, 44, 54, 59, 60].contains(levelNumber) && !updatedBadges.contains('boss_slayer')) {
      updatedBadges.add('boss_slayer');
    }

    final updated = current.copyWith(
      highestLevelCompleted: newHighest,
      currentLevel: newCurrent,
      totalXp: current.totalXp + xpEarned,
      unlockedBadges: updatedBadges,
    );
    await saveProgress(updated);
  }

  Future<void> recordAnswer({
    required String categoryKey,
    required bool isCorrect,
    int streak = 0,
    String? mistakeData,
  }) async {
    final current = await getProgress();
    
    final solvedMap = Map<String, int>.from(current.categorySolvedCount);
    solvedMap[categoryKey] = (solvedMap[categoryKey] ?? 0) + 1;

    final correctMap = Map<String, int>.from(current.categoryCorrectCount);
    if (isCorrect) {
      correctMap[categoryKey] = (correctMap[categoryKey] ?? 0) + 1;
    }

    final mistakes = List<String>.from(current.savedMistakes);
    if (isCorrect) {
      if (mistakeData != null) {
        _removeMatchingMistake(mistakes, mistakeData);
      }
    } else if (mistakeData != null) {
      _removeMatchingMistake(mistakes, mistakeData);
      mistakes.add(mistakeData);
      if (mistakes.length > 50) {
        mistakes.removeAt(0);
      }
    }

    final updatedBadges = List<String>.from(current.unlockedBadges);
    if (streak >= 5 && !updatedBadges.contains('streak_5')) {
      updatedBadges.add('streak_5');
    }
    if (streak >= 15 && !updatedBadges.contains('streak_15')) {
      updatedBadges.add('streak_15');
    }
    final totalCorrect = current.totalCorrect + (isCorrect ? 1 : 0);
    if (totalCorrect >= 100 && !updatedBadges.contains('century')) {
      updatedBadges.add('century');
    }

    final xpGain = isCorrect ? (5 + (streak > 3 ? 3 : 0)) : 0;

    final updated = current.copyWith(
      totalSolved: current.totalSolved + 1,
      totalCorrect: totalCorrect,
      totalXp: current.totalXp + xpGain,
      categorySolvedCount: solvedMap,
      categoryCorrectCount: correctMap,
      savedMistakes: mistakes,
      unlockedBadges: updatedBadges,
    );

    await saveProgress(updated);
  }

  Future<void> addXp(int amount) async {
    final current = await getProgress();
    await saveProgress(current.copyWith(totalXp: current.totalXp + amount));
  }

  Future<void> recordTimeAttackScore(int score) async {
    final current = await getProgress();
    final updatedBadges = List<String>.from(current.unlockedBadges);
    if (score >= 15 && !updatedBadges.contains('speed_demon')) {
      updatedBadges.add('speed_demon');
    }
    final updated = current.copyWith(
      timeAttackHighScore: math.max(current.timeAttackHighScore, score),
      totalXp: current.totalXp + (score * 3),
      unlockedBadges: updatedBadges,
    );
    await saveProgress(updated);
  }

  Future<void> recordSurvivalScore(int rounds) async {
    final current = await getProgress();
    final updatedBadges = List<String>.from(current.unlockedBadges);
    if (rounds >= 15 && !updatedBadges.contains('survivor')) {
      updatedBadges.add('survivor');
    }
    final updated = current.copyWith(
      survivalHighScore: math.max(current.survivalHighScore, rounds),
      totalXp: current.totalXp + (rounds * 4),
      unlockedBadges: updatedBadges,
    );
    await saveProgress(updated);
  }

  Future<void> recordTarget24Solved() async {
    final current = await getProgress();
    final newCount = current.target24HighScore + 1;
    final updatedBadges = List<String>.from(current.unlockedBadges);
    if (newCount >= 5 && !updatedBadges.contains('target_master')) {
      updatedBadges.add('target_master');
    }
    final updated = current.copyWith(
      target24HighScore: newCount,
      totalXp: current.totalXp + 20,
      unlockedBadges: updatedBadges,
    );
    await saveProgress(updated);
  }

  Future<void> completeDailyChallenge(String dateString) async {
    final current = await getProgress();
    if (current.lastDailyDate == dateString) return;

    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    final yesterdayString = '${yesterday.year}-${yesterday.month.toString().padLeft(2, '0')}-${yesterday.day.toString().padLeft(2, '0')}';
    
    int newStreak = (current.lastDailyDate == yesterdayString) ? (current.dailyStreak + 1) : 1;

    final updatedBadges = List<String>.from(current.unlockedBadges);
    if (newStreak >= 3 && !updatedBadges.contains('daily_champion')) {
      updatedBadges.add('daily_champion');
    }

    final updated = current.copyWith(
      dailyStreak: newStreak,
      lastDailyDate: dateString,
      totalXp: current.totalXp + 50 + (newStreak * 10),
      unlockedBadges: updatedBadges,
    );
    await saveProgress(updated);
  }

  Future<void> removeMistake(String mistakeData) async {
    final current = await getProgress();
    final mistakes = List<String>.from(current.savedMistakes);
    _removeMatchingMistake(mistakes, mistakeData);
    await saveProgress(current.copyWith(savedMistakes: mistakes));
  }

  void _removeMatchingMistake(List<String> mistakes, String mistakeData) {
    if (mistakes.remove(mistakeData)) return;

    final target = _parseMistakeString(mistakeData);
    if (target == null) return;

    mistakes.removeWhere((m) {
      final parsed = _parseMistakeString(m);
      if (parsed == null) return false;
      return parsed.$1 == target.$1 && parsed.$2 == target.$2;
    });
  }

  (String, String)? _parseMistakeString(String m) {
    if (m.trim().isEmpty) return null;
    final parts = m.split(' = ').map((s) => s.trim()).toList();
    if (parts.length < 2) return null;
    final answer = parts.last;
    if (answer == '?' || answer.isEmpty) return null;

    String rawPrompt;
    if (parts.length > 2 && parts[parts.length - 2] == '?') {
      rawPrompt = parts.sublist(0, parts.length - 2).join(' = ');
    } else {
      rawPrompt = parts.sublist(0, parts.length - 1).join(' = ');
    }

    final cleanedPrompt = rawPrompt
        .replaceAll(RegExp(r'(\s*=\s*\?|\s*=\s*|\s*\?)+$'), '')
        .trim();

    return (cleanedPrompt, answer);
  }

  Future<void> clearAllMistakes() async {
    final current = await getProgress();
    await saveProgress(current.copyWith(savedMistakes: []));
  }

  Future<void> resetProgress() async {
    _cachedProgress = null;
    await _hiveService.clearProgress();
  }
}
