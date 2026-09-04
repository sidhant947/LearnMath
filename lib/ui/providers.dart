import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnmath/data/repositories/progress_repository.dart';
import 'package:learnmath/data/services/hive_service.dart';

final hiveServiceProvider = Provider<HiveService>((ref) {
  throw UnimplementedError('Must be overridden in main');
});

final progressRepositoryProvider = Provider<ProgressRepository>((ref) {
  final hiveService = ref.watch(hiveServiceProvider);
  return ProgressRepository(hiveService: hiveService);
});
