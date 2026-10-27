import 'package:hive/hive.dart';
import 'package:learnmath/domain/models/user_progress.dart';

class UserProgressAdapter extends TypeAdapter<UserProgress> {
  @override
  final int typeId = 0;

  @override
  UserProgress read(BinaryReader reader) {
    try {
      final numOfFields = reader.readByte();
      final fields = <int, dynamic>{};
      for (int i = 0; i < numOfFields; i++) {
        fields[reader.readByte()] = reader.read();
      }

      final rawCategorySolved = fields[11];
      final Map<String, int> categorySolved = {};
      if (rawCategorySolved is Map) {
        rawCategorySolved.forEach((key, value) {
          if (key != null && value != null) {
            final intVal = (value is num) ? value.toInt() : int.tryParse(value.toString());
            if (intVal != null) {
              categorySolved[key.toString()] = intVal;
            }
          }
        });
      }

      final rawCategoryCorrect = fields[12];
      final Map<String, int> categoryCorrect = {};
      if (rawCategoryCorrect is Map) {
        rawCategoryCorrect.forEach((key, value) {
          if (key != null && value != null) {
            final intVal = (value is num) ? value.toInt() : int.tryParse(value.toString());
            if (intVal != null) {
              categoryCorrect[key.toString()] = intVal;
            }
          }
        });
      }

      final rawBadges = fields[3];
      final List<String> unlockedBadges = [];
      if (rawBadges is List) {
        for (final item in rawBadges) {
          if (item != null) {
            unlockedBadges.add(item.toString());
          }
        }
      }

      final rawMistakes = fields[13];
      final List<String> savedMistakes = [];
      if (rawMistakes is List) {
        for (final item in rawMistakes) {
          if (item != null) {
            savedMistakes.add(item.toString());
          }
        }
      }

      return UserProgress(
        currentLevel: (fields[0] as num?)?.toInt() ?? 1,
        highestLevelCompleted: (fields[1] as num?)?.toInt() ?? 0,
        totalXp: (fields[2] as num?)?.toInt() ?? 0,
        unlockedBadges: unlockedBadges,
        dailyStreak: (fields[4] as num?)?.toInt() ?? 0,
        lastDailyDate: fields[5]?.toString() ?? '',
        timeAttackHighScore: (fields[6] as num?)?.toInt() ?? 0,
        survivalHighScore: (fields[7] as num?)?.toInt() ?? 0,
        target24HighScore: (fields[8] as num?)?.toInt() ?? 0,
        totalSolved: (fields[9] as num?)?.toInt() ?? 0,
        totalCorrect: (fields[10] as num?)?.toInt() ?? 0,
        categorySolvedCount: categorySolved,
        categoryCorrectCount: categoryCorrect,
        savedMistakes: savedMistakes,
        hapticsEnabled: fields[14] is bool ? (fields[14] as bool) : true,
        showStepExplanation: fields[15] is bool ? (fields[15] as bool) : false,
        languageCode: fields[16]?.toString() ?? 'en',
      );
    } catch (_) {
      return const UserProgress();
    }
  }

  @override
  void write(BinaryWriter writer, UserProgress obj) {
    writer.writeByte(17);

    writer.writeByte(0);
    writer.write(obj.currentLevel);

    writer.writeByte(1);
    writer.write(obj.highestLevelCompleted);

    writer.writeByte(2);
    writer.write(obj.totalXp);

    writer.writeByte(3);
    writer.write(obj.unlockedBadges);

    writer.writeByte(4);
    writer.write(obj.dailyStreak);

    writer.writeByte(5);
    writer.write(obj.lastDailyDate);

    writer.writeByte(6);
    writer.write(obj.timeAttackHighScore);

    writer.writeByte(7);
    writer.write(obj.survivalHighScore);

    writer.writeByte(8);
    writer.write(obj.target24HighScore);

    writer.writeByte(9);
    writer.write(obj.totalSolved);

    writer.writeByte(10);
    writer.write(obj.totalCorrect);

    writer.writeByte(11);
    writer.write(obj.categorySolvedCount);

    writer.writeByte(12);
    writer.write(obj.categoryCorrectCount);

    writer.writeByte(13);
    writer.write(obj.savedMistakes);

    writer.writeByte(14);
    writer.write(obj.hapticsEnabled);

    writer.writeByte(15);
    writer.write(obj.showStepExplanation);

    writer.writeByte(16);
    writer.write(obj.languageCode);
  }
}
