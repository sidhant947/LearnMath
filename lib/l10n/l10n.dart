export 'package:learnmath/l10n/app_localizations.dart';

import 'package:flutter/widgets.dart';
import 'package:learnmath/l10n/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

extension AppLocalizationsHelpers on AppLocalizations {
  String playerTitle(int level) {
    if (level < 5) return mathNovice;
    if (level < 15) return apprentice;
    if (level < 30) return mathlete;
    if (level < 50) return arithmeticMaster;
    return grandmaster;
  }

  String badgeTitle(String id) {
    switch (id) {
      case 'first_step':
        return badgeFirstStepTitle;
      case 'streak_5':
        return badgeStreak5Title;
      case 'streak_15':
        return badgeStreak15Title;
      case 'century':
        return badgeCenturyTitle;
      case 'speed_demon':
        return badgeSpeedDemonTitle;
      case 'survivor':
        return badgeSurvivorTitle;
      case 'target_master':
        return badgeTargetMasterTitle;
      case 'daily_champion':
        return badgeDailyChampionTitle;
      case 'boss_slayer':
        return badgeBossSlayerTitle;
      case 'grand_master':
        return badgeGrandMasterTitle;
      default:
        return id;
    }
  }

  String badgeDescription(String id) {
    switch (id) {
      case 'first_step':
        return badgeFirstStepDesc;
      case 'streak_5':
        return badgeStreak5Desc;
      case 'streak_15':
        return badgeStreak15Desc;
      case 'century':
        return badgeCenturyDesc;
      case 'speed_demon':
        return badgeSpeedDemonDesc;
      case 'survivor':
        return badgeSurvivorDesc;
      case 'target_master':
        return badgeTargetMasterDesc;
      case 'daily_champion':
        return badgeDailyChampionDesc;
      case 'boss_slayer':
        return badgeBossSlayerDesc;
      case 'grand_master':
        return badgeGrandMasterDesc;
      default:
        return '';
    }
  }

  String categoryName(String key) {
    switch (key.toLowerCase()) {
      case 'concepts':
        return categoryConcepts;
      case 'addition':
        return categoryAddition;
      case 'subtraction':
        return categorySubtraction;
      case 'multiplication':
        return categoryMultiplication;
      case 'division':
        return categoryDivision;
      case 'powers_roots':
      case 'powersroots':
      case 'powers & roots':
        return categoryPowersRoots;
      case 'master':
        return categoryMaster;
      case 'fractions':
        return categoryFractions;
      case 'percentages':
        return categoryPercentages;
      case 'powers':
        return categoryPowers;
      case 'algebra':
        return categoryAlgebra;
      default:
        return key;
    }
  }

