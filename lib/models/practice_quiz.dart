class PracticeQuestion {
  final int id;
  final String direction;
  final String sourceFull;
  final String targetGap;
  final String answer;
  final String? imageUrl;
  final List<String> options;

  PracticeQuestion({
    required this.id,
    required this.direction,
    required this.sourceFull,
    required this.targetGap,
    required this.answer,
    this.imageUrl,
    required this.options,
  });

  factory PracticeQuestion.fromJson(Map<String, dynamic> json) {
    return PracticeQuestion(
      id: json['id'],
      direction: json['direction'],
      sourceFull: json['source_full'],
      targetGap: json['target_gap'],
      answer: json['answer'],
      imageUrl: json['image_url'],
      options: List<String>.from(json['options']),
    );
  }
}

class PracticeQuiz {
  final int id;
  final int categoryId;
  final int levelId;
  final String name;
  final List<PracticeQuestion> questions;

  PracticeQuiz({
    required this.id,
    required this.categoryId,
    required this.levelId,
    required this.name,
    required this.questions,
  });

  factory PracticeQuiz.fromJson(Map<String, dynamic> json) {
    return PracticeQuiz(
      id: json['id'],
      categoryId: json['category_id'],
      levelId: json['level_id'],
      name: json['name'],
      questions: (json['questions'] as List)
          .map((q) => PracticeQuestion.fromJson(q))
          .toList(),
    );
  }
}
