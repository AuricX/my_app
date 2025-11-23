import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/level.dart';
import '../models/question.dart';
import '../data/quiz_data.dart';
import '../quiz_page.dart';

class QuizSelectionPage extends StatefulWidget {
  const QuizSelectionPage({super.key});

  @override
  State<QuizSelectionPage> createState() => _QuizSelectionPageState();
}

class _QuizSelectionPageState extends State<QuizSelectionPage> {
  QuizCategory? selectedCategory;
  QuizLevel? selectedLevel;

  List<Question> get filteredQuestions {
    if (selectedCategory == null && selectedLevel == null) {
      return allQuestions;
    } else if (selectedCategory != null && selectedLevel != null) {
      return getQuestionsByCategoryAndLevel(selectedCategory!, selectedLevel!);
    } else if (selectedCategory != null) {
      return getQuestionsByCategory(selectedCategory!);
    } else {
      return getQuestionsByLevel(selectedLevel!);
    }
  }

  Map<QuizCategory, List<Question>> get groupedQuestions {
    final Map<QuizCategory, List<Question>> grouped = {};
    for (var question in filteredQuestions) {
      grouped.putIfAbsent(question.category, () => []).add(question);
    }
    return grouped;
  }

  void _startQuiz(List<Question> questions) {
    if (questions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No questions available for this selection'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizPage(providedQuestions: questions),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Quiz'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: DropdownMenu<QuizCategory>(
                        label: const Text('Category'),
                        expandedInsets: EdgeInsets.zero,
                        initialSelection: selectedCategory,
                        onSelected: (category) {
                          setState(() {
                            selectedCategory = category;
                          });
                        },
                        dropdownMenuEntries: QuizCategory.values.map((category) {
                          return DropdownMenuEntry<QuizCategory>(
                            value: category,
                            label: category.displayName,
                            leadingIcon: Text(category.emoji),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: DropdownMenu<QuizLevel>(
                        label: const Text('Level'),
                        expandedInsets: EdgeInsets.zero,
                        initialSelection: selectedLevel,
                        onSelected: (level) {
                          setState(() {
                            selectedLevel = level;
                          });
                        },
                        dropdownMenuEntries: QuizLevel.values.map((level) {
                          return DropdownMenuEntry<QuizLevel>(
                            value: level,
                            label: level.code,
                            trailingIcon: Icon(
                              Icons.circle,
                              size: 12,
                              color: _getLevelColor(level),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                if (selectedCategory != null || selectedLevel != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextButton.icon(
                      onPressed: () {
                        setState(() {
                          selectedCategory = null;
                          selectedLevel = null;
                        });
                      },
                      icon: const Icon(Icons.clear),
                      label: const Text('Clear Filters'),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              '${filteredQuestions.length} question${filteredQuestions.length != 1 ? 's' : ''} available',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: groupedQuestions.length,
              itemBuilder: (context, index) {
                final category = groupedQuestions.keys.elementAt(index);
                final questions = groupedQuestions[category]!;

                return Card(
                  margin: const EdgeInsets.only(bottom: 12.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _getCategoryColor(category).withOpacity(0.2),
                      child: Text(
                        category.emoji,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                    title: Text(
                      category.displayName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${questions.length} question${questions.length != 1 ? 's' : ''}',
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => _startQuiz(questions),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: filteredQuestions.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () => _startQuiz(filteredQuestions),
              icon: const Icon(Icons.play_arrow),
              label: const Text('Start All'),
            )
          : null,
    );
  }

  Color _getCategoryColor(QuizCategory category) {
    switch (category) {
      case QuizCategory.food:
        return Colors.orange;
      case QuizCategory.numbers:
        return Colors.blue;
      case QuizCategory.conversation:
        return Colors.purple;
      case QuizCategory.family:
        return Colors.pink;
      case QuizCategory.weather:
        return Colors.lightBlue;
      case QuizCategory.transportation:
        return Colors.green;
      case QuizCategory.animals:
        return Colors.brown;
      case QuizCategory.school:
        return Colors.indigo;
      case QuizCategory.time:
        return Colors.teal;
      case QuizCategory.general:
        return Colors.grey;
    }
  }

  Color _getLevelColor(QuizLevel level) {
    switch (level) {
      case QuizLevel.a1:
        return Colors.green;
      case QuizLevel.a2:
        return Colors.lightGreen;
      case QuizLevel.b1:
        return Colors.yellow.shade700;
      case QuizLevel.b2:
        return Colors.orange;
      case QuizLevel.c1:
        return Colors.deepOrange;
      case QuizLevel.c2:
        return Colors.red;
    }
  }
}
