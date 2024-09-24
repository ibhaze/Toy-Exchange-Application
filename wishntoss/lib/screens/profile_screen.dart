import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  // Function to pick image from gallery
  Future<void> _pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  // Function to save profile information
  void _saveProfile() {
    String username = _usernameController.text;
    String email = _emailController.text;
    String bio = _bioController.text;

    // You can now use the data as needed
    print('username: $username');
    print('Email: $email');
    print('Bio: $bio');
    print('Profile image: ${_image?.path}');

    //    Store data in firebase
    //   await FirebaseFirestore.instance.collection('profiles').add({
    //   'name': name,
    //   'birthday': birthday,
    //   'address': address,
    //   'contact': contact,
    //   'profileImage': _image?.path,
    // });

    // Clear fields after saving (optional)
    _usernameController.clear();
    _emailController.clear();
    _bioController.clear();
    setState(() {
      _image = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile saved successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child: _image == null
                        ? const Icon(
                            Icons.camera_alt,
                            size: 40,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField(
                labelText: 'Name',
                controller: _usernameController,
                icon: Icons.person,
              ),
              const SizedBox(height: 10),
              _buildTextField(
                labelText: 'Email',
                controller: _emailController,
                icon: Icons.email,
                inputType: TextInputType.datetime,
              ),
              const SizedBox(height: 10),
              _buildTextField(
                labelText: 'Bio',
                controller: _bioController,
                icon: Icons.edit,
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  child: const Text('Save Profile'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // TextField builder
  Widget _buildTextField({
    required String labelText,
    required TextEditingController controller,
    required IconData icon,
    TextInputType inputType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    super.dispose();
  }
}
