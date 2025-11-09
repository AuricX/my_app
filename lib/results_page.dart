import 'package:flutter/material.dart';

class ResultsPage extends StatefulWidget {
  final int score;
  final int total;

  const ResultsPage({
    super.key,
    required this.score,
    required this.total,
  });

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> with TickerProviderStateMixin {
  late AnimationController _trophyController;
  late AnimationController _scoreController;
  late AnimationController _messageController;
  late AnimationController _buttonController;

  late Animation<double> _trophyScale;
  late Animation<double> _trophyRotation;
  late Animation<double> _scoreSlide;
  late Animation<double> _scoreFade;
  late Animation<double> _messageFade;
  late Animation<double> _buttonScale;

  @override
  void initState() {
    super.initState();
    
    // Trophy animation
    _trophyController = AnimationController(
      duration: const Duration(milliseconds: 450),
      vsync: this,
    );
    _trophyScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _trophyController, curve: Curves.elasticOut),
    );
    _trophyRotation = Tween<double>(begin: -0.5, end: 0.0).animate(
      CurvedAnimation(parent: _trophyController, curve: Curves.easeOut),
    );

    // Score animation
    _scoreController = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
    _scoreSlide = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(parent: _scoreController, curve: Curves.easeOut),
    );
    _scoreFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scoreController, curve: Curves.easeIn),
    );

    // Message animation
    _messageController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _messageFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _messageController, curve: Curves.easeIn),
    );

    // Button animation
    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _buttonScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.easeOut),
    );

    // Start staggered animations
    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 50));
    _trophyController.forward();
    
    await Future.delayed(const Duration(milliseconds: 200));
    _scoreController.forward();
    
    await Future.delayed(const Duration(milliseconds: 150));
    _messageController.forward();
    
    await Future.delayed(const Duration(milliseconds: 100));
    _buttonController.forward();
  }

  @override
  void dispose() {
    _trophyController.dispose();
    _scoreController.dispose();
    _messageController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  String _getMessage() {
    final percentage = (widget.score / widget.total) * 100;
    if (percentage == 100) {
      return 'Perfect! Outstanding work! 🌟';
    } else if (percentage >= 80) {
      return 'Excellent! Keep it up! 🎉';
    } else if (percentage >= 60) {
      return 'Good job! Practice makes perfect! 👍';
    } else if (percentage >= 40) {
      return 'Not bad! Keep learning! 💪';
    } else {
      return 'Keep trying! You\'ll get better! 📚';
    }
  }

  Color _getScoreColor(BuildContext context) {
    final percentage = (widget.score / widget.total) * 100;
    if (percentage >= 80) {
      return Colors.green;
    } else if (percentage >= 60) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final percentage = ((widget.score / widget.total) * 100).toStringAsFixed(0);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _trophyController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _trophyScale.value,
                      child: Transform.rotate(
                        angle: _trophyRotation.value,
                        child: Icon(
                          Icons.emoji_events,
                          size: 100,
                          color: _getScoreColor(context),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),

                FadeTransition(
                  opacity: _scoreFade,
                  child: Text(
                    'Quiz Complete!',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                ),
                const SizedBox(height: 16),

                AnimatedBuilder(
                  animation: _scoreController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _scoreSlide.value),
                      child: Opacity(
                        opacity: _scoreFade.value,
                        child: Card(
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              children: [
                                Text(
                                  'Your Score',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                                      ),
                                ),
                                const SizedBox(height: 16),
                                TweenAnimationBuilder<int>(
                                  tween: IntTween(begin: 0, end: widget.score),
                                  duration: const Duration(milliseconds: 600),
                                  curve: Curves.easeOut,
                                  builder: (context, value, child) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Text(
                                          '$value',
                                          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: _getScoreColor(context),
                                              ),
                                        ),
                                        Text(
                                          ' / ${widget.total}',
                                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                                              ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '$percentage%',
                                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                        color: _getScoreColor(context),
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),

                FadeTransition(
                  opacity: _messageFade,
                  child: Text(
                    _getMessage(),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 48),

                ScaleTransition(
                  scale: _buttonScale,
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    icon: const Icon(Icons.replay),
                    label: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                      child: Text(
                        'Play Again',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
