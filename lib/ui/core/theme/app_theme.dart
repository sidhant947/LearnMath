import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF10B981),
      brightness: Brightness.dark,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: 'Outfit',
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        scrolledUnderElevation: 0,
        centerTitle: true,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: colorScheme.onSurface,
          height: 1.25,
        ),
        iconTheme: IconThemeData(color: colorScheme.onSurface),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: colorScheme.outlineVariant.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
        color: colorScheme.surfaceContainer,
        margin: EdgeInsets.zero,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(64, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
            height: 1.2,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(64, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          side: BorderSide(
            color: colorScheme.outlineVariant,
            width: 1.2,
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
            height: 1.2,
          ),
        ),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Outfit',
          fontSize: 48,
          fontWeight: FontWeight.w800,
          color: colorScheme.onSurface,
          height: 1.15,
        ),
        displayMedium: TextStyle(
          fontFamily: 'Outfit',
          fontSize: 36,
          fontWeight: FontWeight.w800,
          color: colorScheme.onSurface,
          height: 1.2,
        ),
        headlineLarge: TextStyle(
          fontFamily: 'Outfit',
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: colorScheme.onSurface,
          height: 1.25,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Outfit',
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: colorScheme.onSurface,
          height: 1.3,
        ),
        headlineSmall: TextStyle(
          fontFamily: 'Outfit',
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: colorScheme.onSurface,
          height: 1.3,
        ),
        titleLarge: TextStyle(
          fontFamily: 'Outfit',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: colorScheme.onSurface,
          height: 1.35,
        ),
        titleMedium: TextStyle(
          fontFamily: 'PlusJakartaSans',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
          height: 1.4,
        ),
        titleSmall: TextStyle(
          fontFamily: 'PlusJakartaSans',
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurface,
          height: 1.4,
        ),
        bodyLarge: TextStyle(
          fontFamily: 'PlusJakartaSans',
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSurface,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'PlusJakartaSans',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSurfaceVariant,
          height: 1.5,
        ),
        bodySmall: TextStyle(
          fontFamily: 'PlusJakartaSans',
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: colorScheme.onSurfaceVariant,
          height: 1.4,
        ),
        labelLarge: TextStyle(
          fontFamily: 'Outfit',
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: colorScheme.onSurface,
          letterSpacing: 0.1,
          height: 1.2,
        ),
        labelMedium: TextStyle(
          fontFamily: 'PlusJakartaSans',
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurfaceVariant,
          letterSpacing: 0.1,
          height: 1.2,
        ),
        labelSmall: TextStyle(
          fontFamily: 'PlusJakartaSans',
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: colorScheme.onSurfaceVariant,
          letterSpacing: 0.1,
          height: 1.2,
        ),
      ),
    );
  }
}
