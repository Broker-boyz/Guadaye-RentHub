import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gojo_renthub/Myproperty/model/my_property_model.dart';
import 'package:uuid/uuid.dart';

class MyPropertyRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // get user account type
  Future<String> getUserRole({required User user}) async {
    try {
      final userQuery = await _firestore
          .collection('users')
          .where('uid', isEqualTo: user.uid)
          .get();

      if (userQuery.docs.isEmpty) {
        return 'User not found';
      }

      final userData = userQuery.docs[0].data();
      if (!userData.containsKey('account-type')) {
        return 'Role not found';
      }

      return userData['account-type'];
    } catch (e) {
      print(e);
      throw Exception('Failed to retrieve user role');
    }
  }

  // upload images
  Future<List<String>> uploadImage(
      List<File> images, String userId, String propertyId) async {
    try {
      List<String> imageUrls = [];
      for (File image in images) {
        final String randomImagename = const Uuid().v4();
        Reference storageReference =
            _storage.ref().child('properties/$propertyId/$randomImagename');
        UploadTask uploadTask = storageReference.putFile(image);

        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
        String imageUrl = await taskSnapshot.ref.getDownloadURL();
        imageUrls.add(imageUrl);
      }
      return imageUrls;
    } catch (e) {
      debugPrint('Error while uploading image: $e');
      return [];
    }
  }

  // add a new property
  Future<void> addProperty(
      {required MyProperty property,
      required List<File> images,
      required String userId}) async {
    try {
      List<String> imageUrls = await uploadImage(images, userId, property.id);

      if (imageUrls.isNotEmpty) {
        CollectionReference properties = _firestore.collection('properties');
        final docRef = await properties.add({
          'title': property.title,
          'description': property.description,
          'noOfRooms': property.noOfRooms,
          'price': property.price,
          'category': property.category,
          'address': property.address,
          'availableDates': property.availableDates,
          'amenities': property.amenities,
          'status': 'waiting',
          'rating': 3.0,
          'reviews': const [],
          'availability': true,
          'isFavorite': false,
          'latitude': property.latitude,
          'longitude': property.longitude,
          'houseRules': property.houseRules,
          'city': property.address.split(',').elementAt(0),
          'sub-city': property.address.split(', ').elementAt(1),
        });
        await properties.doc(docRef.id).update({
          'id': docRef.id,
          'hostId': userId,
          'imageUrl': imageUrls,
        });
      } else {
        print('No images uploaded');
      }
    } catch (e) {
      print('Error while uploading new property: $e');
    }
  }

  // approve a property
  Future<void> approveProperty({required MyProperty property}) async {
    try {
      CollectionReference properties = _firestore.collection('properties');
      await properties.doc(property.id).update({'status': 'approved'});
    } catch (e) {
      print('Error while approving property: $e');
    }
  }

  // reject a property
  Future<void> rejectProperty({required MyProperty property}) async {
    try {
      CollectionReference properties = _firestore.collection('properties');
      await properties.doc(property.id).update({'status': 'rejected'});
      await properties.doc(property.id).delete();
    } catch (e) {
      print('Error while rejecting property: $e');
    }
  }

  // fetch properties
  Future<List<MyProperty>> loadMyProperties(String catagory) async {
    try {
      final rr = await _firestore
          .collection('properties')
          .where('category', isEqualTo: catagory)
          .get();
      final result = rr.docs.map((data) {
        return MyProperty.fromMap(data.data());
      }).toList();
      return result;
    } catch (e) {
      print('Error while fetching properties: $e');
      return [];
    }
  }

  // update a property
  Future<void> updateproperty({required MyProperty property}) async {
    try {
      CollectionReference properties = _firestore.collection('properties');
      await properties.doc(property.id).update({
        'title': property.title,
        'description': property.description,
        'noOfRooms': property.noOfRooms,
        'price': property.price,
        'category': property.category,
        'rating': property.rating,
        'review':property.reviews,
        'address': property.address,
        'availableDates': property.availableDates,
        'amenities': property.amenities,
      });
    } catch (e) {
      print('Error while updating property: $e');
    }
  }

  // add review
  Future<void> addReview({
    required MyProperty property,
    required String review,
    required double rating,
  }) async {
    try {
      User? user = getCurrentUser();
      CollectionReference localReview = _firestore.collection('reviews');
      await localReview.doc(property.id).set({
        'id': property.id,
        'review': review,
        'rating': rating,
        'userId': user!.uid,
        'date': Timestamp.now(),
      });
    } catch (e) {
      print('Error while adding review: $e');
    }
  }

  // Update Items
  void updateItem(String docId, bool value) async {
    DocumentReference ref = _firestore.collection('properties').doc(docId);
    ref.update({'availability': value});
  }

  // Adding Favorites

  Future<void> addFavorites({required MyProperty property}) async {
    try {
      User user = getCurrentUser()!;
      CollectionReference favCollection = _firestore.collection('favorites');
      await favCollection
          .doc(user.uid)
          .collection('myFavorites')
          .doc(property.id)
          .set({
        'title': property.title,
        'description': property.description,
        'noOfRooms': property.noOfRooms,
        'price': property.price,
        'category': property.category,
        'address': property.address,
        'availableDates': property.availableDates,
        'amenities': property.amenities,
        'status': property.status,
        'rating': property.rating,
        'reviews': property.reviews,
        'availability': property.availability,
        'isFavorite': property.isFavorite,
        'latitude': property.latitude,
        'longitude': property.longitude,
        'id': property.id,
        'hostId': property.hostId,
        'imageUrl': property.imageUrl,
        'houseRules': property.houseRules,
        'city': property.address.split(',').elementAt(0),
        'sub-city': property.address.split(', ').elementAt(1),
      });
      print('Adding succeeded');
    } catch (e) {
      print('Error while adding favorite: $e');
    }
  }

  // Remove Favorite
  Future<void> removeFavorites({required MyProperty property}) async {
    try {
     
      User user = getCurrentUser()!;
      CollectionReference favCollection = _firestore.collection('favorites');
      favCollection
          .doc(user.uid)
          .collection('myFavorites')
          .doc(property.id)
          .delete();
      print('Remove is succeeded');
    } catch (e) {
      print('Error while removing review: $e');
    }
  }
  // Loading favorites

  Future<List<MyProperty>> loadingFavorites() async {
    try {
      final favoriteReference = await _firestore
          .collection('favorites')
          .doc(getCurrentUser()!.uid)
          .collection('myFavorites')
          .get();

      final result = favoriteReference.docs
          .map((doc) => MyProperty.fromMap(doc.data()))
          .toList();
      return result;
    } on Exception catch (e) {
      print('Error while loading favorite: $e');
      return [];
    }
  }
}
