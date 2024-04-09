import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gojo_renthub/Myproperty/bloc/property_bloc.dart';
import 'package:gojo_renthub/Myproperty/model/my_property_model.dart';
import 'package:gojo_renthub/Myproperty/repo/my_property_repo.dart';
import 'package:gojo_renthub/views/screens/bottom_navigation_pages/homepage.dart';
import 'package:image_picker/image_picker.dart';

class AddNewPropertyScreen extends StatefulWidget {
  const AddNewPropertyScreen({super.key});

  @override
  State<AddNewPropertyScreen> createState() => _AddNewPropertyScreenState();
}

class _AddNewPropertyScreenState extends State<AddNewPropertyScreen> {
  final MyPropertyRepo repo = MyPropertyRepo();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _noOfRoomsController = TextEditingController();
  final TextEditingController _catagoryController = TextEditingController();
  final TextEditingController _amenitiesController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _availableDatesController =
      TextEditingController();

  final ImagePicker _picker = ImagePicker();
  List<File> _images = [];

  Future<void> _pickImage() async {
    var image = await _picker.pickMultiImage();
    for (var imageList in image) {
      final _doKnow = File(imageList.path);
      _images.add(_doKnow);
    }
    setState(() {});
  }

  void _addProperty(User user) {
    final name = _nameController.text;
    final description = _descriptionController.text;
    final price = _priceController.text;
    final noOfRooms = _noOfRoomsController.text;
    final category = _catagoryController.text;
    final amenities = _amenitiesController.text;
    final location = _locationController.text;
    final availableDates = _availableDatesController.text;

    if (_images.isNotEmpty) {
      final property = AddPropertyEvent(
        property: MyProperty(
          status: 'waiting',
          reviews: const [],
          rating: 3.0,
          availability: true,
          imageUrl: const [],
          id: '',
          title: name,
          description: description,
          noOfRooms: noOfRooms,
          price: price,
          hostId: user.uid,
          category: category,
          address: location,
          availableDates: availableDates,
          amenities: [amenities],
          latitude: 3.3,
          longitude: 8.9,
          houseRules: '',
        ),
        userId: user.uid,
        images: _images,
      );
      context.read<PropertyBloc>().add(property);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  HomePage(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = repo.getCurrentUser();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  color: Colors.white,
                  height: 150,
                  child: _images.isNotEmpty
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _images.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Material(
                                elevation: 10,
                                // borderRadius: BorderRadius.circular(20),
                                child: Card(
                                  child: Image.file(
                                    _images[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Container(
                          height: 100,
                          width: 100,
                          color: Colors.grey,
                          child: const Icon(Icons.add_a_photo,
                              size: 40, color: Colors.white),
                        ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: ' Name',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: ' description',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: ' price',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _noOfRoomsController,
                decoration: InputDecoration(
                  labelText: ' no of rooms',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _catagoryController,
                decoration: InputDecoration(
                  labelText: ' catagory',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: ' location',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _availableDatesController,
                decoration: InputDecoration(
                  labelText: ' available dates',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _amenitiesController,
                decoration: InputDecoration(
                  labelText: ' amenities',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minWidth: MediaQuery.of(context).size.width,
                height: 60.0,
                color: Colors.black,
                onPressed: () => _addProperty(user!),
                child: const Text(
                  'Add Property',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
