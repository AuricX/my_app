class Question {
  final String direction;
  final String sourceFull;
  final String targetGap;
  final String answer;
  final List<String> options;

  Question({
    required this.direction,
    required this.sourceFull,
    required this.targetGap,
    required this.answer,
    required this.options,
  });
}
