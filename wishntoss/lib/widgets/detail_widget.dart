import 'package:flutter/material.dart';
import 'package:wishntoss/screens/chat_screen.dart';
import 'package:wishntoss/services/firebase_service.dart';

class DetailWidget extends StatefulWidget {
  final String imageUrl;
  final int rating;
  const DetailWidget({super.key, required this.imageUrl, this.rating = 1});

  @override
  State<DetailWidget> createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  late Future<Map<String, dynamic>> toyDetails;

  @override
  void initState() {
    super.initState();
    // Initialize fetching the toy details
    if (widget.imageUrl == null || widget.imageUrl.isEmpty) {
      // Handle the case where imageUrl is null or empty
      throw ArgumentError("imageUrl cannot be null or empty");
    }
    toyDetails = fetchDetails();
  }

  Future<Map<String, dynamic>> fetchDetails() async {
    try {
      return await FirebaseService().fetchImageDetails(widget.imageUrl);
    } catch (e) {
      // Handle the error or return a default value
      print('Failed to fetch toy details: $e');
      return {}; // Return an empty map as a fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Discard List',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: toyDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              var data = snapshot.data!;
              return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AspectRatio(
                        aspectRatio: 5 / 4,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            image: DecorationImage(
                              image: NetworkImage(widget.imageUrl),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        data['title'],
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Container(
                          width: double.infinity,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.calendar_month),
                              Text(" 2024-09-07",
                                  style: TextStyle(fontSize: 14))
                            ],
                          )),
                      SizedBox(height: 20),
                      Container(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text("Condition: ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              ...List.generate(5, (index) {
                                return Icon(
                                  index < widget.rating
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: index < widget.rating
                                      ? Colors.amber
                                      : Colors.grey,
                                );
                              }),
                            ],
                          )),
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black),
                            children: <TextSpan>[
                              const TextSpan(
                                text: 'Notes: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: data['notes']),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black),
                            children: <TextSpan>[
                              const TextSpan(
                                text: 'Categories: ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: data['categories']),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        child: Row(children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatScreen()));
                              },
                              icon: Icon(Icons.chat, color: Color(0xFFCC0036))),
                          SizedBox(width: 10),
                          Icon(Icons.delete, color: Color(0xFFCC0036))
                        ]),
                      ),
                    ],
                  ));
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
