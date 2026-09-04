import 'package:flutter/services.dart';

class AppHaptics {
  static bool isEnabled = true;

  static void light() {
    if (isEnabled) {
      HapticFeedback.lightImpact();
    }
  }

  static void medium() {
    if (isEnabled) {
      HapticFeedback.mediumImpact();
    }
  }

  static void heavy() {
    if (isEnabled) {
      HapticFeedback.heavyImpact();
    }
  }

  static void selection() {
    if (isEnabled) {
      HapticFeedback.selectionClick();
    }
  }

  static void vibrate() {
    if (isEnabled) {
      HapticFeedback.vibrate();
    }
  }
}
