import 'package:flutter/material.dart';

class RequestSwapScreen extends StatelessWidget {
  const RequestSwapScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Request Swap')),
      body: const Center(
        child: Text('What You Offer vs What You Want • Confirm'),
      ),
    );
  }
}
