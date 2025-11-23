import 'package:flutter/material.dart';
import '../utils/text_direction_helper.dart';

class QuizTargetSentence extends StatelessWidget {
  final String targetGap;
  final String? selectedAnswer;
  final bool hasChecked;
  final bool isCorrect;

  const QuizTargetSentence({
    super.key,
    required this.targetGap,
    this.selectedAnswer,
    required this.hasChecked,
    required this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
    final textDirection = TextDirectionHelper.getTextDirection(targetGap);
    final parts = targetGap.split('____');

    return Card(
      elevation: 2,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fill in:',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Directionality(
              textDirection: textDirection,
              child: Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  if (parts.isNotEmpty)
                    Text(
                      parts[0],
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: selectedAnswer != null
                          ? (hasChecked
                              ? (isCorrect
                                  ? Colors.green.shade100
                                  : Colors.red.shade100)
                              : Theme.of(context).colorScheme.primaryContainer)
                          : Theme.of(context).colorScheme.surface,
                      border: Border.all(
                        color: selectedAnswer != null
                            ? (hasChecked
                                ? (isCorrect ? Colors.green : Colors.red)
                                : Theme.of(context).colorScheme.primary)
                            : Theme.of(context).colorScheme.outline,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      selectedAnswer ?? '____',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: selectedAnswer != null
                                ? (hasChecked
                                    ? (isCorrect ? Colors.green : Colors.red)
                                    : Theme.of(context).colorScheme.primary)
                                : Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                      textDirection: TextDirectionHelper.getTextDirection(
                          selectedAnswer ?? '____'),
                    ),
                  ),
                  if (parts.length > 1)
                    Text(
                      parts[1],
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
