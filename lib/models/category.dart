enum QuizCategory {
  food('Food', '🍽️'),
  numbers('Numbers', '🔢'),
  conversation('Conversation', '💬'),
  family('Family', '👨‍👩‍👧‍👦'),
  weather('Weather', '🌤️'),
  transportation('Transportation', '🚗'),
  animals('Animals', '🐾'),
  school('School', '🏫'),
  time('Time', '⏰'),
  general('General', '📚');

  final String displayName;
  final String emoji;

  const QuizCategory(this.displayName, this.emoji);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'displayName': displayName,
      'emoji': emoji,
    };
  }

  static QuizCategory fromMap(Map<String, dynamic> map) {
    return QuizCategory.values.firstWhere(
      (category) => category.name == map['name'],
      orElse: () => QuizCategory.general,
    );
  }
}
