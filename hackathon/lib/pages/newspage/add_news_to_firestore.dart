import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class ImageData {
  final String url;
  final String title;
  final String description; // Added description field

  ImageData({required this.url, required this.title, required this.description});
}

class AddImageToFirestorePage extends StatefulWidget {
  @override
  State<AddImageToFirestorePage> createState() =>
      _AddImageToFirestorePageState();
}

class _AddImageToFirestorePageState extends State<AddImageToFirestorePage> {
  String? imageUrl; // Store URL of uploaded image
  TextEditingController imageTitleController = TextEditingController();
  TextEditingController imageDescriptionController = TextEditingController(); // Added controller for description input

  Future<File?> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource
            .gallery); // Use ImageSource.camera for capturing from camera
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  Future<String?> uploadImage(File file) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference =
          FirebaseStorage.instance.ref().child('uploads/$fileName');
      UploadTask uploadTask = storageReference.putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  void saveImageUrlToFirestore(
      String imageUrl, String title, String description) {
    FirebaseFirestore.instance.collection('images').add({
      'imageUrl': imageUrl,
      'title': title,
      'description': description, // Added description field
      'timestamp': DateTime.now(),
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Image details saved to Firestore'),
        duration: Duration(seconds: 2),
      ));
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to save image details: $error'),
        duration: Duration(seconds: 2),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Image to Firestore'),
      ),
      body: Column(
        children: [
          TextField(
            controller: imageTitleController,
            decoration: InputDecoration(
              labelText: 'Image Title',
            ),
          ),
          TextField(
            controller: imageDescriptionController,
            decoration: InputDecoration(
              labelText: 'Image Description', // Added description label
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              File? image = await pickImage();
              if (image != null) {
                String? url = await uploadImage(image);
                if (url != null) {
                  setState(() {
                    imageUrl = url;
                  });
                }
              }
            },
            child: Text('Select Image'),
          ),
          ElevatedButton(
            onPressed: () {
              if (imageUrl != null) {
                String title = imageTitleController.text;
                String description = imageDescriptionController.text; // Added description variable
                if (title.isNotEmpty) {
                  saveImageUrlToFirestore(imageUrl!, title, description); // Passed description to the method
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Please enter image title'),
                    duration: Duration(seconds: 2),
                  ));
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Please select an image'),
                  duration: Duration(seconds: 2),
                ));
              }
            },
            child: Text('Upload Image'),
          ),
        ],
      ),
    );
  }
}
