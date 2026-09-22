import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:learnmath/data/services/hive_service.dart';
import 'package:learnmath/l10n/l10n.dart';
import 'package:learnmath/ui/core/services/app_haptics.dart';
import 'package:learnmath/ui/core/theme/app_theme.dart';
import 'package:learnmath/ui/features/home/view_models/home_view_model.dart';
import 'package:learnmath/ui/features/home/views/home_view.dart';
import 'package:learnmath/ui/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final hiveService = HiveService();
  await hiveService.init();

  final initialProgress = await hiveService.getProgress();
  AppHaptics.isEnabled = initialProgress.hapticsEnabled;

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  runApp(
    ProviderScope(
      overrides: [
        hiveServiceProvider.overrideWithValue(hiveService),
      ],
      child: const LearnMathApp(),
    ),
  );
}

class LearnMathApp extends ConsumerWidget {
  const LearnMathApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageCode = ref.watch(
      homeViewModelProvider.select((s) => s.progress?.languageCode ?? 'en'),
    );

    return MaterialApp(
      title: 'Learn Math',
      theme: AppTheme.darkTheme,
      locale: Locale(languageCode),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: const HomeView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
