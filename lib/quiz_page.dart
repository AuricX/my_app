import 'package:flutter/material.dart';
import 'results_page.dart';
import 'models/question.dart';

import 'dart:math';

final List<Question> allQuestions = [
  Question(
    direction: 'ar-full_en-gap',
    sourceFull: 'أنا أدرس اللغة الإنجليزية كل يوم.',
    targetGap: 'I study ____ every day.',
    answer: 'English',
    options: ['Arabic', 'English', 'math', 'French'],
  ),
  Question(
    direction: 'ar-full_en-gap',
    sourceFull: 'هو يعيش بالقرب من الجامعة.',
    targetGap: 'He lives ____ the university.',
    answer: 'near',
    options: ['near', 'behind', 'under', 'above'],
  ),
  Question(
    direction: 'en-full_ar-gap',
    sourceFull: 'We are going to the market now.',
    targetGap: 'نحن ذاهبون إلى ____ الآن.',
    answer: 'السوق',
    options: ['البيت', 'السوق', 'المستشفى', 'المدرسة'],
  ),
  Question(
    direction: 'en-full_ar-gap',
    sourceFull: 'She drinks tea in the morning.',
    targetGap: 'هي تشرب ____ في الصباح.',
    answer: 'الشاي',
    options: ['الحليب', 'القهوة', 'الماء', 'الشاي'],
  ),
  Question(
    direction: 'ar-full_en-gap',
    sourceFull: 'الطقس جميل اليوم.',
    targetGap: 'The weather is ____ today.',
    answer: 'nice',
    options: ['cold', 'hot', 'nice', 'rainy'],
  ),
  Question(
    direction: 'en-full_ar-gap',
    sourceFull: 'He is reading a book.',
    targetGap: 'هو يقرأ ____.',
    answer: 'كتاب',
    options: ['جريدة', 'كتاب', 'قصة', 'مقالة'],
  ),
  Question(
    direction: 'ar-full_en-gap',
    sourceFull: 'السيارة سريعة جداً.',
    targetGap: 'The car is very ____.',
    answer: 'fast',
    options: ['slow', 'fast', 'expensive', 'old'],
  ),
  Question(
    direction: 'en-full_ar-gap',
    sourceFull: 'They are playing football.',
    targetGap: 'هم يلعبون ____.',
    answer: 'كرة القدم',
    options: ['كرة السلة', 'كرة القدم', 'تنس', 'سباحة'],
  ),
  Question(
    direction: 'ar-full_en-gap',
    sourceFull: 'الحديقة جميلة في الربيع.',
    targetGap: 'The garden is ____ in spring.',
    answer: 'beautiful',
    options: ['dry', 'beautiful', 'cold', 'wet'],
  ),
  Question(
    direction: 'en-full_ar-gap',
    sourceFull: 'My mother cooks delicious food.',
    targetGap: 'أمي تطبخ طعاماً ____.',
    answer: 'لذيذاً',
    options: ['لذيذاً', 'حاراً', 'بارداً', 'مالحاً'],
  ),
  Question(
    direction: 'ar-full_en-gap',
    sourceFull: 'الولد يذهب إلى المدرسة كل صباح.',
    targetGap: 'The boy goes to ____ every morning.',
    answer: 'school',
    options: ['work', 'school', 'home', 'park'],
  ),
  Question(
    direction: 'en-full_ar-gap',
    sourceFull: 'The sun rises in the east.',
    targetGap: 'تشرق الشمس في ____.',
    answer: 'الشرق',
    options: ['الغرب', 'الشرق', 'الشمال', 'الجنوب'],
  ),
  Question(
    direction: 'ar-full_en-gap',
    sourceFull: 'القط يأكل السمك.',
    targetGap: 'The cat eats ____.',
    answer: 'fish',
    options: ['meat', 'fish', 'bread', 'cheese'],
  ),
  Question(
    direction: 'en-full_ar-gap',
    sourceFull: 'She writes with a pen.',
    targetGap: 'هي تكتب بـ ____.',
    answer: 'قلم',
    options: ['قلم', 'ورقة', 'كتاب', 'ممحاة'],
  ),
  Question(
    direction: 'ar-full_en-gap',
    sourceFull: 'الطائرة تطير في السماء.',
    targetGap: 'The airplane flies in the ____.',
    answer: 'sky',
    options: ['sea', 'sky', 'ground', 'forest'],
  ),
];

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

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
    questions = _pickRandomQuestions(5);
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

  bool _containsArabic(String text) {
    return text.contains(RegExp(r'[\u0600-\u06FF]'));
  }

  TextDirection _getTextDirection(String text) {
    return _containsArabic(text) ? TextDirection.rtl : TextDirection.ltr;
  }

  Widget _buildSourceSentence() {
    final sourceFull = questions[currentIndex].sourceFull;
    final textDirection = _getTextDirection(sourceFull);

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

  Widget _buildTargetSentence() {
    final targetGap = questions[currentIndex].targetGap;
    final textDirection = _getTextDirection(targetGap);

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
                                ? (isCorrect
                                    ? Colors.green
                                    : Colors.red)
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
                      textDirection: _getTextDirection(selectedAnswer ?? '____'),
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

  Widget _buildOptions() {
    final options = questions[currentIndex].options;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: List.generate(options.length, (index) {
        final optionStr = options[index];
        final isSelected = selectedAnswer == optionStr;
        final textDirection = _getTextDirection(optionStr);

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
                          setState(() {
                            if (isSelected) {
                              selectedAnswer = null;
                            } else {
                              selectedAnswer = optionStr;
                            }
                          });
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
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
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
                  _buildSourceSentence(),
                  const SizedBox(height: 16),

                  AnimatedBuilder(
                    animation: _feedbackController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: 1.0 + (_feedbackController.value * 0.1),
                        child: child,
                      );
                    },
                    child: _buildTargetSentence(),
                  ),
                  const SizedBox(height: 24),

                  _buildOptions(),
                  const Spacer(),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: selectedAnswer == null || hasChecked
                              ? null
                              : _handleClear,
                          child: const Text('Clear'),
                        ),
                      ),
                      const SizedBox(width: 12),

                      Expanded(
                        flex: 2,
                        child: FilledButton(
                          onPressed: hasChecked ? _handleNext : _handleCheck,
                          child: Text(hasChecked ? 'Next' : 'Check'),
                        ),
                      ),
                    ],
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
