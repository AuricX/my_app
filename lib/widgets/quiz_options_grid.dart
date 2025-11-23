import 'package:flutter/material.dart';
import '../utils/text_direction_helper.dart';

class QuizOptionsGrid extends StatelessWidget {
  final List<String> options;
  final String? selectedAnswer;
  final bool hasChecked;
  final ValueChanged<String?> onAnswerSelected;
  final String correctAnswer;

  const QuizOptionsGrid({
    super.key,
    required this.options,
    this.selectedAnswer,
    required this.hasChecked,
    required this.onAnswerSelected,
    required this.correctAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: options.map((option) {
        final isSelected = selectedAnswer == option;
        final isCorrect = option == correctAnswer;
        final textDirection = TextDirectionHelper.getTextDirection(option);
        
        Color? tileColor;
        if (hasChecked && isSelected) {
          tileColor = isCorrect 
              ? Colors.green.withOpacity(0.1) 
              : Colors.red.withOpacity(0.1);
        }

        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          color: tileColor,
          elevation: isSelected ? 2 : 0,
          child: RadioListTile<String>(
            value: option,
            groupValue: selectedAnswer,
            onChanged: hasChecked ? null : (value) => onAnswerSelected(value),
            title: Directionality(
              textDirection: textDirection,
              child: Text(
                option,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: hasChecked && isSelected
                      ? (isCorrect ? Colors.green : Colors.red)
                      : null,
                ),
              ),
            ),
            activeColor: hasChecked
                ? (isCorrect ? Colors.green : Colors.red)
                : Theme.of(context).colorScheme.primary,
            controlAffinity: ListTileControlAffinity.leading,
          ),
        );
      }).toList(),
    );
  }
}
