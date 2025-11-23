import 'package:flutter/material.dart';
import '../utils/text_direction_helper.dart';

class QuizSourceSentence extends StatelessWidget {
  final String sourceFull;

  const QuizSourceSentence({
    super.key,
    required this.sourceFull,
  });

  @override
  Widget build(BuildContext context) {
    final textDirection = TextDirectionHelper.getTextDirection(sourceFull);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Read:',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              sourceFull,
              textDirection: textDirection,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
