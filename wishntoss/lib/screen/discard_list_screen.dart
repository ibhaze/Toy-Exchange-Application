import 'package:flutter/material.dart';
import 'discard_add_screen.dart';
import '../services/firebase_service.dart';

class DiscardListScreen extends StatelessWidget {
  const DiscardListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, String> discardedItems = {
      'Toy 1': 'assets/images/toy1.png',
      'Toy 2': 'assets/images/toy2.png',
      'Toy 3': 'assets/images/toy3.png',
      'Toy 4': 'assets/images/toy3.png',
      'Toy 5': 'assets/images/toy2.png',
      'Toy 6': 'assets/images/toy2.png',
      'Toy 7': 'assets/images/toy1.png',
    };

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
            childAspectRatio: 3 / 4,
          ),
          itemCount: discardedItems.length + 1,
          itemBuilder: (context, index) {
            if (index == discardedItems.length) {
              return GestureDetector(
                onTap: () {
                  // Move to DiscardAddScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DiscardAddScreen(),
                    ),
                  );
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 179, 179, 179),
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              );
            } else {
              String toyImage = discardedItems.values.elementAt(index);
              return Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 177, 177, 177),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.asset(
                        toyImage,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
