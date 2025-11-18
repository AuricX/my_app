import 'package:flutter/material.dart';

class LearningPage extends StatelessWidget {
  const LearningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning'),
        centerTitle: true,
      ),
      body: const SafeArea(
        child: Center(
          child: Text('Learning page — coming soon.'),
        ),
      ),
    );
  }
}
