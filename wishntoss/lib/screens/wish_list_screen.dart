import 'package:flutter/material.dart';
import 'package:wishntoss/widgets/detail_widget.dart';
import '../services/firebase_service.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  List<String> _imageUrls = [];
  List<String> _documentIds = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchImagesFromFirestore();
  }

  Future<void> _fetchImagesFromFirestore() async {
    try {
      var result = await _firebaseService
          .fetchImagesAndDocIds(); // Assuming this method exists
      setState(() {
        _imageUrls = result['imageUrls'] ?? []; // Provide an empty list if null
        _documentIds =
            result['documentIds'] ?? []; // Provide an empty list if null
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching images: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteImage(int index) async {
    try {
      await _firebaseService.deleteImageAndData(
          _imageUrls[index], _documentIds[index]);
      setState(() {
        _imageUrls.removeAt(index);
        _documentIds.removeAt(index);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image deleted successfully')),
      );
    } catch (e) {
      print('Error deleting image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete image')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wish List',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(25.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 15.0,
                  childAspectRatio: 5 / 4,
                ),
                itemCount: _imageUrls.length,
                itemBuilder: (context, index) {
                  String toyImage = _imageUrls[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailWidget(imageUrl: toyImage),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 177, 177, 177),
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30)),
                                  child: Image.network(
                                    toyImage,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 8,
                          bottom: 8,
                          child: GestureDetector(
                            onTap: () => _deleteImage(index),
                            child: const Icon(
                              Icons.favorite,
                              color: Color.fromARGB(255, 255, 255, 255),
                              size: 25,
                            ),
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
