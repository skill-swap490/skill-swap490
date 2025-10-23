import 'package:flutter/material.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Browse Categories & Offers')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text('Search • Category Grid • Featured Offers (Connect)'),
        ],
      ),
    );
  }
}
