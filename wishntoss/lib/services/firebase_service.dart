import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Upload image to Firebase Storage and store metadata in Firestore
  Future<void> uploadImageAndData(
      File image, Map<String, dynamic> additionalData) async {
    try {
      // 1. Upload image to Firebase Storage
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final storageRef = _storage.ref().child('uploads/$fileName.jpg');

      UploadTask uploadTask = storageRef.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();

      // 2. Store metadata in Firestore
      final dataToStore = {
        'imageURL': downloadURL, // Download URL from Firebase Storage
        ...additionalData,
        'timestamp': FieldValue.serverTimestamp(), // Upload time
      };

      await _firestore.collection('discard_items').add(dataToStore);

      print('Data stored successfully in Firestore:');
      print(dataToStore);
    } catch (e) {
      if (e is FirebaseException && e.code == 'object-not-found') {
        // Storage-specific error
        print(
            'Error: No object exists at the specified path in Firebase Storage');
      } else {
        // General error handling
        print('Error during upload: $e');
      }
      throw e;
    }
  }

  // FetchImageUrls from database
  Future<List<String>> fetchImageUrls() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('discard_items').get();

      List<String> imageUrls = querySnapshot.docs.map((doc) {
        return doc['imageURL'] as String;
      }).toList();

      return imageUrls;
    } catch (e) {
      print('Error fetching image URLs: $e');
      throw e;
    }
  }

  Future<void> uploadProfile(File profileImage, String userId,
      {required String username,
      required String email,
      required String bio}) async {
    try {
      // 1. Upload profile image to Firebase Storage
      String fileName =
          'profile_$userId'; // Use the user ID to name the profile image
      final storageRef = _storage.ref().child('profile_images/$fileName.jpg');

      UploadTask uploadTask = storageRef.putFile(profileImage);
      TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();

      // 2. Store profile metadata in Firestore
      final profileData = {
        'username': username,
        'email': email,
        'bio': bio,
        'profileImageURL': downloadURL,
        'updatedAt': FieldValue.serverTimestamp(),
      };

      // Store or update the user profile in the 'users' collection
      await _firestore.collection('users').doc(userId).set(profileData);

      print('Profile updated successfully in Firestore:');
      print(profileData);
    } catch (e) {
      print('Error uploading profile: $e');
      throw e;
    }
  }

  // Delete image from Firebase Storage and metadata from Firestore
  Future<void> deleteImageAndData(String imageUrl, String documentId) async {
    try {
      // 1. Delete the image from Firebase Storage
      Reference storageRef = _storage.refFromURL(imageUrl);
      await storageRef.delete();

      // 2. Delete the metadata from Firestore
      await _firestore.collection('discard_items').doc(documentId).delete();

      print('Image and data deleted successfully');
    } catch (e) {
      print('Error deleting image and data: $e');
      throw e;
    }
  } // Fetch image URLs and their document IDs from Firestore

  Future<Map<String, List<String>>> fetchImagesAndDocIds() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('discard_items').get();

      List<String> imageUrls = [];
      List<String> documentIds = [];

      for (var doc in querySnapshot.docs) {
        imageUrls.add(doc['imageURL'] as String);
        documentIds.add(doc.id);
      }

      return {'imageUrls': imageUrls, 'documentIds': documentIds};
    } catch (e) {
      print('Error fetching image URLs and document IDs: $e');
      throw e;
    }
  }
}
