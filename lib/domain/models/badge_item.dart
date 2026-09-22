import 'package:flutter/material.dart';

class BadgeItem {
  const BadgeItem({
    required this.id,
    required this.icon,
    required this.accentColor,
    required this.xpReward,
  });

  final String id;
  final IconData icon;
  final Color accentColor;
  final int xpReward;

  static const List<BadgeItem> allBadges = [
    BadgeItem(
      id: 'first_step',
      icon: Icons.star_rounded,
      accentColor: Color(0xFF10B981),
      xpReward: 50,
    ),
    BadgeItem(
      id: 'streak_5',
      icon: Icons.local_fire_department_rounded,
      accentColor: Color(0xFFF97316),
      xpReward: 100,
    ),
    BadgeItem(
      id: 'streak_15',
      icon: Icons.flash_on_rounded,
      accentColor: Color(0xFFEAB308),
      xpReward: 250,
    ),
    BadgeItem(
      id: 'century',
      icon: Icons.workspace_premium_rounded,
      accentColor: Color(0xFF3B82F6),
      xpReward: 300,
    ),
    BadgeItem(
      id: 'speed_demon',
      icon: Icons.timer_rounded,
      accentColor: Color(0xFF8B5CF6),
      xpReward: 200,
    ),
    BadgeItem(
      id: 'survivor',
      icon: Icons.favorite_rounded,
      accentColor: Color(0xFFEC4899),
      xpReward: 250,
    ),
    BadgeItem(
      id: 'target_master',
      icon: Icons.extension_rounded,
      accentColor: Color(0xFF06B6D4),
      xpReward: 200,
    ),
    BadgeItem(
      id: 'daily_champion',
      icon: Icons.calendar_today_rounded,
      accentColor: Color(0xFF14B8A6),
      xpReward: 300,
    ),
    BadgeItem(
      id: 'boss_slayer',
      icon: Icons.shield_rounded,
      accentColor: Color(0xFFEF4444),
      xpReward: 400,
    ),
    BadgeItem(
      id: 'grand_master',
      icon: Icons.military_tech_rounded,
      accentColor: Color(0xFFFFD700),
      xpReward: 1000,
    ),
  ];
}

