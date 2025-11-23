import 'question.dart';
import 'category.dart';
import 'level.dart';

class Quiz {
  final List<Question> questions;
  final String title;
  final QuizCategory? category;
  final QuizLevel? level;

  Quiz({
    required this.questions,
    this.title = 'Language Quiz',
    this.category,
    this.level,
  });

  int get totalQuestions => questions.length;

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'questions': questions.map((q) => q.toMap()).toList(),
      'category': category?.toMap(),
      'level': level?.toMap(),
    };
  }

  factory Quiz.fromMap(Map<String, dynamic> map) {
    return Quiz(
      title: map['title'] as String? ?? 'Language Quiz',
      questions: (map['questions'] as List)
          .map((q) => Question.fromMap(q as Map<String, dynamic>))
          .toList(),
      category: map['category'] != null
          ? QuizCategory.fromMap(map['category'] as Map<String, dynamic>)
          : null,
      level: map['level'] != null
          ? QuizLevel.fromMap(map['level'] as Map<String, dynamic>)
          : null,
    );
  }
}
