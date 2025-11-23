import 'category.dart';
import 'level.dart';

class Question {
  final String direction;
  final String sourceFull;
  final String targetGap;
  final String answer;
  final List<String> options;
  final QuizCategory category;
  final QuizLevel level;

  Question({
    required this.direction,
    required this.sourceFull,
    required this.targetGap,
    required this.answer,
    required this.options,
    required this.category,
    required this.level,
  });

  Map<String, dynamic> toMap() {
    return {
      'direction': direction,
      'source_full': sourceFull,
      'target_gap': targetGap,
      'answer': answer,
      'options': options,
      'category': category.toMap(),
      'level': level.toMap(),
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      direction: map['direction'] as String,
      sourceFull: map['source_full'] as String,
      targetGap: map['target_gap'] as String,
      answer: map['answer'] as String,
      options: List<String>.from(map['options'] as List),
      category: QuizCategory.fromMap(map['category'] as Map<String, dynamic>),
      level: QuizLevel.fromMap(map['level'] as Map<String, dynamic>),
    );
  }
}
