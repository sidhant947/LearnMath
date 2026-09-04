import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:learnmath/ui/core/services/app_haptics.dart';
import 'package:learnmath/ui/core/widgets/tangible_button.dart';
import 'package:learnmath/ui/features/home/view_models/home_view_model.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  Future<void> _openFeedbackUrl() async {
    final Uri url = Uri.parse('https://github.com/sidhant947/LearnMath');
    try {
      final launched = await launchUrl(url, mode: LaunchMode.externalApplication);
      if (!launched) {
        await launchUrl(url);
      }
    } catch (_) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final progress = ref.watch(homeViewModelProvider).progress;
    final hapticsEnabled = progress?.hapticsEnabled ?? true;
    final showStepExplanation = progress?.showStepExplanation ?? true;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          children: [
            Card(
              color: colorScheme.surfaceContainer,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: SwitchListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                secondary: Icon(
                  Icons.vibration_rounded,
                  size: 22,
                  color: colorScheme.primary,
                ),
                title: Text(
                  'Haptic Feedback',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colorScheme.onSurface,
                  ),
                ),
                subtitle: Text(
                  'Vibrate on button taps and game events',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                value: hapticsEnabled,
                onChanged: (val) {
                  AppHaptics.selection();
                  ref.read(homeViewModelProvider.notifier).toggleHaptics(val);
                },
              ),
            ),
            const SizedBox(height: 12),
            Card(
              color: colorScheme.surfaceContainer,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: SwitchListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                secondary: Icon(
                  Icons.help_outline_rounded,
                  size: 22,
                  color: colorScheme.primary,
                ),
                title: Text(
                  'Step-by-Step Explanation',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colorScheme.onSurface,
                  ),
                ),
                subtitle: Text(
                  'Show explanation help button during questions',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                value: showStepExplanation,
                onChanged: (val) {
                  AppHaptics.selection();
                  ref.read(homeViewModelProvider.notifier).toggleStepExplanation(val);
                },
              ),
            ),
            const SizedBox(height: 20),
            TangibleButton(
              text: 'Report Error or Suggestions',
              isSecondary: true,
              icon: Icons.feedback_rounded,
              onPressed: () => _openFeedbackUrl(),
            ),
            const SizedBox(height: 12),
            TangibleButton(
              text: 'Reset Progress',
              isSecondary: true,
              icon: Icons.restart_alt_rounded,
              onPressed: () => _confirmReset(context, ref),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmReset(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: colorScheme.surfaceContainerHigh,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        title: Text(
          'Reset Progress?',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'This clears all completed levels and returns you to Level 1. This action cannot be undone.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
            height: 1.4,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: colorScheme.error,
              foregroundColor: colorScheme.onError,
              minimumSize: const Size(100, 44),
            ),
            onPressed: () async {
              await ref.read(homeViewModelProvider.notifier).resetProgress();
              if (dialogContext.mounted) Navigator.pop(dialogContext);
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}
