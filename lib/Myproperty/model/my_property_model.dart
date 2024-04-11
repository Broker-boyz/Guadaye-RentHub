// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class MyProperty extends Equatable {
  final String id;
  final String title;
  final String description;
  final String noOfRooms;
  final int price;
  final String hostId;
  final List<String> imageUrl;
  final String category;
  final String address;
  final String status;
  final String availableDates; // needs modification in the future
  final double rating;
  final List<String> amenities;
  final List<String> reviews;
  final bool availability;
  final double latitude;
  final double longitude;
  final String houseRules;
  final String city;
  final String subCity;

  const MyProperty({
    required this.id,
    required this.title,
    required this.description,
    required this.noOfRooms,
    required this.price,
    required this.hostId,
    required this.imageUrl,
    required this.category,
    required this.address,
    required this.status,
    required this.availableDates,
    required this.rating,
    required this.amenities,
    required this.reviews,
    required this.availability,
    required this.latitude,
    required this.longitude,
    required this.houseRules,
    required this.city,
    required this.subCity,
  });

  MyProperty copyWith({
    String? id,
    String? title,
    String? description,
    String? noOfRooms,
    int? price,
    String? hostId,
    List<String>? imageUrl,
    String? category,
    String? address,
    String? status,
    String? availableDates,
    double? rating,
    List<String>? amenities,
    List<String>? reviews,
    bool? availability,
    double? latitude,
    double? longitude,
    String? houseRules,
    String? city,
    String? subCity,
  }) {
    return MyProperty(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      noOfRooms: noOfRooms ?? this.noOfRooms,
      price: price ?? this.price,
      hostId: hostId ?? this.hostId,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      address: address ?? this.address,
      status: status ?? this.status,
      availableDates: availableDates ?? this.availableDates,
      rating: rating ?? this.rating,
      amenities: amenities ?? this.amenities,
      reviews: reviews ?? this.reviews,
      availability: availability ?? this.availability,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      houseRules: houseRules ?? this.houseRules,
      city: city ?? this.city,
      subCity: subCity ?? this.subCity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'noOfRooms': noOfRooms,
      'price': price,
      'hostId': hostId,
      'imageUrl': imageUrl,
      'category': category,
      'address': address,
      'status': status,
      'availableDates': availableDates,
      'rating': rating,
      'amenities': amenities,
      'reviews': reviews,
      'availability': availability,
      'latitude': latitude,
      'longitude': longitude,
      'houseRules': houseRules,
      'city': city,
      'sub-city': subCity,
    };
  }

  factory MyProperty.fromMap(Map<String, dynamic> map) {
    return MyProperty(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      noOfRooms: map['noOfRooms'] as String,
      price: map['price'] as int,
      hostId: map['hostId'] as String,
      imageUrl: List<String>.from((map['imageUrl'] ?? [])),
      category: map['category'] as String,
      address: map['address'] as String,
      status: map['status'] as String,
      availableDates: map['availableDates'] as String,
      rating: map['rating'] as double,
      amenities: List<String>.from((map['amenities'] ?? [])),
      reviews: List<String>.from((map['reviews'] ?? [])),
      availability: map['availability'] as bool,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      houseRules: map['houseRules'] as String,
      city: map['city'] as String,
      subCity: map['sub-city'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MyProperty.fromJson(String source) =>
      MyProperty.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      title,
      description,
      noOfRooms,
      price,
      hostId,
      imageUrl,
      category,
      address,
      status,
      availableDates,
      rating,
      amenities,
      reviews,
      availability,
      latitude,
      longitude,
      houseRules,
      city,
      subCity,
    ];
  }
}
