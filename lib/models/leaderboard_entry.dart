class LeaderboardEntry {
  final int id;
  final String studentName;
  final String quizName;
  final double percentage;

  LeaderboardEntry({
    required this.id,
    required this.studentName,
    required this.quizName,
    required this.percentage,
  });

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      id: json['id'],
      studentName: json['student_name'],
      quizName: json['quiz_name'],
      percentage: (json['percentage'] as num).toDouble(),
    );
  }
}
