import 'package:flutter/material.dart';

class DiscardListScreen extends StatelessWidget {
  const DiscardListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //list of toys
    final List<String> discardedItems = [
      'Toy 1',
      'Toy 2',
      'Toy 3',
      'Toy 4',
      'Toy 5',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Discard List'),
      ),
      body: ListView.builder(
        itemCount: discardedItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(discardedItems[index]),
          );
        },
      ),
    );
  }
}
