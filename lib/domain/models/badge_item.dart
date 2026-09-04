import 'package:flutter/material.dart';

class BadgeItem {
  const BadgeItem({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.accentColor,
    required this.xpReward,
  });

  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color accentColor;
  final int xpReward;

  static const List<BadgeItem> allBadges = [
    BadgeItem(
      id: 'first_step',
      title: 'First Step',
      description: 'Complete your first math level',
      icon: Icons.star_rounded,
      accentColor: Color(0xFF10B981),
      xpReward: 50,
    ),
    BadgeItem(
      id: 'streak_5',
      title: 'Hot Streak',
      description: 'Reach a streak of 5 correct answers',
      icon: Icons.local_fire_department_rounded,
      accentColor: Color(0xFFF97316),
      xpReward: 100,
    ),
    BadgeItem(
      id: 'streak_15',
      title: 'Unstoppable',
      description: 'Reach a streak of 15 correct answers',
      icon: Icons.flash_on_rounded,
      accentColor: Color(0xFFEAB308),
      xpReward: 250,
    ),
    BadgeItem(
      id: 'century',
      title: 'Century Club',
      description: 'Solve 100 math problems correctly',
      icon: Icons.workspace_premium_rounded,
      accentColor: Color(0xFF3B82F6),
      xpReward: 300,
    ),
    BadgeItem(
      id: 'speed_demon',
      title: 'Speed Demon',
      description: 'Score 15+ in Time Attack mode',
      icon: Icons.timer_rounded,
      accentColor: Color(0xFF8B5CF6),
      xpReward: 200,
    ),
    BadgeItem(
      id: 'survivor',
      title: 'Survivor',
      description: 'Survive 15+ rounds in Endless Survival',
      icon: Icons.favorite_rounded,
      accentColor: Color(0xFFEC4899),
      xpReward: 250,
    ),
    BadgeItem(
      id: 'target_master',
      title: 'Target 24 Master',
      description: 'Solve 5 Target Number puzzles',
      icon: Icons.extension_rounded,
      accentColor: Color(0xFF06B6D4),
      xpReward: 200,
    ),
    BadgeItem(
      id: 'daily_champion',
      title: 'Daily Champion',
      description: 'Maintain a 3-day daily challenge streak',
      icon: Icons.calendar_today_rounded,
      accentColor: Color(0xFF14B8A6),
      xpReward: 300,
    ),
    BadgeItem(
      id: 'boss_slayer',
      title: 'Boss Slayer',
      description: 'Conquer any Boss Level',
      icon: Icons.shield_rounded,
      accentColor: Color(0xFFEF4444),
      xpReward: 400,
    ),
    BadgeItem(
      id: 'grand_master',
      title: 'Grand Master',
      description: 'Complete curriculum level 60',
      icon: Icons.military_tech_rounded,
      accentColor: Color(0xFFFFD700),
      xpReward: 1000,
    ),
  ];
}
