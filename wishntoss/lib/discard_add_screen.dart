import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//Discard Add Screen
class DiscardScreen extends StatefulWidget {
  const DiscardScreen({super.key});

  @override
  _DiscardScreenState createState() => _DiscardScreenState();
}

class _DiscardScreenState extends State<DiscardScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discard Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null
                ? const Text('No image selected.')
                : Image.file(
                    File(_image!.path),
                    width: 300,
                    height: 300,
                  ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _takePhoto,
              child: const Text('Take Photo with Camera'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImageFromGallery,
              child: const Text('Pick Image from Gallery'),
            ),
          ],
        ),
      ),
    );
  }
}