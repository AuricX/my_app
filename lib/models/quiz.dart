import 'question.dart';

class Quiz {
  final List<Question> questions;
  final String title;

  Quiz({
    required this.questions,
    this.title = 'Language Quiz',
  });
}
