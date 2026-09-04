import 'package:hive_flutter/hive_flutter.dart';
import 'package:learnmath/domain/models/user_progress.dart';
import 'user_progress_adapter.dart';

class HiveService {
  static const String _progressBoxName = 'learnmath_progress';
  static const String _progressKey = 'progress';

  late Box<UserProgress> _progressBox;

  Future<void> init() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserProgressAdapter());
    }
    try {
      _progressBox = await Hive.openBox<UserProgress>(_progressBoxName);
    } catch (_) {
      try {
        await Hive.deleteBoxFromDisk(_progressBoxName);
        _progressBox = await Hive.openBox<UserProgress>(_progressBoxName);
      } catch (_) {
        _progressBox = await Hive.openBox<UserProgress>(_progressBoxName);
      }
    }
  }

  Future<UserProgress> getProgress() async {
    try {
      return _progressBox.get(_progressKey) ?? const UserProgress();
    } catch (_) {
      return const UserProgress();
    }
  }

  Future<void> saveProgress(UserProgress progress) async {
    try {
      await _progressBox.put(_progressKey, progress);
    } catch (_) {}
  }

  Future<void> clearProgress() async {
    try {
      await _progressBox.delete(_progressKey);
    } catch (_) {}
  }
}
