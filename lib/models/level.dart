enum QuizLevel {
  a1('A1', 'Beginner', 1),
  a2('A2', 'Elementary', 2),
  b1('B1', 'Intermediate', 3),
  b2('B2', 'Upper Intermediate', 4),
  c1('C1', 'Advanced', 5),
  c2('C2', 'Proficiency', 6);

  final String code;
  final String displayName;
  final int difficulty;

  const QuizLevel(this.code, this.displayName, this.difficulty);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'code': code,
      'displayName': displayName,
      'difficulty': difficulty,
    };
  }

  static QuizLevel fromMap(Map<String, dynamic> map) {
    return QuizLevel.values.firstWhere(
      (level) => level.name == map['name'],
      orElse: () => QuizLevel.a1,
    );
  }
}
