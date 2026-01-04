class LearningQuestion {
  final int id;
  final String targetGap;
  final String answer;
  final String sourceFull;
  final String? imageUrl;

  LearningQuestion({
    required this.id,
    required this.targetGap,
    required this.answer,
    required this.sourceFull,
    this.imageUrl,
  });

  factory LearningQuestion.fromJson(Map<String, dynamic> json) {
    return LearningQuestion(
      id: json['id'],
      targetGap: json['target_gap'],
      answer: json['answer'],
      sourceFull: json['source_full'],
      imageUrl: json['image_url'],
    );
  }
}

class LearningQuiz {
  final int id;
  final int categoryId;
  final int levelId;
  final String name;
  final List<LearningQuestion> questions;

  LearningQuiz({
    required this.id,
    required this.categoryId,
    required this.levelId,
    required this.name,
    required this.questions,
  });

  factory LearningQuiz.fromJson(Map<String, dynamic> json) {
    return LearningQuiz(
      id: json['id'],
      categoryId: json['category_id'],
      levelId: json['level_id'],
      name: json['name'],
      questions: (json['questions'] as List)
          .map((q) => LearningQuestion.fromJson(q))
          .toList(),
    );
  }
}
