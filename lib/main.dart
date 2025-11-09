import 'package:flutter/material.dart';
import 'pages/sign_in_page.dart';

void main() {
  runApp(const FillByTranslationApp());
}

class FillByTranslationApp extends StatelessWidget {
  const FillByTranslationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FillByTranslation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const SignInPage(),
    );
  }
}

