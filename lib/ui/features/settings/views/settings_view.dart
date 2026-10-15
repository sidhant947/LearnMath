import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:learnmath/l10n/l10n.dart';
import 'package:learnmath/ui/core/services/app_haptics.dart';
import 'package:learnmath/ui/core/widgets/tangible_button.dart';
import 'package:learnmath/ui/core/widgets/tangible_card.dart';
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
    final languageCode = progress?.languageCode ?? 'en';
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
              children: [
                _buildSectionHeader(context, l10n.preferences),
                const SizedBox(height: 10),
                TangibleCard(
                  color: colorScheme.surfaceContainer,
                  borderColor: colorScheme.outline,
                  borderRadius: 20,
                  depth: 3.5,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: colorScheme.primary.withValues(alpha: 0.3), width: 1.2),
                        ),
                        child: Icon(
                          Icons.translate_rounded,
                          size: 22,
                          color: colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.language,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              l10n.languageSubtitle,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: colorScheme.outline, width: 1.2),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: languageCode,
                            icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 20),
                            borderRadius: BorderRadius.circular(16),
                            dropdownColor: colorScheme.surfaceContainerHigh,
                            isDense: true,
                            items: const [
                              DropdownMenuItem(
                                value: 'en',
                                child: Text(
                                  'English',
                                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'de',
                                child: Text(
                                  'Deutsch',
                                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                                ),
                              ),
                              DropdownMenuItem(
                                value: 'tr',
                                child: Text(
                                  'Türkçe',
                                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                                ),
                              ),
                            ],
                            onChanged: (val) {
                              if (val != null && val != languageCode) {
                                AppHaptics.selection();
                                ref.read(homeViewModelProvider.notifier).setLanguage(val);
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                TangibleCard(
                  color: colorScheme.surfaceContainer,
                  borderColor: colorScheme.outline,
                  borderRadius: 20,
                  depth: 3.5,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: colorScheme.primary.withValues(alpha: 0.3), width: 1.2),
                        ),
                        child: Icon(
                          Icons.vibration_rounded,
                          size: 22,
                          color: colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.hapticFeedback,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              l10n.hapticFeedbackSubtitle,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Switch.adaptive(
                        value: hapticsEnabled,
                        activeTrackColor: colorScheme.primary,
                        onChanged: (val) {
                          AppHaptics.selection();
                          ref.read(homeViewModelProvider.notifier).toggleHaptics(val);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                TangibleCard(
                  color: colorScheme.surfaceContainer,
                  borderColor: colorScheme.outline,
                  borderRadius: 20,
                  depth: 3.5,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: colorScheme.primary.withValues(alpha: 0.3), width: 1.2),
                        ),
                        child: Icon(
                          Icons.help_outline_rounded,
                          size: 22,
                          color: colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.stepExplanations,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              l10n.stepExplanationsSubtitle,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Switch.adaptive(
                        value: showStepExplanation,
                        activeTrackColor: colorScheme.primary,
                        onChanged: (val) {
                          AppHaptics.selection();
                          ref.read(homeViewModelProvider.notifier).toggleStepExplanation(val);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _buildSectionHeader(context, l10n.aboutAndHelp),
                const SizedBox(height: 10),
                TangibleCard(
                  color: colorScheme.surfaceContainer,
                  borderColor: colorScheme.outline,
                  borderRadius: 20,
                  depth: 3.5,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  onTap: () {
                    AppHaptics.light();
                    _openFeedbackUrl();
                  },
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF06B6D4).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFF06B6D4).withValues(alpha: 0.3), width: 1.2),
                        ),
                        child: const Icon(
                          Icons.code_rounded,
                          size: 22,
                          color: Color(0xFF06B6D4),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.githubRepo,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              l10n.githubRepoSubtitle,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.open_in_new_rounded, size: 18, color: colorScheme.onSurfaceVariant),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                TangibleButton(
                  text: l10n.resetProgress,
                  isSecondary: true,
                  height: 54,
                  icon: Icons.restart_alt_rounded,
                  onPressed: () => _confirmReset(context, ref),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 2),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w800,
          color: colorScheme.onSurfaceVariant,
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  void _confirmReset(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = context.l10n;

    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        backgroundColor: colorScheme.surfaceContainerHigh,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: colorScheme.outline, width: 1.5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colorScheme.error.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.warning_amber_rounded,
                      color: colorScheme.error,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    l10n.resetProgressQuestion,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                l10n.resetProgressWarning,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TangibleButton(
                      text: l10n.cancel,
                      isSecondary: true,
                      height: 46,
                      onPressed: () => Navigator.pop(dialogContext),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TangibleButton(
                      text: l10n.reset,
                      height: 46,
                      color: colorScheme.error,
                      shadowColor: const Color(0xFF991B1B),
                      onPressed: () async {
                        await ref.read(homeViewModelProvider.notifier).resetProgress();
                        if (dialogContext.mounted) Navigator.pop(dialogContext);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
