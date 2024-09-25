import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:wishntoss/services/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthService _authService = AuthService();
  final ImagePicker _picker = ImagePicker();
  File? _image;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    Map<String, String?> userDetails =
        await _authService.getCurrentUserDetails();
    if (userDetails.isNotEmpty) {
      setState(() {
        _usernameController.text = userDetails['displayName'] ?? '';
        _emailController.text = userDetails['email'] ?? '';
        _bioController.text = userDetails['bio'] ?? '';
      });
    }
  }

  // Function to pick image from gallery
  Future<void> _pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  void _saveProfile() async {
    String username = _usernameController.text;
    String bio = _bioController.text;

    try {
      // AuthService의 updateUserProfile 메서드를 호출하여 Firestore에 업데이트
      await _authService.updateUserProfile(displayName: username, bio: bio);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile saved successfully!')),
      );
    } catch (e) {
      print('Error saving profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Failed to save profile. Please try again.')),
      );
    }

    print('username: $username');
    print('Bio: $bio');
    print('Profile image: ${_image?.path}');

    setState(() {
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Profile",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              SizedBox(height: 30),
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Color(0xFFD9D9D9),
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child: _image == null
                        ? const Icon(
                            Icons.camera_alt,
                            size: 40,
                            color: Color(0xFFB22222),
                          )
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Name",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  _buildTextField(
                    hintText: 'Name',
                    controller: _usernameController,
                    icon: Icons.person,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Email",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  _buildTextField(
                    hintText: 'Email',
                    controller: _emailController,
                    icon: Icons.email,
                    inputType: TextInputType.datetime,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Bio",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  _buildTextField(
                    hintText: 'Bio',
                    controller: _bioController,
                    icon: Icons.edit,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xFFB22222)), // 배경색 설정
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white), // 텍스트 색상 설정
                  ),
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
    required String hintText,
    required TextEditingController controller,
    required IconData icon,
    TextInputType inputType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon, color: Color(0xFFB22222)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
        fillColor: Color(0xFFD9D9D9),
        filled: true,
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
