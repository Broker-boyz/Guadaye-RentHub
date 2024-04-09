import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class VideoData {
  final String videoUrl;
  final String thumbnailUrl;
  final String title;

  VideoData({
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.title,
  });
}

class AddVideoToFirestorePage extends StatefulWidget {
  @override
  State<AddVideoToFirestorePage> createState() =>
      _AddVideoToFirestorePageState();
}

class _AddVideoToFirestorePageState extends State<AddVideoToFirestorePage> {
  String? videoUrl;
  String? thumbnailUrl;
  TextEditingController videoTitleController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickVideo() async {
    final XFile? pickedFile = await _picker.pickVideo(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  Future<String?> uploadFile(File file) async {
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

  Future<void> pickThumbnail() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File thumbnail = File(pickedFile.path);
      String? url = await uploadFile(thumbnail);
      if (url != null) {
        setState(() {
          thumbnailUrl = url;
        });
      }
    }
  }

  void saveVideoDetailsToFirestore() {
    if (videoUrl != null && thumbnailUrl != null) {
      String title = videoTitleController.text;
      if (title.isNotEmpty) {
        FirebaseFirestore.instance.collection('videos').add({
          'videoUrl': videoUrl!,
          'thumbnailUrl': thumbnailUrl!,
          'title': title,
          'timestamp': DateTime.now(),
        }).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Video details saved to Firestore'),
            duration: Duration(seconds: 2),
          ));
        }).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Failed to save video details: $error'),
            duration: Duration(seconds: 2),
          ));
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please enter video title'),
          duration: Duration(seconds: 2),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please select video and thumbnail'),
        duration: Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Video to Firestore'),
      ),
      body: Column(
        children: [
          TextField(
            controller: videoTitleController,
            decoration: InputDecoration(
              labelText: 'Video Title',
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              File? video = await pickVideo();
              if (video != null) {
                String? url = await uploadFile(video);
                if (url != null) {
                  setState(() {
                    videoUrl = url;
                  });
                }
              }
            },
            child: Text('Select Video'),
          ),
          ElevatedButton(
            onPressed: pickThumbnail,
            child: Text('Select Thumbnail'),
          ),
          ElevatedButton(
            onPressed: saveVideoDetailsToFirestore,
            child: Text('Upload Video'),
          ),
        ],
      ),
    );
  }
}
