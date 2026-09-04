import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:learnmath/data/services/hive_service.dart';
import 'package:learnmath/ui/core/services/app_haptics.dart';
import 'package:learnmath/ui/core/theme/app_theme.dart';
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

class LearnMathApp extends StatelessWidget {
  const LearnMathApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learn Math',
      theme: AppTheme.darkTheme,
      home: const HomeView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
