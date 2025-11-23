import 'package:flutter/material.dart';
import '../utils/text_direction_helper.dart';

class QuizOptionsGrid extends StatelessWidget {
  final List<String> options;
  final String? selectedAnswer;
  final bool hasChecked;
  final ValueChanged<String?> onAnswerSelected;

  const QuizOptionsGrid({
    super.key,
    required this.options,
    this.selectedAnswer,
    required this.hasChecked,
    required this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: List.generate(options.length, (index) {
        final optionStr = options[index];
        final isSelected = selectedAnswer == optionStr;
        final textDirection = TextDirectionHelper.getTextDirection(optionStr);

        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: Duration(milliseconds: 200 + (index * 50)),
          curve: Curves.easeOutBack,
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 120),
                curve: Curves.easeInOut,
                child: GestureDetector(
                  onTap: hasChecked
                      ? null
                      : () {
                          if (isSelected) {
                            onAnswerSelected(null);
                          } else {
                            onAnswerSelected(optionStr);
                          }
                        },
                  child: AnimatedScale(
                    scale: isSelected ? 1.05 : 1.0,
                    duration: const Duration(milliseconds: 120),
                    curve: Curves.easeInOut,
                    child: Chip(
                      label: Directionality(
                        textDirection: textDirection,
                        child: Text(
                          optionStr,
                          style: TextStyle(
                            color: isSelected
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.onSurface,
                            fontWeight:
                                isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                      backgroundColor: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.surface,
                      side: BorderSide(
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.outline,
                        width: isSelected ? 2 : 1,
                      ),
                      elevation: isSelected ? 4 : 1,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
