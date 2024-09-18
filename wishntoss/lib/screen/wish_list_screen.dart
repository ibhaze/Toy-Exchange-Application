import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../services/firebase_service.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  List<String> _imageUrls = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchImagesFromFirestore();
  }

  Future<void> _fetchImagesFromFirestore() async {
    try {
      List<String> imageUrls = await _firebaseService.fetchImageUrls();
      setState(() {
        _imageUrls = imageUrls;
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching images: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wish List'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 15.0,
                  childAspectRatio: 3 / 4,
                ),
                itemCount: _imageUrls.length,
                itemBuilder: (context, index) {
                  String imageUrl = _imageUrls[index];

                  return Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 177, 177, 177),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