  String levelTitle(int level) {
    if (level > 60) {
      if (localeName.startsWith('de')) {
        return 'Meister-Übung ${level - 60}';
      }
      if (localeName.startsWith('tr')) {
        return 'Usta Alıştırması ${level - 60}';
      }
      if (localeName.startsWith('pl')) {
        return 'Trening mistrzowski ${level - 60}';
      }
      return 'Master Practice ${level - 60}';
    }
    if (localeName.startsWith('de')) {
      switch (level) {
        case 1: return 'Was ist 0 & Zählen (1 bis 5)';
        case 2: return 'Zählen (6 bis 10) & Vergleichen';
        case 3: return 'Stellenwert & Gerade / Ungerade';
        case 4: return '👑 Zahlenverständnis-Meilenstein';
        case 5: return '1-stellige Addition (Summen bis 5)';
        case 6: return '1-stellige Addition (Summen bis 10)';
        case 7: return 'Addition (Zehnerübergang)';
        case 8: return '2-stellig + 1-stellig (Einfach)';
        case 9: return '2-stellig + 1-stellig (Mit Übertrag)';
        case 10: return '2-stellig + 2-stellig (Einfach)';
        case 11: return '2-stellig + 2-stellig (Mit Übertrag)';
        case 12: return '3-stellige Addition';
        case 13: return '4-stellige Addition';
        case 14: return '👑 Additions-Meister-Boss';
        case 15: return '1-stellige Subtraktion (Bis 5)';
        case 16: return '1-stellige Subtraktion (Bis 10)';
        case 17: return 'Subtraktion über 10';
        case 18: return '2-stellig - 1-stellig (Einfach)';
        case 19: return '2-stellig - 1-stellig (Mit Entleihen)';
        case 20: return '2-stellig - 2-stellig (Einfach)';
        case 21: return '2-stellig - 2-stellig (Mit Entleihen)';
        case 22: return '3-stellige Subtraktion';
        case 23: return '4-stellige Subtraktion';
        case 24: return '👑 Subtraktions-Meister-Boss';
        case 25: return 'Multiplikation als Gruppen';
        case 26: return 'Einmaleins mit 2 & 3';
        case 27: return 'Einmaleins mit 4 & 5';
        case 28: return 'Einmaleins mit 6 & 7';
        case 29: return 'Einmaleins mit 8 & 9';
        case 30: return 'Einmaleins mit 10, 11 & 12';
        case 31: return '2-stellig × 1-stellig (Einfach)';
        case 32: return '2-stellig × 1-stellig (Fortgeschritten)';
        case 33: return '2-stellig × 2-stellig';
        case 34: return '👑 Multiplikations-Meister-Boss';
        case 35: return 'Division als gerechtes Teilen';
        case 36: return 'Division durch 2, 3 & 4';
        case 37: return 'Division durch 5 & 10';
        case 38: return 'Division durch 6, 7, 8 & 9';
        case 39: return 'Division durch 11 & 12';
        case 40: return '2-stellig ÷ 1-stellig (Einfach)';
        case 41: return '2-stellig ÷ 1-stellig (Fortgeschritten)';
        case 42: return '3-stellig ÷ 1-stellig';
        case 43: return '3-stellig ÷ 2-stellig';
        case 44: return '👑 Divisions-Meister-Boss';
        case 45: return 'Quadratzahlen Grundlagen (1² bis 6²)';
        case 46: return 'Quadratzahlen Fortgeschritten (7² bis 12²)';
        case 47: return '2-stellige Quadratzahlen (13² bis 25²)';
        case 48: return 'Square Roots (√4 bis √49)';
        case 49: return 'Square Roots (√64 bis √400)';
        case 50: return 'Kubikzahlen Grundlagen (1³ bis 5³)';
        case 51: return 'Kubikzahlen Fortgeschritten (6³ bis 10³)';
        case 52: return '4. Potenzen Grundlagen (1⁴ bis 3⁴)';
        case 53: return '4. Potenzen Fortgeschritten (4⁴, 5⁴, 10⁴)';
        case 54: return '👑 Potenzen & Wurzeln Boss';
        case 55: return 'Schnelligkeitstest: Plus & Minus';
        case 56: return 'Schnelligkeitstest: Mal & Geteilt';
        case 57: return 'Schnelligkeitstest: Potenzen & Wurzeln';
        case 58: return 'Allrounder-Herausforderung';
        case 59: return '👑 Großes Halbfinal-Bosslevel';
        case 60: return '👑 Das Ultimative Abschluss-Bosslevel';
        default: return 'Meister-Übung';
      }
    }
    if (localeName.startsWith('tr')) {
      switch (level) {
        case 1: return '0 Nedir & Sayma (1\'den 5\'e)';
        case 2: return 'Sayma (6\'dan 10\'a) & Karşılaştırma';
        case 3: return 'Basamak Değeri & Çift / Tek';
        case 4: return '👑 Sayı Hissi Kilometre Taşı';
        case 5: return '1 Basamaklı Toplama (5\'e Kadar)';
        case 6: return '1 Basamaklı Toplama (10\'a Kadar)';
        case 7: return 'Toplama (10\'u Aşma)';
        case 8: return '2 Basamaklı + 1 Basamaklı (Basit)';
        case 9: return '2 Basamaklı + 1 Basamaklı (Eldeli)';
        case 10: return '2 Basamaklı + 2 Basamaklı (Basit)';
        case 11: return '2 Basamaklı + 2 Basamaklı (Eldeli)';
        case 12: return '3 Basamaklı Toplama';
        case 13: return '4 Basamaklı Toplama';
        case 14: return '👑 Toplama Ustası Canavarı';
        case 15: return '1 Basamaklı Çıkarma (5 İçinde)';
        case 16: return '1 Basamaklı Çıkarma (10 İçinde)';
        case 17: return '10 Üzerinden Çıkarma';
        case 18: return '2 Basamaklı - 1 Basamaklı (Basit)';
        case 19: return '2 Basamaklı - 1 Basamaklı (Onluk Bozarak)';
        case 20: return '2 Basamaklı - 2 Basamaklı (Basit)';
        case 21: return '2 Basamaklı - 2 Basamaklı (Onluk Bozarak)';
        case 22: return '3 Basamaklı Çıkarma';
        case 23: return '4 Basamaklı Çıkarma';
        case 24: return '👑 Çıkarma Ustası Canavarı';
        case 25: return 'Gruplar Halinde Çarpma';
        case 26: return 'Çarpım Tablosu: 2 & 3';
        case 27: return 'Çarpım Tablosu: 4 & 5';
        case 28: return 'Çarpım Tablosu: 6 & 7';
        case 29: return 'Çarpım Tablosu: 8 & 9';
        case 30: return 'Çarpım Tablosu: 10, 11 & 12';
        case 31: return '2 Basamaklı × 1 Basamaklı (Basit)';
        case 32: return '2 Basamaklı × 1 Basamaklı (İleri)';
        case 33: return '2 Basamaklı × 2 Basamaklı';
        case 34: return '👑 Çarpma Ustası Canavarı';
        case 35: return 'Eşit Paylaşım Olarak Bölme';
        case 36: return '2, 3 & 4 ile Bölme';
        case 37: return '5 & 10 ile Bölme';
        case 38: return '6, 7, 8 & 9 ile Bölme';
        case 39: return '11 & 12 ile Bölme';
        case 40: return '2 Basamaklı ÷ 1 Basamaklı (Basit)';
        case 41: return '2 Basamaklı ÷ 1 Basamaklı (İleri)';
        case 42: return '3 Basamaklı ÷ 1 Basamaklı';
        case 43: return '3 Basamaklı ÷ 2 Basamaklı';
        case 44: return '👑 Bölme Ustası Canavarı';
        case 45: return 'Kareler Temel (1²\'den 6²\'ye)';
        case 46: return 'Kareler İleri (7²\'den 12²\'ye)';
        case 47: return '2 Basamaklı Kareler (13²\'den 25²\'ye)';
        case 48: return 'Karekökler (√4\'ten √49\'a)';
        case 49: return 'Karekökler (√64\'ten √400\'e)';
        case 50: return 'Küpler Temel (1³\'ten 5³\'e)';
        case 51: return 'Küpler İleri (6³\'ten 10³\'e)';
        case 52: return '4. Kuvvet Temel (1⁴\'ten 3⁴\'e)';
        case 53: return '4. Kuvvet İleri (4⁴, 5⁴, 10⁴)';
        case 54: return '👑 Kuvvetler & Kökler Canavarı';
        case 55: return 'Hız Testi: Toplama & Çıkarma';
        case 56: return 'Hız Testi: Çarpma & Bölme';
        case 57: return 'Hız Testi: Kuvvetler & Kökler';
        case 58: return 'Çok Yönlü Mücadele';
        case 59: return '👑 Büyük Yarı Final Canavarı';
        case 60: return '👑 Nihai Mezuniyet Canavarı';
        default: return 'Usta Alıştırması';
      }
    }
    if (localeName.startsWith('pl')) {
      switch (level) {
        case 1: return 'Co to jest 0 i liczenie (1 do 5)';
        case 2: return 'Liczenie (6 do 10) i porównywanie';
        case 3: return 'Wartość miejsca i parzyste / nieparzyste';
        case 4: return '👑 Kamień milowy zmysłu liczbowego';
        case 5: return 'Dodawanie 1-cyfrowe (sumy do 5)';
        case 6: return 'Dodawanie 1-cyfrowe (sumy do 10)';
        case 7: return 'Dodawanie (przekroczenie 10)';
        case 8: return '2-cyfrowe + 1-cyfrowe (proste)';
        case 9: return '2-cyfrowe + 1-cyfrowe (z przeniesieniem)';
        case 10: return '2-cyfrowe + 2-cyfrowe (proste)';
        case 11: return '2-cyfrowe + 2-cyfrowe (z przeniesieniem)';
        case 12: return 'Dodawanie 3-cyfrowe';
        case 13: return 'Dodawanie 4-cyfrowe';
        case 14: return '👑 Boss mistrz dodawania';
        case 15: return 'Odejmowanie 1-cyfrowe (do 5)';
        case 16: return 'Odejmowanie 1-cyfrowe (do 10)';
        case 17: return 'Odejmowanie przez 10';
        case 18: return '2-cyfrowe - 1-cyfrowe (proste)';
        case 19: return '2-cyfrowe - 1-cyfrowe (z pożyczaniem)';
        case 20: return '2-cyfrowe - 2-cyfrowe (proste)';
        case 21: return '2-cyfrowe - 2-cyfrowe (z pożyczaniem)';
        case 22: return 'Odejmowanie 3-cyfrowe';
        case 23: return 'Odejmowanie 4-cyfrowe';
        case 24: return '👑 Boss mistrz odejmowania';
        case 25: return 'Mnożenie jako grupy';
        case 26: return 'Tabliczka mnożenia 2 i 3';
        case 27: return 'Tabliczka mnożenia 4 i 5';
        case 28: return 'Tabliczka mnożenia 6 i 7';
        case 29: return 'Tabliczka mnożenia 8 i 9';
        case 30: return 'Tabliczka mnożenia 10, 11 i 12';
        case 31: return '2-cyfrowe × 1-cyfrowe (proste)';
        case 32: return '2-cyfrowe × 1-cyfrowe (zaawansowane)';
        case 33: return '2-cyfrowe × 2-cyfrowe';
        case 34: return '👑 Boss mistrz mnożenia';
        case 35: return 'Dzielenie jako równy podział';
        case 36: return 'Dzielenie przez 2, 3 i 4';
        case 37: return 'Dzielenie przez 5 i 10';
        case 38: return 'Dzielenie przez 6, 7, 8 i 9';
        case 39: return 'Dzielenie przez 11 i 12';
        case 40: return '2-cyfrowe ÷ 1-cyfrowe (proste)';
        case 41: return '2-cyfrowe ÷ 1-cyfrowe (zaawansowane)';
        case 42: return '3-cyfrowe ÷ 1-cyfrowe';
        case 43: return '3-cyfrowe ÷ 2-cyfrowe';
        case 44: return '👑 Boss mistrz dzielenia';
        case 45: return 'Kwadraty podstawy (1² do 6²)';
        case 46: return 'Kwadraty zaawansowane (7² do 12²)';
        case 47: return 'Kwadraty 2-cyfrowe (13² do 25²)';
        case 48: return 'Pierwiastki kwadratowe (√4 do √49)';
        case 49: return 'Pierwiastki kwadratowe (√64 do √400)';
        case 50: return 'Sześciany podstawy (1³ do 5³)';
        case 51: return 'Sześciany zaawansowane (6³ do 10³)';
        case 52: return '4. potęgi podstawy (1⁴ do 3⁴)';
        case 53: return '4. potęgi zaawansowane (4⁴, 5⁴, 10⁴)';
        case 54: return '👑 Boss potęg i pierwiastków';
        case 55: return 'Próba szybkości: dodawanie i odejmowanie';
        case 56: return 'Próba szybkości: mnożenie i dzielenie';
        case 57: return 'Próba szybkości: potęgi i pierwiastki';
        case 58: return 'Wyzwanie wszechstronne';
        case 59: return '👑 Wielki boss półfinałowy';
        case 60: return '👑 Ostateczny boss ukończenia';
        default: return 'Trening mistrzowski';
      }
    }
    switch (level) {
      case 1: return 'What is 0 & Counting (1 to 5)';
      case 2: return 'Counting (6 to 10) & Comparing';
      case 3: return 'Place Value & Even / Odd';
      case 4: return '👑 Number Sense Milestone';
      case 5: return '1-Digit Addition (Sums to 5)';
      case 6: return '1-Digit Addition (Sums to 10)';
      case 7: return 'Addition (Bridging 10)';
      case 8: return '2-Digit + 1-Digit (Simple)';
      case 9: return '2-Digit + 1-Digit (Carrying)';
      case 10: return '2-Digit + 2-Digit (Simple)';
      case 11: return '2-Digit + 2-Digit (Carrying)';
      case 12: return '3-Digit Addition';
      case 13: return '4-Digit Addition';
      case 14: return '👑 Addition Master Boss';
      case 15: return '1-Digit Subtraction (Within 5)';
      case 16: return '1-Digit Subtraction (Within 10)';
      case 17: return 'Subtraction Across 10';
      case 18: return '2-Digit - 1-Digit (Simple)';
      case 19: return '2-Digit - 1-Digit (Borrowing)';
      case 20: return '2-Digit - 2-Digit (Simple)';
      case 21: return '2-Digit - 2-Digit (Borrowing)';
      case 22: return '3-Digit Subtraction';
      case 23: return '4-Digit Subtraction';
      case 24: return '👑 Subtraction Master Boss';
      case 25: return 'Multiplication as Groups';
      case 26: return 'Times Tables 2 & 3';
      case 27: return 'Times Tables 4 & 5';
      case 28: return 'Times Tables 6 & 7';
      case 29: return 'Times Tables 8 & 9';
      case 30: return 'Times Tables 10, 11 & 12';
      case 31: return '2-Digit × 1-Digit (Simple)';
      case 32: return '2-Digit × 1-Digit (Advanced)';
      case 33: return '2-Digit × 2-Digit';
      case 34: return '👑 Multiplication Master Boss';
      case 35: return 'Division as Equal Sharing';
      case 36: return 'Division by 2, 3 & 4';
      case 37: return 'Division by 5 & 10';
      case 38: return 'Division by 6, 7, 8 & 9';
      case 39: return 'Division by 11 & 12';
      case 40: return '2-Digit ÷ 1-Digit (Simple)';
      case 41: return '2-Digit ÷ 1-Digit (Advanced)';
      case 42: return '3-Digit ÷ 1-Digit';
      case 43: return '3-Digit ÷ 2-Digit';
      case 44: return '👑 Division Master Boss';
      case 45: return 'Squares Basics (1² to 6²)';
      case 46: return 'Squares Advanced (7² to 12²)';
      case 47: return '2-Digit Squares (13² to 25²)';
      case 48: return 'Square Roots (√4 to √49)';
      case 49: return 'Square Roots (√64 to √400)';
      case 50: return 'Cubes Basics (1³ to 5³)';
      case 51: return 'Cubes Advanced (6³ to 10³)';
      case 52: return 'Power 4 Basics (1⁴ to 3⁴)';
      case 53: return 'Power 4 Advanced (4⁴, 5⁴, 10⁴)';
      case 54: return '👑 Powers & Roots Boss';
      case 55: return 'Speed Trial: Add & Subtract';
      case 56: return 'Speed Trial: Multiply & Divide';
      case 57: return 'Speed Trial: Powers & Roots';
      case 58: return 'All-Rounder Challenge';
      case 59: return '👑 Grand Semi-Final Boss';
      case 60: return '👑 The Ultimate Graduation Boss';
      default: return 'Master Practice';
    }
  }

