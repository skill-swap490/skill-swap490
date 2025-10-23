import 'package:flutter/material.dart';
import 'screens/intro.dart';
import 'screens/browse.dart';
import 'screens/messages.dart';
import 'screens/profile_setup.dart';
import 'screens/request_swap.dart';
import 'screens/lesson_details.dart';

void main() {
  runApp(const SkillSwapApp());
}

class SkillSwapApp extends StatelessWidget {
  const SkillSwapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SkillSwap',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      routes: {
        '/': (_) => const IntroScreen(),
        '/browse': (_) => const BrowseScreen(),
        '/messages': (_) => const MessagesScreen(),
        '/onboarding': (_) => const ProfileSetupScreen(),
        '/request': (_) => const RequestSwapScreen(),
        '/lesson': (_) => const LessonDetailsScreen(id: 'demo'),
      },
    );
  }
}
