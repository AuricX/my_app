import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/level.dart';

/// Helper class to get display information for categories and levels
class QuizMetadataHelper {
  /// Get a color for a category
  static Color getCategoryColor(QuizCategory category) {
    switch (category) {
      case QuizCategory.food:
        return Colors.orange;
      case QuizCategory.numbers:
        return Colors.blue;
      case QuizCategory.conversation:
        return Colors.purple;
      case QuizCategory.family:
        return Colors.pink;
      case QuizCategory.weather:
        return Colors.lightBlue;
      case QuizCategory.transportation:
        return Colors.green;
      case QuizCategory.animals:
        return Colors.brown;
      case QuizCategory.school:
        return Colors.indigo;
      case QuizCategory.time:
        return Colors.teal;
      case QuizCategory.general:
        return Colors.grey;
    }
  }

  /// Get a color for a level based on difficulty
  static Color getLevelColor(QuizLevel level) {
    switch (level) {
      case QuizLevel.a1:
        return Colors.green;
      case QuizLevel.a2:
        return Colors.lightGreen;
      case QuizLevel.b1:
        return Colors.yellow.shade700;
      case QuizLevel.b2:
        return Colors.orange;
      case QuizLevel.c1:
        return Colors.deepOrange;
      case QuizLevel.c2:
        return Colors.red;
    }
  }

  /// Get an icon for a category
  static IconData getCategoryIcon(QuizCategory category) {
    switch (category) {
      case QuizCategory.food:
        return Icons.restaurant;
      case QuizCategory.numbers:
        return Icons.numbers;
      case QuizCategory.conversation:
        return Icons.chat;
      case QuizCategory.family:
        return Icons.family_restroom;
      case QuizCategory.weather:
        return Icons.wb_sunny;
      case QuizCategory.transportation:
        return Icons.directions_car;
      case QuizCategory.animals:
        return Icons.pets;
      case QuizCategory.school:
        return Icons.school;
      case QuizCategory.time:
        return Icons.access_time;
      case QuizCategory.general:
        return Icons.book;
    }
  }

  /// Get description for a level
  static String getLevelDescription(QuizLevel level) {
    switch (level) {
      case QuizLevel.a1:
        return 'Can understand and use familiar everyday expressions';
      case QuizLevel.a2:
        return 'Can communicate in simple and routine tasks';
      case QuizLevel.b1:
        return 'Can deal with most situations in travel';
      case QuizLevel.b2:
        return 'Can interact with native speakers fluently';
      case QuizLevel.c1:
        return 'Can express ideas fluently and spontaneously';
      case QuizLevel.c2:
        return 'Can understand virtually everything heard or read';
    }
  }
}