  String translatePrompt(String prompt) {
    if (localeName.startsWith('tr')) {
      if (prompt == 'Which number means ZERO?' || prompt == 'Which number means ZERO (nothing)?') {
        return 'Hangi sayı SIFIR (hiçlik) anlamına gelir?';
      }
      if (prompt == 'Count the dots:' || prompt == 'Count the glowing dots:') {
        return 'Işıltılı noktaları say:';
      }
      if (prompt == 'Which number is LARGER?') {
        return 'Hangi sayı DAHA BÜYÜKTÜR?';
      }
      if (prompt == 'Which number is SMALLER?') {
        return 'Hangi sayı DAHA KÜÇÜKTÜR?';
      }
      final tensOnesMatch = RegExp(r'What number has (\d+) Tens and (\d+) Ones\?').firstMatch(prompt);
      if (tensOnesMatch != null) {
        return 'Hangi sayıda ${tensOnesMatch.group(1)} Onluk ve ${tensOnesMatch.group(2)} Birlik vardır?';
      }
      final htoMatch = RegExp(r'What number is (\d+) Hundreds, (\d+) Tens & (\d+) Ones\?').firstMatch(prompt);
      if (htoMatch != null) {
        return '${htoMatch.group(1)} Yüzlük, ${htoMatch.group(2)} Onluk & ${htoMatch.group(3)} Birlik hangi sayıdır?';
      }
      final evenOddMatch = RegExp(r'Is the number (\d+) Even or Odd\?').firstMatch(prompt);
      if (evenOddMatch != null) {
        return '${evenOddMatch.group(1)} sayısı Çift mi yoksa Tek mi?';
      }
      return prompt;
    }
    if (localeName.startsWith('pl')) {
      if (prompt == 'Which number means ZERO?' || prompt == 'Which number means ZERO (nothing)?') {
        return 'Która liczba oznacza ZERO (nic)?';
      }
      if (prompt == 'Count the dots:' || prompt == 'Count the glowing dots:') {
        return 'Policz świecące kropki:';
      }
      if (prompt == 'Which number is LARGER?') {
        return 'Która liczba jest WIĘKSZA?';
      }
      if (prompt == 'Which number is SMALLER?') {
        return 'Która liczba jest MNIEJSZA?';
      }
      final tensOnesMatch = RegExp(r'What number has (\d+) Tens and (\d+) Ones\?').firstMatch(prompt);
      if (tensOnesMatch != null) {
        return 'Która liczba ma ${tensOnesMatch.group(1)} dziesiątek i ${tensOnesMatch.group(2)} jedności?';
      }
      final htoMatch = RegExp(r'What number is (\d+) Hundreds, (\d+) Tens & (\d+) Ones\?').firstMatch(prompt);
      if (htoMatch != null) {
        return 'Która liczba to ${htoMatch.group(1)} setek, ${htoMatch.group(2)} dziesiątek i ${htoMatch.group(3)} jedności?';
      }
      final evenOddMatch = RegExp(r'Is the number (\d+) Even or Odd\?').firstMatch(prompt);
      if (evenOddMatch != null) {
        return 'Czy liczba ${evenOddMatch.group(1)} jest parzysta czy nieparzysta?';
      }
      return prompt;
    }
    if (!localeName.startsWith('de')) return prompt;
    if (prompt == 'Which number means ZERO?' || prompt == 'Which number means ZERO (nothing)?') {
      return 'Welche Zahl bedeutet NULL (nichts)?';
    }
    if (prompt == 'Count the dots:' || prompt == 'Count the glowing dots:') {
      return 'Zähle die leuchtenden Punkte:';
    }
    if (prompt == 'Which number is LARGER?') {
      return 'Welche Zahl ist GRÖSSER?';
    }
    if (prompt == 'Which number is SMALLER?') {
      return 'Welche Zahl ist KLEINER?';
    }
    final tensOnesMatch = RegExp(r'What number has (\d+) Tens and (\d+) Ones\?').firstMatch(prompt);
    if (tensOnesMatch != null) {
      return 'Welche Zahl hat ${tensOnesMatch.group(1)} Zehner und ${tensOnesMatch.group(2)} Einer?';
    }
    final htoMatch = RegExp(r'What number is (\d+) Hundreds, (\d+) Tens & (\d+) Ones\?').firstMatch(prompt);
    if (htoMatch != null) {
      return 'Welche Zahl sind ${htoMatch.group(1)} Hunderter, ${htoMatch.group(2)} Zehner & ${htoMatch.group(3)} Einer?';
    }
    final evenOddMatch = RegExp(r'Is the number (\d+) Even or Odd\?').firstMatch(prompt);
    if (evenOddMatch != null) {
      return 'Ist die Zahl ${evenOddMatch.group(1)} Gerade oder Ungerade?';
    }
    return prompt;
  }

  String translateSubtitle(String subtitle) {
    if (localeName.startsWith('tr')) {
      if (subtitle == 'No dots shown below') {
        return 'Aşağıda hiç nokta gösterilmiyor';
      }
      if (subtitle.contains('Even pairs equally') || subtitle.contains('Odd has one left over')) {
        return 'Çift eşit olarak eşleşir (2, 4, 6...); Tek sayının 1 fazlalığı kalır.';
      }
      if (subtitle.contains(' or ')) {
        return subtitle.replaceAll(' or ', ' veya ');
      }
      return subtitle;
    }
    if (localeName.startsWith('pl')) {
      if (subtitle == 'No dots shown below') {
        return 'Brak kropek poniżej';
      }
      if (subtitle.contains('Even pairs equally') || subtitle.contains('Odd has one left over')) {
        return 'Parzyste tworzą równe pary (2, 4, 6...); nieparzyste mają 1 reszty.';
      }
      if (subtitle.contains(' or ')) {
        return subtitle.replaceAll(' or ', ' lub ');
      }
      return subtitle;
    }
    if (!localeName.startsWith('de')) return subtitle;
    if (subtitle == 'No dots shown below') {
      return 'Keine Punkte unten angezeigt';
    }
    if (subtitle.contains('Even pairs equally') || subtitle.contains('Odd has one left over')) {
      return 'Gerade teilt sich gleichmäßig auf (2, 4, 6...); Ungerade hat 1 Rest.';
    }
    if (subtitle.contains(' or ')) {
      return subtitle.replaceAll(' or ', ' oder ');
    }
    return subtitle;
  }

  String translateOption(String option) {
    if (localeName.startsWith('tr')) {
      if (option == 'Even') return 'Çift';
      if (option == 'Odd') return 'Tek';
      return option;
    }
    if (localeName.startsWith('pl')) {
      if (option == 'Even') return 'Parzysta';
      if (option == 'Odd') return 'Nieparzysta';
      return option;
    }
    if (!localeName.startsWith('de')) return option;
    if (option == 'Even') return 'Gerade';
    if (option == 'Odd') return 'Ungerade';
    return option;
  }

