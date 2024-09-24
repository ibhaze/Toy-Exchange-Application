import 'dart:io';
import 'package:flutter/material.dart';
import '../services/firebase_service.dart';
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
  final TextEditingController _notesController = TextEditingController();
  final FirebaseService _firebaseService = FirebaseService();

  // Condition options
  String? _selectedCondition;
  List<String> _conditions = ['New', 'Used', 'Good Condition', 'Bad Condition'];

  // Category options with multiple selection
  List<String> _categories = [
    'Toys',
    'Clothing',
    'Electronics',
    'Books',
    'Furniture'
  ];
  List<String> _selectedCategories = [];

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

// Create reusable text field widget with Material design style
  Widget _buildTextField({
    required String labelText,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: controller,
            minLines: 1,
            maxLines: 3,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              hintText: labelText,
              hintStyle: const TextStyle(
                color: Color(0x66000000),
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: const Color(0xFFD9D9D9),
              contentPadding: const EdgeInsets.all(16.0),
            ),
            scrollPhysics: const BouncingScrollPhysics(),
          ),
        ],
      ),
    );
  }

// Condition dropdown widget with Title
  Widget _buildConditionDropdown() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Condition",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                hintText: 'Select Condition',
                hintStyle: const TextStyle(
                  color: Color(0x66000000),
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color(0xFFD9D9D9),
                contentPadding: const EdgeInsets.all(16.0),
              ),
              value: _selectedCondition,
              items: _conditions.map((String condition) {
                return DropdownMenuItem<String>(
                  value: condition,
                  child: Text(
                    condition,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedCondition = newValue!;
                });
              },
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 24,
              iconEnabledColor: Colors.black,
              dropdownColor: const Color(0xFFD9D9D9),
            ),
          ),
        ],
      ),
    );
  }

// Category multiple selection widget
  Widget _buildCategorySelection() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Categories',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: _categories.map((String category) {
                return CheckboxListTile(
                  title: Text(
                    category,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  value: _selectedCategories.contains(category),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        _selectedCategories.add(category);
                      } else {
                        _selectedCategories.remove(category);
                      }
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Colors.black,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // Saving data
  Future<void> _saveData() async {
    if (_image != null) {
      String title = _titleController.text;
      String condition = _selectedCondition ?? 'No Condition';
      String notes = _notesController.text;

      // Upload images and texts to Firebase
      try {
        await _firebaseService.uploadImageAndData(
          File(_image!.path),
          {
            'title': title,
            'condition': condition,
            'categories': _selectedCategories.join(
                ', '), // Store selected categories as comma-separated string
            'notes': notes,
          },
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data uploaded successfully!')),
        );
        _titleController.clear();
        _notesController.clear();
        setState(() {
          _image = null;
          _selectedCondition = null;
          _selectedCategories.clear();
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload an image!')),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
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
              child: AspectRatio(
                aspectRatio: 5 / 4,
                child: Container(
                  margin: const EdgeInsets.all(40.0),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 255, 46, 46),
                        Color.fromARGB(255, 252, 141, 141)
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Center(
                    child: _image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: Image.file(
                              File(_image!.path),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
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
            ),

            // Reuse _buildTextField for each input field
            _buildTextField(labelText: 'Title', controller: _titleController),
            _buildConditionDropdown(), // Drop down for condition
            _buildCategorySelection(), // Checkbox list for category selection
            _buildTextField(labelText: 'Notes', controller: _notesController),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveData, // Save data function
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFCC0036),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
