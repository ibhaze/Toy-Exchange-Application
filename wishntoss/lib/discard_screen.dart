import 'package:flutter/material.dart';

class DiscardScreen extends StatelessWidget {
  const DiscardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discard Screen'),
      ),
      body: Center(
        child: Text('This is the Discard Screen!'),
      ),
    );
  }
}