import 'package:flutter/material.dart';

class DetailWidget extends StatefulWidget {
  final String imageUrl;
  final int rating;
  const DetailWidget({super.key, required this.imageUrl, this.rating = 1});

  @override
  State<DetailWidget> createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail View'),
      ),
      body: Align(
        alignment: const Alignment(0.0, -0.1),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Title",
              style: TextStyle(fontSize: 20),
            ),
            const Text(
              "Date",
              style: TextStyle(fontSize: 20),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Condition: ", style: TextStyle(fontSize: 20)),
                ...List.generate(5, (index) {
                  return Icon(
                    index < widget.rating ? Icons.star : Icons.star_border,
                    color: index < widget.rating ? Colors.amber : Colors.grey,
                  );
                }),
              ],
            ),
            const Text(
              "Notes",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
