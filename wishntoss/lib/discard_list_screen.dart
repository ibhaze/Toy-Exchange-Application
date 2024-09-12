import 'package:flutter/material.dart';

class DiscardListScreen extends StatelessWidget {
  const DiscardListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> discardedItems = [
      'Toy 1',
      'Toy 2',
      'Toy 3',
      'Toy 4',
      'Toy 5',
      'Toy 6',
      'Toy 7',
      'Toy 8',
      'Toy 9',
      'Toy 10',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Discard List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, 
            crossAxisSpacing: 15.0, 
            mainAxisSpacing: 15.0, 
            childAspectRatio: 3/4, 
          ),
          itemCount: discardedItems.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Center(
                child: Text(
                  discardedItems[index],
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}