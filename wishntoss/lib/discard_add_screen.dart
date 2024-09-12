import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//Discard Add Screen
class DiscardAddScreen extends StatefulWidget {
  const DiscardAddScreen({super.key});

  @override
  _DiscardAddScreenState createState() => _DiscardAddScreenState();
}

class _DiscardAddScreenState extends State<DiscardAddScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  // take a picture with camera
  Future<void> _takePhoto() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });
    }
  }

  // take picture from gallery
  Future<void> _pickImageFromGallery() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });
    }
  }

  // manage photo upload option
  void _showUploadOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take Photo'),
                onTap: () {
                  Navigator.of(context).pop();
                  _takePhoto();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImageFromGallery();
                },
              ),
            ],
          ),
        );
      },
    );
  }

   @override
  Widget build(BuildContext context) {
    // 1번 박스 이후에 나타낼 텍스트 리스트
    final List<String> uploadList = [
      'Title',
      'Condition',
      'Categories',
      'Notes'
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Discard Screen'),
      ),
      body: Column(
        children: List.generate(5, (index) {
          if (index == 0) {
            return GestureDetector(
              // show photo upload option
              onTap: () {
                _showUploadOptions(context);
              },
              child: Container(
                height: 200,
                margin: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 169, 169, 169),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: _image != null
                      ? ClipRRect(
                          child: Image.file(
                            File(_image!.path),
                            width: 150,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.upload,
                              size: 30,
                              color: Colors.white,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Upload Photo',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            );
          } else {
            return Container(
              height: 50,
              margin: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 189, 189, 189),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  uploadList[index - 1], 
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}
