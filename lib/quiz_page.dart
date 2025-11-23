import 'package:flutter/material.dart';
import 'dart:math';

import 'results_page.dart';
import 'models/question.dart';
import 'data/quiz_data.dart';
import 'widgets/quiz_source_sentence.dart';
import 'widgets/quiz_target_sentence.dart';
import 'widgets/quiz_options_grid.dart';
import 'widgets/quiz_action_buttons.dart';

class QuizPage extends StatefulWidget {
  final List<Question>? providedQuestions;
  
  const QuizPage({super.key, this.providedQuestions});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> with TickerProviderStateMixin {
  late List<Question> questions;
  int currentIndex = 0;
  int score = 0;
  String? selectedAnswer;
  bool hasChecked = false;
  bool isCorrect = false;

  late AnimationController _slideController;
  late AnimationController _feedbackController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    questions = widget.providedQuestions ?? _pickRandomQuestions(5);
    _initializeAnimations();
  }

  List<Question> _pickRandomQuestions(int count) {
    final rand = Random();
    final pool = List<Question>.from(allQuestions);
    pool.shuffle(rand);
    return pool.take(count).toList();
  }

  void _initializeAnimations() {
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _feedbackController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeIn,
    ));

    _slideController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _feedbackController.dispose();
    super.dispose();
  }

  void _handleAnswerSelected(String? answer) {
    setState(() {
      selectedAnswer = answer;
    });
  }

  void _handleCheck() {
    if (selectedAnswer == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(milliseconds: 1400),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(bottom: 80, left: 16, right: 16),
          content: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
            child: const Text('Please select an answer first!'),
          ),
        ),
      );
      return;
    }

    final correctAnswer = questions[currentIndex].answer;
    setState(() {
      hasChecked = true;
      isCorrect = selectedAnswer == correctAnswer;
      if (isCorrect) {
        score++;
      }
    });

    _feedbackController.forward().then((_) {
      _feedbackController.reverse();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 1400),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 80, left: 16, right: 16),
        content: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
          child: Row(
          children: [
            Icon(
              isCorrect ? Icons.check_circle : Icons.cancel,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                isCorrect ? 'Correct!' : 'Try again! The answer was: $correctAnswer',
              ),
            ),
          ],
          ),
        ),
        backgroundColor: isCorrect ? Colors.green : Colors.red,
      ),
    );
  }

  void _handleClear() {
    setState(() {
      selectedAnswer = null;
    });
  }

  void _handleNext() {
    if (currentIndex < questions.length - 1) {
      _slideController.reverse().then((_) {
        setState(() {
          currentIndex++;
          selectedAnswer = null;
          hasChecked = false;
          isCorrect = false;
        });
        _slideController.forward();
      });
    } else {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (context, animation, secondaryAnimation) => ResultsPage(
            score: score,
            total: questions.length,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  ),
                ),
                child: child,
              ),
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                '${currentIndex + 1}/${questions.length}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  QuizSourceSentence(
                    sourceFull: questions[currentIndex].sourceFull,
                  ),
                  const SizedBox(height: 16),

                  if (questions[currentIndex].imageUrl != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        questions[currentIndex].imageUrl!,
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 150,
                            color: Theme.of(context).colorScheme.surfaceVariant,
                            child: const Icon(Icons.image_not_supported, size: 48),
                          );
                        },
                      ),
                    ),
                  if (questions[currentIndex].imageUrl != null)
                    const SizedBox(height: 16),

                  AnimatedBuilder(
                    animation: _feedbackController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: 1.0 + (_feedbackController.value * 0.1),
                        child: child,
                      );
                    },
                    child: QuizTargetSentence(
                      targetGap: questions[currentIndex].targetGap,
                      selectedAnswer: selectedAnswer,
                      hasChecked: hasChecked,
                      isCorrect: isCorrect,
                    ),
                  ),
                  const SizedBox(height: 24),

                  QuizOptionsGrid(
                    options: questions[currentIndex].options,
                    selectedAnswer: selectedAnswer,
                    hasChecked: hasChecked,
                    onAnswerSelected: _handleAnswerSelected,
                    correctAnswer: questions[currentIndex].answer,
                  ),
                  const Spacer(),

                  QuizActionButtons(
                    selectedAnswer: selectedAnswer,
                    hasChecked: hasChecked,
                    onClear: _handleClear,
                    onCheck: _handleCheck,
                    onNext: _handleNext,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