  String translateExplanation(String step) {
    if (localeName.startsWith('tr')) {
      if (step.contains('Zero means nothing') || step.contains('Zero means nothing or empty')) {
        return 'Sıfır, hiçlik veya boş alan anlamına gelir — sayılacak hiçbir öğe yoktur!';
      }
      final countDotsMatch = RegExp(r'Count each glowing dot one by one: 1, 2, 3\.\.\. until you reach (\d+)\.').firstMatch(step);
      if (countDotsMatch != null) {
        return 'Her ışıltılı noktayı teker teker say: 1, 2, 3... ta ki ${countDotsMatch.group(1)} sayısına ulaşana kadar.';
      }
      final dotsShownMatch = RegExp(r'There are (\d+) dots shown on the screen\.').firstMatch(step);
      if (dotsShownMatch != null) {
        return 'Ekranda ${dotsShownMatch.group(1)} nokta gösteriliyor.';
      }
      final countingTotalsMatch = RegExp(r'Counting every glowing dot totals (\d+)\.').firstMatch(step);
      if (countingTotalsMatch != null) {
        return 'Tüm ışıltılı noktalar sayıldığında toplam ${countingTotalsMatch.group(1)} eder.';
      }
      final tensMeansMatch = RegExp(r'First, (\d+) Tens means \1 groups of 10, which equals (\d+)\.').firstMatch(step);
      if (tensMeansMatch != null) {
        return 'İlk olarak, ${tensMeansMatch.group(1)} Onluk, ${tensMeansMatch.group(1)} adet 10luk grup anlamına gelir ve ${tensMeansMatch.group(2)} değerine eşittir.';
      }
      final onesMeansMatch = RegExp(r'Next, (\d+) Ones simply equals \1\.').firstMatch(step);
      if (onesMeansMatch != null) {
        return 'Ardından, ${onesMeansMatch.group(1)} Birlik sadece ${onesMeansMatch.group(1)} eder.';
      }
      final combineMatch = RegExp(r'Finally, combine them together: (\d+) plus (\d+) gives (\d+)\.').firstMatch(step);
      if (combineMatch != null) {
        return 'Son olarak, bunları birleştir: ${combineMatch.group(1)} artı ${combineMatch.group(2)}, ${combineMatch.group(3)} eder.';
      }
      final hundredsMeansMatch = RegExp(r'First, (\d+) Hundreds means \1 groups of 100 = (\d+)\.').firstMatch(step);
      if (hundredsMeansMatch != null) {
        return 'İlk olarak, ${hundredsMeansMatch.group(1)} Yüzlük, ${hundredsMeansMatch.group(1)} adet 100lük grup demektir = ${hundredsMeansMatch.group(2)}.';
      }
      final tensGroupMatch = RegExp(r'Next, (\d+) Tens means \1 groups of 10 = (\d+)\.').firstMatch(step);
      if (tensGroupMatch != null) {
        return 'Ardından, ${tensGroupMatch.group(1)} Onluk, ${tensGroupMatch.group(1)} adet 10luk grup demektir = ${tensGroupMatch.group(2)}.';
      }
      final thenOnesMatch = RegExp(r'Then, (\d+) Ones equals \1\.').firstMatch(step);
      if (thenOnesMatch != null) {
        return 'Sonra, ${thenOnesMatch.group(1)} Birlik ${thenOnesMatch.group(1)} eder.';
      }
      final addAllMatch = RegExp(r'Add them all up: (.+)').firstMatch(step);
      if (addAllMatch != null) {
        return 'Hepsini topla: ${addAllMatch.group(1)}';
      }
      final tensEqualMatch = RegExp(r'(\d+) Tens = (\d+)\.').firstMatch(step);
      if (tensEqualMatch != null) {
        return '${tensEqualMatch.group(1)} Onluk = ${tensEqualMatch.group(2)}.';
      }
      final onesEqualMatch = RegExp(r'(\d+) Ones = (\d+)\.').firstMatch(step);
      if (onesEqualMatch != null) {
        return '${onesEqualMatch.group(1)} Birlik = ${onesEqualMatch.group(2)}.';
      }
      final lineUpMatch = RegExp(r'Line up the numbers: starting with (\d+) and adding (\d+)\.').firstMatch(step);
      if (lineUpMatch != null) {
        return 'Sayıları hizala: ${lineUpMatch.group(1)} ile başla ve ${lineUpMatch.group(2)} ekle.';
      }
      final addOnesMatch = RegExp(r'First, add the ones digits: (.+)').firstMatch(step);
      if (addOnesMatch != null) {
        return 'Önce birlik basamaklarını topla: ${addOnesMatch.group(1)}';
      }
      if (step == 'Next, add the remaining digits (tens and hundreds) along with any carry over.') {
        return 'Ardından kalan basamakları (onlar ve yüzler) elde ile birlikte topla.';
      }
      final addTensMatch = RegExp(r'Next, add the tens digits: (.+)').firstMatch(step);
      if (addTensMatch != null) {
        return 'Ardından onlar basamaklarını topla: ${addTensMatch.group(1)}';
      }
      final putTogetherMatch = RegExp(r'Putting it all together: (.+)').firstMatch(step);
      if (putTogetherMatch != null) {
        return 'Hepsini bir araya getir: ${putTogetherMatch.group(1)}';
      }
      final addTogetherFinalMatch = RegExp(r'Add them together to get the final sum: (.+)').firstMatch(step);
      if (addTogetherFinalMatch != null) {
        return 'Son toplamı bulmak için bunları topla: ${addTogetherFinalMatch.group(1)}';
      }
      final startAmountMatch = RegExp(r'Start (?:at the total amount:|with the starting amount of) (\d+)\.').firstMatch(step);
      if (startAmountMatch != null) {
        return 'Başlangıç miktarıyla başla: ${startAmountMatch.group(1)}.';
      }
      final countBackwardMatch = RegExp(r'(?:Count backward or take|Take) away (\d+) step by step\.').firstMatch(step);
      if (countBackwardMatch != null) {
        return 'Geriye doğru say veya adım adım ${countBackwardMatch.group(1)} çıkar.';
      }
      final leftWithMatch = RegExp(r'You are left with:? (\d+)\.').firstMatch(step);
      if (leftWithMatch != null) {
        return 'Kalan sonuç: ${leftWithMatch.group(1)}.';
      }
      final multMeansMatch = RegExp(r'(?:Multiplication \((.+)\) means adding (\d+) a total of (\d+) times\.|Think of (.+) as adding (\d+) to itself (\d+) times\.)').firstMatch(step);
      if (multMeansMatch != null) {
        final expr = multMeansMatch.group(1) ?? multMeansMatch.group(4);
        final num = multMeansMatch.group(2) ?? multMeansMatch.group(5);
        final times = multMeansMatch.group(3) ?? multMeansMatch.group(6);
        return 'Çarpma işlemi ($expr), $num sayısını toplamda $times kez eklemek anlamına gelir.';
      }
      final groupsMatch = RegExp(r'Think of making (\d+) groups with (\d+) items in each group: (.+)').firstMatch(step);
      if (groupsMatch != null) {
        return 'Her grupta ${groupsMatch.group(2)} öğe olacak şekilde ${groupsMatch.group(1)} grup oluşturmayı düşün: ${groupsMatch.group(3)}';
      }
      final countGroupsMatch = RegExp(r'Counting up all (\d+) groups of (\d+) gives (\d+)\.').firstMatch(step);
      if (countGroupsMatch != null) {
        return '${countGroupsMatch.group(2)} sayılık ${countGroupsMatch.group(1)} grubun tamamı sayıldığında ${countGroupsMatch.group(3)} elde edilir.';
      }
      final breakPartsMatch = RegExp(r'Break (\d+) into parts: (.+)').firstMatch(step);
      if (breakPartsMatch != null) {
        return '${breakPartsMatch.group(1)} sayısını parçalara ayır: ${breakPartsMatch.group(2)}';
      }
      final multTensOnesMatch = RegExp(r'Multiply tens: (.+), then ones: (.+)').firstMatch(step);
      if (multTensOnesMatch != null) {
        return 'Onlukları çarp: ${multTensOnesMatch.group(1)}, sonra birlikleri çarp: ${multTensOnesMatch.group(2)}';
      }
      final addPartsMatch = RegExp(r'Add the parts: (.+)').firstMatch(step);
      if (addPartsMatch != null) {
        return 'Parçaları topla: ${addPartsMatch.group(1)}';
      }
      final finalProdMatch = RegExp(r'Final product: (\d+)\.').firstMatch(step);
      if (finalProdMatch != null) {
        return 'Son çarpım: ${finalProdMatch.group(1)}.';
      }
      final divSplitMatch = RegExp(r'(?:Division \((.+)\) means splitting a total of (\d+) into (\d+) equal groups\.|Imagine dividing (\d+) into (\d+) equal parts\.)').firstMatch(step);
      if (divSplitMatch != null) {
        final total = divSplitMatch.group(2) ?? divSplitMatch.group(4);
        final parts = divSplitMatch.group(3) ?? divSplitMatch.group(5);
        return 'Bölme işlemi, toplam $total değerini $parts eşit gruba ayırmak demektir.';
      }
      final divAskMatch = RegExp(r'Ask: How many times does (\d+) fit into (\d+)\?').firstMatch(step);
      if (divAskMatch != null) {
        return 'Sor: ${divAskMatch.group(1)} sayısı ${divAskMatch.group(2)} içine kaç kez sığar?';
      }
      final verifyMultMatch = RegExp(r'Verify with multiplication: (.+)').firstMatch(step);
      if (verifyMultMatch != null) {
        return 'Çarpma ile doğrula: ${verifyMultMatch.group(1)}';
      }
      final becauseDivMatch = RegExp(r'Because (.+) = (\d+), the result is (\d+)\.').firstMatch(step);
      if (becauseDivMatch != null) {
        return '${becauseDivMatch.group(1)} = ${becauseDivMatch.group(2)} olduğu için sonuç ${becauseDivMatch.group(3)} olur.';
      }
      final divResultMatch = RegExp(r'Result: Each group receives (\d+)\.').firstMatch(step);
      if (divResultMatch != null) {
        return 'Sonuç: Her gruba ${divResultMatch.group(1)} düşer.';
      }
      if (step.contains('The square root symbol (√) asks:') ||
          step.contains('The square root (√') ||
          step.contains('Find the mystery number that gives') ||
          step.contains('Ask: What number times itself equals')) {
        return 'Karekök sembolü sorar: Kendisiyle çarpıldığında bu değeri veren sayı hangisidir?';
      }
      final testCandMatch = RegExp(r'(?:Test candidate:|Check:) (.+)').firstMatch(step);
      if (testCandMatch != null) {
        return 'Kontrol et: ${testCandMatch.group(1)}';
      }
      final thereforeRootMatch = RegExp(r'(?:Therefore,|So the square root of \d+ is) (?:√\d+ = )?(\d+)\.').firstMatch(step);
      if (thereforeRootMatch != null) {
        return 'Dolayısıyla sonuç ${thereforeRootMatch.group(1)} olur.';
      }
      final sinceRootMatch = RegExp(r'(?:Since|Because) (.+) = (\d+), √\2 = (\d+)\.').firstMatch(step);
      if (sinceRootMatch != null) {
        return '${sinceRootMatch.group(1)} = ${sinceRootMatch.group(2)} olduğundan, √${sinceRootMatch.group(2)} = ${sinceRootMatch.group(3)} olur.';
      }
      final squareExpMatch = RegExp(r'(?:The small ² exponent means "square" — multiply (\d+) by itself \(\1 × \1\)\.|Squaring \((\d+)²\) means multiplying \2 by itself\.|Multiply (\d+) by itself:? \3 × \3\.|Multiply (\d+) by itself \(\4 × \4\)\.|(\d+)² means multiplying \5 by itself.*)').firstMatch(step);
      if (squareExpMatch != null) {
        final b = squareExpMatch.group(1) ?? squareExpMatch.group(2) ?? squareExpMatch.group(3) ?? squareExpMatch.group(4) ?? squareExpMatch.group(5);
        return 'Kare alma ($b²), $b sayısını kendisiyle çarpmak ($b × $b) anlamına gelir.';
      }
      final calcMatch = RegExp(r'(?:Calculation:|Final calculation:|Result:) (.+)').firstMatch(step);
      if (calcMatch != null) {
        return 'Hesaplama: ${calcMatch.group(1)}';
      }
      final cubeExpMatch = RegExp(r'(?:The ³ exponent means "cube" — multiply (\d+) by itself 3 times.*|Cubing \((\d+)³\) means multiplying \2 by itself 3 times\.|Multiply (\d+) by itself 3 times.*|(\d+)³ means multiplying \4 by itself 3 times.*)').firstMatch(step);
      if (cubeExpMatch != null) {
        final b = cubeExpMatch.group(1) ?? cubeExpMatch.group(2) ?? cubeExpMatch.group(3) ?? cubeExpMatch.group(4);
        return 'Küp alma ($b³), $b sayısını kendisiyle 3 kez çarpmak ($b × $b × $b) anlamına gelir.';
      }
      final step1SquareMatch = RegExp(r'(?:Step 1 \(square\):|Step 1:|First,) (.+)').firstMatch(step);
      if (step1SquareMatch != null) {
        return '1. Adım: ${step1SquareMatch.group(1)}';
      }
      final step2CubeMatch = RegExp(r'(?:Step 2 \(cube\):|Step 2: Multiply|Then,) (.+)').firstMatch(step);
      if (step2CubeMatch != null) {
        return '2. Adım: ${step2CubeMatch.group(1)}';
      }
      final p4Match = RegExp(r'(\d+)⁴ means multiplying \1 by itself 4 times.*|Multiply (\d+) by itself 4 times.*').firstMatch(step);
      if (p4Match != null) {
        final b = p4Match.group(1) ?? p4Match.group(2);
        return '$b⁴, $b sayısını kendisiyle 4 kez çarpmak ($b × $b × $b × $b) anlamına gelir.';
      }
      final step2P4Match = RegExp(r'Step 2 \(power of 4\): (.+)').firstMatch(step);
      if (step2P4Match != null) {
        return '2. Adım (4. kuvvet): ${step2P4Match.group(1)}';
      }
      final compareMatch = RegExp(r'Comparing (\d+) and (\d+)\.').firstMatch(step);
      if (compareMatch != null) {
        return '${compareMatch.group(1)} ve ${compareMatch.group(2)} sayılarını karşılaştırma.';
      }
      final greaterMatch = RegExp(r'(\d+) is greater because it comes further along the number line\.').firstMatch(step);
      if (greaterMatch != null) {
        return '${greaterMatch.group(1)} daha büyüktür çünkü sayı doğrusunda daha sağdadır.';
      }
      final smallerMatch = RegExp(r'(\d+) is smaller because it is closer to 0\.').firstMatch(step);
      if (smallerMatch != null) {
        return '${smallerMatch.group(1)} daha küçüktür çünkü 0\'a daha yakındır.';
      }
      final evenDivideMatch = RegExp(r'Divide (\d+) by 2: \1 ÷ 2 = (\d+) with remainder (\d+)\.').firstMatch(step);
      if (evenDivideMatch != null) {
        return '${evenDivideMatch.group(1)} sayısını 2\'ye böl: ${evenDivideMatch.group(1)} ÷ 2 = ${evenDivideMatch.group(2)} ile kalan ${evenDivideMatch.group(3)}.';
      }
      final evenNoRemainderMatch = RegExp(r'Since there is no remainder, (\d+) is Even\.').firstMatch(step);
      if (evenNoRemainderMatch != null) {
        return 'Kalan olmadığı için ${evenNoRemainderMatch.group(1)} Çifttir.';
      }
      final oddRemainderMatch = RegExp(r'Since 1 is left over, (\d+) is Odd\.').firstMatch(step);
      if (oddRemainderMatch != null) {
        return '1 kalan olduğu için ${oddRemainderMatch.group(1)} Tektir.';
      }
      return step;
    }
    if (localeName.startsWith('pl')) {
      if (step.contains('Zero means nothing') || step.contains('Zero means nothing or empty')) {
        return 'Zero oznacza nic lub pustkę — nie ma czego liczyć!';
      }
      final countDotsMatch = RegExp(r'Count each glowing dot one by one: 1, 2, 3\.\.\. until you reach (\d+)\.').firstMatch(step);
      if (countDotsMatch != null) {
        return 'Policz każdą świecącą kropkę po kolei: 1, 2, 3... aż dojdziesz do ${countDotsMatch.group(1)}.';
      }
      final dotsShownMatch = RegExp(r'There are (\d+) dots shown on the screen\.').firstMatch(step);
      if (dotsShownMatch != null) {
        return 'Na ekranie pokazano ${dotsShownMatch.group(1)} kropek.';
      }
      final countingTotalsMatch = RegExp(r'Counting every glowing dot totals (\d+)\.').firstMatch(step);
      if (countingTotalsMatch != null) {
        return 'Policzenie wszystkich świecących kropek daje łącznie ${countingTotalsMatch.group(1)}.';
      }
      final tensMeansMatch = RegExp(r'First, (\d+) Tens means \1 groups of 10, which equals (\d+)\.').firstMatch(step);
      if (tensMeansMatch != null) {
        return 'Najpierw ${tensMeansMatch.group(1)} dziesiątek oznacza ${tensMeansMatch.group(1)} grup po 10, co równa się ${tensMeansMatch.group(2)}.';
      }
      final onesMeansMatch = RegExp(r'Next, (\d+) Ones simply equals \1\.').firstMatch(step);
      if (onesMeansMatch != null) {
        return 'Następnie ${onesMeansMatch.group(1)} jedności to po prostu ${onesMeansMatch.group(1)}.';
      }
      final combineMatch = RegExp(r'Finally, combine them together: (\d+) plus (\d+) gives (\d+)\.').firstMatch(step);
      if (combineMatch != null) {
        return 'Na koniec połącz je razem: ${combineMatch.group(1)} plus ${combineMatch.group(2)} daje ${combineMatch.group(3)}.';
      }
      final hundredsMeansMatch = RegExp(r'First, (\d+) Hundreds means \1 groups of 100 = (\d+)\.').firstMatch(step);
      if (hundredsMeansMatch != null) {
        return 'Najpierw ${hundredsMeansMatch.group(1)} setek oznacza ${hundredsMeansMatch.group(1)} grup po 100 = ${hundredsMeansMatch.group(2)}.';
      }
      final tensGroupMatch = RegExp(r'Next, (\d+) Tens means \1 groups of 10 = (\d+)\.').firstMatch(step);
      if (tensGroupMatch != null) {
        return 'Następnie ${tensGroupMatch.group(1)} dziesiątek oznacza ${tensGroupMatch.group(1)} grup po 10 = ${tensGroupMatch.group(2)}.';
      }
      final thenOnesMatch = RegExp(r'Then, (\d+) Ones equals \1\.').firstMatch(step);
      if (thenOnesMatch != null) {
        return 'Potem ${thenOnesMatch.group(1)} jedności równa się ${thenOnesMatch.group(1)}.';
      }
      final addAllMatch = RegExp(r'Add them all up: (.+)').firstMatch(step);
      if (addAllMatch != null) {
        return 'Zsumuj wszystko: ${addAllMatch.group(1)}';
      }
      final tensEqualMatch = RegExp(r'(\d+) Tens = (\d+)\.').firstMatch(step);
      if (tensEqualMatch != null) {
        return '${tensEqualMatch.group(1)} dziesiątek = ${tensEqualMatch.group(2)}.';
      }
      final onesEqualMatch = RegExp(r'(\d+) Ones = (\d+)\.').firstMatch(step);
      if (onesEqualMatch != null) {
        return '${onesEqualMatch.group(1)} jedności = ${onesEqualMatch.group(2)}.';
      }
      final lineUpMatch = RegExp(r'Line up the numbers: starting with (\d+) and adding (\d+)\.').firstMatch(step);
      if (lineUpMatch != null) {
        return 'Ustaw liczby w rzędzie: zacznij od ${lineUpMatch.group(1)} i dodaj ${lineUpMatch.group(2)}.';
      }
      final addOnesMatch = RegExp(r'First, add the ones digits: (.+)').firstMatch(step);
      if (addOnesMatch != null) {
        return 'Najpierw dodaj cyfry jedności: ${addOnesMatch.group(1)}';
      }
      if (step == 'Next, add the remaining digits (tens and hundreds) along with any carry over.') {
        return 'Następnie dodaj pozostałe cyfry (dziesiątki i setki) wraz z przeniesieniem.';
      }
      final addTensMatch = RegExp(r'Next, add the tens digits: (.+)').firstMatch(step);
      if (addTensMatch != null) {
        return 'Następnie dodaj cyfry dziesiątek: ${addTensMatch.group(1)}';
      }
      final putTogetherMatch = RegExp(r'Putting it all together: (.+)').firstMatch(step);
      if (putTogetherMatch != null) {
        return 'Zbierając to wszystko razem: ${putTogetherMatch.group(1)}';
      }
      final addTogetherFinalMatch = RegExp(r'Add them together to get the final sum: (.+)').firstMatch(step);
      if (addTogetherFinalMatch != null) {
        return 'Dodaj je razem, aby otrzymać końcową sumę: ${addTogetherFinalMatch.group(1)}';
      }
      final startAmountMatch = RegExp(r'Start (?:at the total amount:|with the starting amount of) (\d+)\.').firstMatch(step);
      if (startAmountMatch != null) {
        return 'Zacznij od wartości początkowej: ${startAmountMatch.group(1)}.';
      }
      final countBackwardMatch = RegExp(r'(?:Count backward or take|Take) away (\d+) step by step\.').firstMatch(step);
      if (countBackwardMatch != null) {
        return 'Odliczaj wstecz lub odejmuj ${countBackwardMatch.group(1)} krok po kroku.';
      }
      final leftWithMatch = RegExp(r'You are left with:? (\d+)\.').firstMatch(step);
      if (leftWithMatch != null) {
        return 'Zostaje: ${leftWithMatch.group(1)}.';
      }
      final multMeansMatch = RegExp(r'(?:Multiplication \((.+)\) means adding (\d+) a total of (\d+) times\.|Think of (.+) as adding (\d+) to itself (\d+) times\.)').firstMatch(step);
      if (multMeansMatch != null) {
        final expr = multMeansMatch.group(1) ?? multMeansMatch.group(4);
        final num = multMeansMatch.group(2) ?? multMeansMatch.group(5);
        final times = multMeansMatch.group(3) ?? multMeansMatch.group(6);
        return 'Mnożenie ($expr) oznacza dodawanie $num łącznie $times razy.';
      }
      final groupsMatch = RegExp(r'Think of making (\d+) groups with (\d+) items in each group: (.+)').firstMatch(step);
      if (groupsMatch != null) {
        return 'Pomyśl o utworzeniu ${groupsMatch.group(1)} grup po ${groupsMatch.group(2)} elementów każda: ${groupsMatch.group(3)}';
      }
      final countGroupsMatch = RegExp(r'Counting up all (\d+) groups of (\d+) gives (\d+)\.').firstMatch(step);
      if (countGroupsMatch != null) {
        return 'Policzenie wszystkich ${countGroupsMatch.group(1)} grup po ${countGroupsMatch.group(2)} daje ${countGroupsMatch.group(3)}.';
      }
      final breakPartsMatch = RegExp(r'Break (\d+) into parts: (.+)').firstMatch(step);
      if (breakPartsMatch != null) {
        return 'Rozbij ${breakPartsMatch.group(1)} na części: ${breakPartsMatch.group(2)}';
      }
      final multTensOnesMatch = RegExp(r'Multiply tens: (.+), then ones: (.+)').firstMatch(step);
      if (multTensOnesMatch != null) {
        return 'Pomnóż dziesiątki: ${multTensOnesMatch.group(1)}, potem jedności: ${multTensOnesMatch.group(2)}';
      }
      final addPartsMatch = RegExp(r'Add the parts: (.+)').firstMatch(step);
      if (addPartsMatch != null) {
        return 'Dodaj części: ${addPartsMatch.group(1)}';
      }
      final finalProdMatch = RegExp(r'Final product: (\d+)\.').firstMatch(step);
      if (finalProdMatch != null) {
        return 'Końcowy iloczyn: ${finalProdMatch.group(1)}.';
      }
      final divSplitMatch = RegExp(r'(?:Division \((.+)\) means splitting a total of (\d+) into (\d+) equal groups\.|Imagine dividing (\d+) into (\d+) equal parts\.)').firstMatch(step);
      if (divSplitMatch != null) {
        final total = divSplitMatch.group(2) ?? divSplitMatch.group(4);
        final parts = divSplitMatch.group(3) ?? divSplitMatch.group(5);
        return 'Dzielenie oznacza podział całości $total na $parts równych grup.';
      }
      final divAskMatch = RegExp(r'Ask: How many times does (\d+) fit into (\d+)\?').firstMatch(step);
      if (divAskMatch != null) {
        return 'Zapytaj: ile razy ${divAskMatch.group(1)} mieści się w ${divAskMatch.group(2)}?';
      }
      final verifyMultMatch = RegExp(r'Verify with multiplication: (.+)').firstMatch(step);
      if (verifyMultMatch != null) {
        return 'Sprawdź przez mnożenie: ${verifyMultMatch.group(1)}';
      }
      final becauseDivMatch = RegExp(r'Because (.+) = (\d+), the result is (\d+)\.').firstMatch(step);
      if (becauseDivMatch != null) {
        return 'Ponieważ ${becauseDivMatch.group(1)} = ${becauseDivMatch.group(2)}, wynik to ${becauseDivMatch.group(3)}.';
      }
      final divResultMatch = RegExp(r'Result: Each group receives (\d+)\.').firstMatch(step);
      if (divResultMatch != null) {
        return 'Wynik: każda grupa otrzymuje ${divResultMatch.group(1)}.';
      }
      if (step.contains('The square root symbol (√) asks:') ||
          step.contains('The square root (√') ||
          step.contains('Find the mystery number that gives') ||
          step.contains('Ask: What number times itself equals')) {
        return 'Symbol pierwiastka kwadratowego (√) pyta: jaka liczba pomnożona przez siebie daje tę wartość?';
      }
      final testCandMatch = RegExp(r'(?:Test candidate:|Check:) (.+)').firstMatch(step);
      if (testCandMatch != null) {
        return 'Sprawdź: ${testCandMatch.group(1)}';
      }
      final thereforeRootMatch = RegExp(r'(?:Therefore,|So the square root of \d+ is) (?:√\d+ = )?(\d+)\.').firstMatch(step);
      if (thereforeRootMatch != null) {
        return 'Zatem wynik to ${thereforeRootMatch.group(1)}.';
      }
      final sinceRootMatch = RegExp(r'(?:Since|Because) (.+) = (\d+), √\2 = (\d+)\.').firstMatch(step);
      if (sinceRootMatch != null) {
        return 'Ponieważ ${sinceRootMatch.group(1)} = ${sinceRootMatch.group(2)}, to √${sinceRootMatch.group(2)} = ${sinceRootMatch.group(3)}.';
      }
      final squareExpMatch = RegExp(r'(?:The small ² exponent means "square" — multiply (\d+) by itself \(\1 × \1\)\.|Squaring \((\d+)²\) means multiplying \2 by itself\.|Multiply (\d+) by itself:? \3 × \3\.|Multiply (\d+) by itself \(\4 × \4\)\.|(\d+)² means multiplying \5 by itself.*)').firstMatch(step);
      if (squareExpMatch != null) {
        final b = squareExpMatch.group(1) ?? squareExpMatch.group(2) ?? squareExpMatch.group(3) ?? squareExpMatch.group(4) ?? squareExpMatch.group(5);
        return 'Podnoszenie do kwadratu ($b²) oznacza pomnożenie $b przez siebie ($b × $b).';
      }
      final calcMatch = RegExp(r'(?:Calculation:|Final calculation:|Result:) (.+)').firstMatch(step);
      if (calcMatch != null) {
        return 'Obliczenie: ${calcMatch.group(1)}';
      }
      final cubeExpMatch = RegExp(r'(?:The ³ exponent means "cube" — multiply (\d+) by itself 3 times.*|Cubing \((\d+)³\) means multiplying \2 by itself 3 times\.|Multiply (\d+) by itself 3 times.*|(\d+)³ means multiplying \4 by itself 3 times.*)').firstMatch(step);
      if (cubeExpMatch != null) {
        final b = cubeExpMatch.group(1) ?? cubeExpMatch.group(2) ?? cubeExpMatch.group(3) ?? cubeExpMatch.group(4);
        return 'Podnoszenie do sześcianu ($b³) oznacza pomnożenie $b przez siebie 3 razy ($b × $b × $b).';
      }
      final step1SquareMatch = RegExp(r'(?:Step 1 \(square\):|Step 1:|First,) (.+)').firstMatch(step);
      if (step1SquareMatch != null) {
        return 'Krok 1: ${step1SquareMatch.group(1)}';
      }
      final step2CubeMatch = RegExp(r'(?:Step 2 \(cube\):|Step 2: Multiply|Then,) (.+)').firstMatch(step);
      if (step2CubeMatch != null) {
        return 'Krok 2: ${step2CubeMatch.group(1)}';
      }
      final p4Match = RegExp(r'(\d+)⁴ means multiplying \1 by itself 4 times.*|Multiply (\d+) by itself 4 times.*').firstMatch(step);
      if (p4Match != null) {
        final b = p4Match.group(1) ?? p4Match.group(2);
        return '$b⁴ oznacza pomnożenie $b przez siebie 4 razy ($b × $b × $b × $b).';
      }
      final step2P4Match = RegExp(r'Step 2 \(power of 4\): (.+)').firstMatch(step);
      if (step2P4Match != null) {
        return 'Krok 2 (4. potęga): ${step2P4Match.group(1)}';
      }
      final compareMatch = RegExp(r'Comparing (\d+) and (\d+)\.').firstMatch(step);
      if (compareMatch != null) {
        return 'Porównywanie ${compareMatch.group(1)} i ${compareMatch.group(2)}.';
      }
      final greaterMatch = RegExp(r'(\d+) is greater because it comes further along the number line\.').firstMatch(step);
      if (greaterMatch != null) {
        return '${greaterMatch.group(1)} jest większe, ponieważ znajduje się dalej na osi liczbowej.';
      }
      final smallerMatch = RegExp(r'(\d+) is smaller because it is closer to 0\.').firstMatch(step);
      if (smallerMatch != null) {
        return '${smallerMatch.group(1)} jest mniejsze, ponieważ jest bliżej 0.';
      }
      final evenDivideMatch = RegExp(r'Divide (\d+) by 2: \1 ÷ 2 = (\d+) with remainder (\d+)\.').firstMatch(step);
      if (evenDivideMatch != null) {
        return 'Podziel ${evenDivideMatch.group(1)} przez 2: ${evenDivideMatch.group(1)} ÷ 2 = ${evenDivideMatch.group(2)} z resztą ${evenDivideMatch.group(3)}.';
      }
      final evenNoRemainderMatch = RegExp(r'Since there is no remainder, (\d+) is Even\.').firstMatch(step);
      if (evenNoRemainderMatch != null) {
        return 'Ponieważ nie ma reszty, ${evenNoRemainderMatch.group(1)} jest parzysta.';
      }
      final oddRemainderMatch = RegExp(r'Since 1 is left over, (\d+) is Odd\.').firstMatch(step);
      if (oddRemainderMatch != null) {
        return 'Ponieważ zostaje 1, ${oddRemainderMatch.group(1)} jest nieparzysta.';
      }
      return step;
    }
    if (!localeName.startsWith('de')) return step;

    if (step.contains('Zero means nothing') || step.contains('Zero means nothing or empty')) {
      return 'Null bedeutet nichts oder leerer Raum — es gibt keine Elemente zu zählen!';
    }
    final countDotsMatch = RegExp(r'Count each glowing dot one by one: 1, 2, 3\.\.\. until you reach (\d+)\.').firstMatch(step);
    if (countDotsMatch != null) {
      return 'Zähle jeden leuchtenden Punkt einzeln: 1, 2, 3... bis du ${countDotsMatch.group(1)} erreichst.';
    }
    final dotsShownMatch = RegExp(r'There are (\d+) dots shown on the screen\.').firstMatch(step);
    if (dotsShownMatch != null) {
      return 'Es werden ${dotsShownMatch.group(1)} Punkte auf dem Bildschirm angezeigt.';
    }
    final countingTotalsMatch = RegExp(r'Counting every glowing dot totals (\d+)\.').firstMatch(step);
    if (countingTotalsMatch != null) {
      return 'Alle leuchtenden Punkte zusammen ergeben ${countingTotalsMatch.group(1)}.';
    }
    final tensMeansMatch = RegExp(r'First, (\d+) Tens means \1 groups of 10, which equals (\d+)\.').firstMatch(step);
    if (tensMeansMatch != null) {
      return 'Zuerst: ${tensMeansMatch.group(1)} Zehner bedeutet ${tensMeansMatch.group(1)} Zehnergruppen, was ${tensMeansMatch.group(2)} entspricht.';
    }
    final onesMeansMatch = RegExp(r'Next, (\d+) Ones simply equals \1\.').firstMatch(step);
    if (onesMeansMatch != null) {
      return 'Als Nächstes: ${onesMeansMatch.group(1)} Einer entspricht einfach ${onesMeansMatch.group(1)}.';
    }
    final combineMatch = RegExp(r'Finally, combine them together: (\d+) plus (\d+) gives (\d+)\.').firstMatch(step);
    if (combineMatch != null) {
      return 'Schließlich zusammenfügen: ${combineMatch.group(1)} plus ${combineMatch.group(2)} ergibt ${combineMatch.group(3)}.';
    }
    final hundredsMeansMatch = RegExp(r'First, (\d+) Hundreds means \1 groups of 100 = (\d+)\.').firstMatch(step);
    if (hundredsMeansMatch != null) {
      return 'Zuerst: ${hundredsMeansMatch.group(1)} Hunderter bedeutet ${hundredsMeansMatch.group(1)} Gruppen von 100 = ${hundredsMeansMatch.group(2)}.';
    }
    final tensGroupMatch = RegExp(r'Next, (\d+) Tens means \1 groups of 10 = (\d+)\.').firstMatch(step);
    if (tensGroupMatch != null) {
      return 'Als Nächstes: ${tensGroupMatch.group(1)} Zehner bedeutet ${tensGroupMatch.group(1)} Gruppen von 10 = ${tensGroupMatch.group(2)}.';
    }
    final thenOnesMatch = RegExp(r'Then, (\d+) Ones equals \1\.').firstMatch(step);
    if (thenOnesMatch != null) {
      return 'Dann: ${thenOnesMatch.group(1)} Einer entspricht ${thenOnesMatch.group(1)}.';
    }
    final addAllMatch = RegExp(r'Add them all up: (.+)').firstMatch(step);
    if (addAllMatch != null) {
      return 'Alles zusammenzählen: ${addAllMatch.group(1)}';
    }
    final tensEqualMatch = RegExp(r'(\d+) Tens = (\d+)\.').firstMatch(step);
    if (tensEqualMatch != null) {
      return '${tensEqualMatch.group(1)} Zehner = ${tensEqualMatch.group(2)}.';
    }
    final onesEqualMatch = RegExp(r'(\d+) Ones = (\d+)\.').firstMatch(step);
    if (onesEqualMatch != null) {
      return '${onesEqualMatch.group(1)} Einer = ${onesEqualMatch.group(2)}.';
    }
    final lineUpMatch = RegExp(r'Line up the numbers: starting with (\d+) and adding (\d+)\.').firstMatch(step);
    if (lineUpMatch != null) {
      return 'Zahlen anordnen: beginne mit ${lineUpMatch.group(1)} und addiere ${lineUpMatch.group(2)}.';
    }
    final addOnesMatch = RegExp(r'First, add the ones digits: (.+)').firstMatch(step);
    if (addOnesMatch != null) {
      return 'Zuerst die Einerstellen addieren: ${addOnesMatch.group(1)}';
    }
    if (step == 'Next, add the remaining digits (tens and hundreds) along with any carry over.') {
      return 'Als Nächstes die restlichen Stellen (Zehner und Hunderter) samt Übertrag addieren.';
    }
    final addTensMatch = RegExp(r'Next, add the tens digits: (.+)').firstMatch(step);
    if (addTensMatch != null) {
      return 'Als Nächstes die Zehnerstellen addieren: ${addTensMatch.group(1)}';
    }
    final putTogetherMatch = RegExp(r'Putting it all together: (.+)').firstMatch(step);
    if (putTogetherMatch != null) {
      return 'Alles zusammen: ${putTogetherMatch.group(1)}';
    }
    final addTogetherFinalMatch = RegExp(r'Add them together to get the final sum: (.+)').firstMatch(step);
    if (addTogetherFinalMatch != null) {
      return 'Zusammenzählen ergibt die Endsumme: ${addTogetherFinalMatch.group(1)}';
    }
    final startAmountMatch = RegExp(r'Start (?:at the total amount:|with the starting amount of) (\d+)\.').firstMatch(step);
    if (startAmountMatch != null) {
      return 'Beginne mit dem Ausgangswert: ${startAmountMatch.group(1)}.';
    }
    final countBackwardMatch = RegExp(r'(?:Count backward or take|Take) away (\d+) step by step\.').firstMatch(step);
    if (countBackwardMatch != null) {
      return 'Zähle rückwärts oder ziehe ${countBackwardMatch.group(1)} Schritt für Schritt ab.';
    }
    final leftWithMatch = RegExp(r'You are left with:? (\d+)\.').firstMatch(step);
    if (leftWithMatch != null) {
      return 'Es bleibt übrig: ${leftWithMatch.group(1)}.';
    }
    final multMeansMatch = RegExp(r'(?:Multiplication \((.+)\) means adding (\d+) a total of (\d+) times\.|Think of (.+) as adding (\d+) to itself (\d+) times\.)').firstMatch(step);
    if (multMeansMatch != null) {
      final expr = multMeansMatch.group(1) ?? multMeansMatch.group(4);
      final num = multMeansMatch.group(2) ?? multMeansMatch.group(5);
      final times = multMeansMatch.group(3) ?? multMeansMatch.group(6);
      return 'Multiplikation ($expr) bedeutet, $num insgesamt $times-mal zu addieren.';
    }
    final groupsMatch = RegExp(r'Think of making (\d+) groups with (\d+) items in each group: (.+)').firstMatch(step);
    if (groupsMatch != null) {
      return 'Bilde ${groupsMatch.group(1)} Gruppen mit je ${groupsMatch.group(2)} Elementen: ${groupsMatch.group(3)}';
    }
    final countGroupsMatch = RegExp(r'Counting up all (\d+) groups of (\d+) gives (\d+)\.').firstMatch(step);
    if (countGroupsMatch != null) {
      return 'Zusammenzählen aller ${countGroupsMatch.group(1)} Gruppen von ${countGroupsMatch.group(2)} ergibt ${countGroupsMatch.group(3)}.';
    }
    final breakPartsMatch = RegExp(r'Break (\d+) into parts: (.+)').firstMatch(step);
    if (breakPartsMatch != null) {
      return 'Zerlege ${breakPartsMatch.group(1)} in Teile: ${breakPartsMatch.group(2)}';
    }
    final multTensOnesMatch = RegExp(r'Multiply tens: (.+), then ones: (.+)').firstMatch(step);
    if (multTensOnesMatch != null) {
      return 'Zehner multiplizieren: ${multTensOnesMatch.group(1)}, dann Einer: ${multTensOnesMatch.group(2)}';
    }
    final addPartsMatch = RegExp(r'Add the parts: (.+)').firstMatch(step);
    if (addPartsMatch != null) {
      return 'Teile addieren: ${addPartsMatch.group(1)}';
    }
    final finalProdMatch = RegExp(r'Final product: (\d+)\.').firstMatch(step);
    if (finalProdMatch != null) {
      return 'Endergebnis: ${finalProdMatch.group(1)}.';
    }
    final divSplitMatch = RegExp(r'(?:Division \((.+)\) means splitting a total of (\d+) into (\d+) equal groups\.|Imagine dividing (\d+) into (\d+) equal parts\.)').firstMatch(step);
    if (divSplitMatch != null) {
      final total = divSplitMatch.group(2) ?? divSplitMatch.group(4);
      final parts = divSplitMatch.group(3) ?? divSplitMatch.group(5);
      return 'Division bedeutet, $total in $parts gleiche Teile aufzuteilen.';
    }
    final divAskMatch = RegExp(r'Ask: How many times does (\d+) fit into (\d+)\?').firstMatch(step);
    if (divAskMatch != null) {
      return 'Frage: Wie oft passt ${divAskMatch.group(1)} in ${divAskMatch.group(2)}?';
    }
    final verifyMultMatch = RegExp(r'Verify with multiplication: (.+)').firstMatch(step);
    if (verifyMultMatch != null) {
      return 'Gegenprobe mit Multiplikation: ${verifyMultMatch.group(1)}';
    }
    final becauseDivMatch = RegExp(r'Because (.+) = (\d+), the result is (\d+)\.').firstMatch(step);
    if (becauseDivMatch != null) {
      return 'Weil ${becauseDivMatch.group(1)} = ${becauseDivMatch.group(2)} ist, lautet das Ergebnis ${becauseDivMatch.group(3)}.';
    }
    final divResultMatch = RegExp(r'Result: Each group receives (\d+)\.').firstMatch(step);
    if (divResultMatch != null) {
      return 'Ergebnis: Jede Gruppe erhält ${divResultMatch.group(1)}.';
    }
    if (step.contains('The square root symbol (√) asks:') ||
        step.contains('The square root (√') ||
        step.contains('Find the mystery number that gives') ||
        step.contains('Ask: What number times itself equals')) {
      return 'Die Quadratwurzel fragt: Welche Zahl mit sich selbst multipliziert ergibt den Wert?';
    }
    final testCandMatch = RegExp(r'(?:Test candidate:|Check:) (.+)').firstMatch(step);
    if (testCandMatch != null) {
      return 'Prüfung: ${testCandMatch.group(1)}';
    }
    final thereforeRootMatch = RegExp(r'(?:Therefore,|So the square root of \d+ is) (?:√\d+ = )?(\d+)\.').firstMatch(step);
    if (thereforeRootMatch != null) {
      return 'Somit ist das Ergebnis ${thereforeRootMatch.group(1)}.';
    }
    final sinceRootMatch = RegExp(r'(?:Since|Because) (.+) = (\d+), √\2 = (\d+)\.').firstMatch(step);
    if (sinceRootMatch != null) {
      return 'Weil ${sinceRootMatch.group(1)} = ${sinceRootMatch.group(2)} ist, gilt √${sinceRootMatch.group(2)} = ${sinceRootMatch.group(3)}.';
    }
    final squareExpMatch = RegExp(r'(?:The small ² exponent means "square" — multiply (\d+) by itself \(\1 × \1\)\.|Squaring \((\d+)²\) means multiplying \2 by itself\.|Multiply (\d+) by itself:? \3 × \3\.|Multiply (\d+) by itself \(\4 × \4\)\.|(\d+)² means multiplying \5 by itself.*)').firstMatch(step);
    if (squareExpMatch != null) {
      final b = squareExpMatch.group(1) ?? squareExpMatch.group(2) ?? squareExpMatch.group(3) ?? squareExpMatch.group(4) ?? squareExpMatch.group(5);
      return 'Das Quadrieren ($b²) bedeutet, $b mit sich selbst zu multiplizieren ($b × $b).';
    }
    final calcMatch = RegExp(r'(?:Calculation:|Final calculation:|Result:) (.+)').firstMatch(step);
    if (calcMatch != null) {
      return 'Rechnung: ${calcMatch.group(1)}';
    }
    final cubeExpMatch = RegExp(r'(?:The ³ exponent means "cube" — multiply (\d+) by itself 3 times.*|Cubing \((\d+)³\) means multiplying \2 by itself 3 times\.|Multiply (\d+) by itself 3 times.*|(\d+)³ means multiplying \4 by itself 3 times.*)').firstMatch(step);
    if (cubeExpMatch != null) {
      final b = cubeExpMatch.group(1) ?? cubeExpMatch.group(2) ?? cubeExpMatch.group(3) ?? cubeExpMatch.group(4);
      return 'Die Kubikzahl ($b³) bedeutet, $b 3-mal mit sich selbst zu multiplizieren ($b × $b × $b).';
    }
    final step1SquareMatch = RegExp(r'(?:Step 1 \(square\):|Step 1:|First,) (.+)').firstMatch(step);
    if (step1SquareMatch != null) {
      return 'Schritt 1: ${step1SquareMatch.group(1)}';
    }
    final step2CubeMatch = RegExp(r'(?:Step 2 \(cube\):|Step 2: Multiply|Then,) (.+)').firstMatch(step);
    if (step2CubeMatch != null) {
      return 'Schritt 2: ${step2CubeMatch.group(1)}';
    }
    final p4Match = RegExp(r'(\d+)⁴ means multiplying \1 by itself 4 times.*|Multiply (\d+) by itself 4 times.*').firstMatch(step);
    if (p4Match != null) {
      final b = p4Match.group(1) ?? p4Match.group(2);
      return '$b⁴ bedeutet, $b 4-mal mit sich selbst zu multiplizieren ($b × $b × $b × $b).';
    }
    final step2P4Match = RegExp(r'Step 2 \(power of 4\): (.+)').firstMatch(step);
    if (step2P4Match != null) {
      return 'Schritt 2 (4. Potenz): ${step2P4Match.group(1)}';
    }
    final compareMatch = RegExp(r'Comparing (\d+) and (\d+)\.').firstMatch(step);
    if (compareMatch != null) {
      return 'Vergleich von ${compareMatch.group(1)} und ${compareMatch.group(2)}.';
    }
    final greaterMatch = RegExp(r'(\d+) is greater because it comes further along the number line\.').firstMatch(step);
    if (greaterMatch != null) {
      return '${greaterMatch.group(1)} ist größer, weil es auf dem Zahlenstrahl weiter rechts liegt.';
    }
    final smallerMatch = RegExp(r'(\d+) is smaller because it is closer to 0\.').firstMatch(step);
    if (smallerMatch != null) {
      return '${smallerMatch.group(1)} ist kleiner, weil es näher bei 0 liegt.';
    }
    final evenDivideMatch = RegExp(r'Divide (\d+) by 2: \1 ÷ 2 = (\d+) with remainder (\d+)\.').firstMatch(step);
    if (evenDivideMatch != null) {
      return 'Teile ${evenDivideMatch.group(1)} durch 2: ${evenDivideMatch.group(1)} ÷ 2 = ${evenDivideMatch.group(2)} mit Rest ${evenDivideMatch.group(3)}.';
    }
    final evenNoRemainderMatch = RegExp(r'Since there is no remainder, (\d+) is Even\.').firstMatch(step);
    if (evenNoRemainderMatch != null) {
      return 'Da kein Rest bleibt, ist ${evenNoRemainderMatch.group(1)} Gerade.';
    }
    final oddRemainderMatch = RegExp(r'Since 1 is left over, (\d+) is Odd\.').firstMatch(step);
    if (oddRemainderMatch != null) {
      return 'Da 1 Rest bleibt, ist ${oddRemainderMatch.group(1)} Ungerade.';
    }
    return step;
  }
}
