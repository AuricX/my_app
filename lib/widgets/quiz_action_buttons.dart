import 'package:flutter/material.dart';

class QuizActionButtons extends StatelessWidget {
  final String? selectedAnswer;
  final bool hasChecked;
  final VoidCallback onClear;
  final VoidCallback onCheck;
  final VoidCallback onNext;

  const QuizActionButtons({
    super.key,
    this.selectedAnswer,
    required this.hasChecked,
    required this.onClear,
    required this.onCheck,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: selectedAnswer == null || hasChecked ? null : onClear,
            child: const Text('Clear'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: FilledButton(
            onPressed: hasChecked ? onNext : onCheck,
            child: Text(hasChecked ? 'Next' : 'Check'),
          ),
        ),
      ],
    );
  }
}
