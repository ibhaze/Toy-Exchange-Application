import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DiscardAddScreen extends StatefulWidget {
  const DiscardAddScreen({super.key});

  @override
  _DiscardAddScreenState createState() => _DiscardAddScreenState();
}

class _DiscardAddScreenState extends State<DiscardAddScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _conditionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  // Take a picture with camera
  Future<void> _takePhoto() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });
    }
  }

  // Pick image from gallery
  Future<void> _pickImageFromGallery() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });
    }
  }

  // Show photo upload options
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

  // Create reusable text field widget
  Widget _buildTextField(
      {required String labelText, required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: const Color.fromARGB(255, 189, 189, 189),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _conditionController.dispose();
    _categoryController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discard Screen'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              // Show photo upload option
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
            ),
            // Reuse _buildTextField for each input field
            _buildTextField(labelText: 'Title', controller: _titleController),
            _buildTextField(
                labelText: 'Condition', controller: _conditionController),
            _buildTextField(
                labelText: 'Categories', controller: _categoryController),
            _buildTextField(labelText: 'Notes', controller: _notesController),
          ],
        ),
      ),
    );
  }
}

