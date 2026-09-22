import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:learnmath/domain/models/user_progress.dart';
import 'package:learnmath/ui/providers.dart';

class HomeViewModelState {
  const HomeViewModelState({
    this.progress,
    this.isLoading = false,
  });

  final UserProgress? progress;
  final bool isLoading;

  HomeViewModelState copyWith({
    UserProgress? progress,
    bool? isLoading,
  }) {
    return HomeViewModelState(
      progress: progress ?? this.progress,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class HomeViewModel extends Notifier<HomeViewModelState> {
  @override
  HomeViewModelState build() {
    return const HomeViewModelState();
  }

  Future<void> loadProgress() async {
    state = state.copyWith(isLoading: true);
    try {
      final progressRepository = ref.read(progressRepositoryProvider);
      final progress = await progressRepository.getProgress();
      state = state.copyWith(progress: progress, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> completeLevel(int levelNumber) async {
    final progressRepository = ref.read(progressRepositoryProvider);
    await progressRepository.completeLevel(levelNumber);
    final updated = await progressRepository.getProgress();
    state = state.copyWith(progress: updated);
  }

  Future<void> completeDailyChallenge(String dateString) async {
    final progressRepository = ref.read(progressRepositoryProvider);
    await progressRepository.completeDailyChallenge(dateString);
    final updated = await progressRepository.getProgress();
    state = state.copyWith(progress: updated);
  }

  Future<void> toggleHaptics(bool enabled) async {
    final progressRepository = ref.read(progressRepositoryProvider);
    await progressRepository.setHapticsEnabled(enabled);
    final updated = await progressRepository.getProgress();
    state = state.copyWith(progress: updated);
  }

  Future<void> toggleStepExplanation(bool enabled) async {
    final progressRepository = ref.read(progressRepositoryProvider);
    await progressRepository.setShowStepExplanation(enabled);
    final updated = await progressRepository.getProgress();
    state = state.copyWith(progress: updated);
  }

  Future<void> setLanguage(String languageCode) async {
    final progressRepository = ref.read(progressRepositoryProvider);
    await progressRepository.setLanguage(languageCode);
    final updated = await progressRepository.getProgress();
    state = state.copyWith(progress: updated);
  }

  Future<void> resetProgress() async {
    final progressRepository = ref.read(progressRepositoryProvider);
    await progressRepository.resetProgress();
    state = const HomeViewModelState(progress: UserProgress());
  }
}

final homeViewModelProvider =
    NotifierProvider<HomeViewModel, HomeViewModelState>(HomeViewModel.new);
