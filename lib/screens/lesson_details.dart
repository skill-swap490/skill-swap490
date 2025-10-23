import 'package:flutter/material.dart';

class LessonDetailsScreen extends StatelessWidget {
  final String id;
  const LessonDetailsScreen({super.key, required this.id});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lesson Details #$id')),
      body: const Center(
        child: Text('Instructor bio • rating • availability • reviews'),
      ),
    );
  }
}
