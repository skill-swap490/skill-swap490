import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Messages / Active Swaps')),
      body: const Center(child: Text('Tabs: Active • Pending • Completed')),
    );
  }
}
