import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome')),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text('Learn skills • Share expertise • Safe & trusted'),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () => Navigator.pushNamed(context, '/browse'),
            child: const Text('Get Started'),
          ),
        ]),
      ),
    );
  }
}
