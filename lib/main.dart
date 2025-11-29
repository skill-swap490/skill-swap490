import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Screens
import 'screens/intro.dart';
import 'screens/login.dart';
import 'screens/browse.dart';
import 'screens/messages.dart';
import 'screens/profile_setup.dart';
import 'screens/request_swap.dart';
import 'screens/lesson_details.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SkillSwap',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF7F9FC),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black87),
          titleTextStyle: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      home: const IntroScreen(),
      routes: {
        '/intro': (context) => const IntroScreen(),
        '/login': (context) => const LoginScreen(),
        '/browse': (context) => const BrowseScreen(),
        '/messages': (context) => const MessagesScreen(),
        '/profile-setup': (context) => const ProfileSetupScreen(),
        '/request-swap': (context) => const RequestSwapScreen(),
        '/lesson-details': (context) =>
            const LessonDetailsScreen(id: 'placeholder'),
      },
    );
  }
}
