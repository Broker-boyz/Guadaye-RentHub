// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class MyNotification extends Equatable {
  final String address;
  final String fullName;
  final String phoneNumber;
  final String email;
  final String gender;
  final String uid;
  // final DateTime createdAt;

  const MyNotification({
    required this.address,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.gender,
    required this.uid,
    // required this.createdAt,
  });
  

  MyNotification copyWith({
    String? address,
    String? fullName,
    String? phoneNumber,
    String? email,
    String? gender,
    String? uid,
    // DateTime? createdAt,
  }) {
    return MyNotification(
      address: address ?? this.address,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      uid: uid ?? this.uid,
      // createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address,
      'full-name': fullName,
      'phone-number': phoneNumber,
      'email': email,
      'gender': gender,
      'uid': uid,
      // 'created-at': createdAt.toIso8601String(),
    };
  }

  factory MyNotification.fromMap(Map<String, dynamic> map) {
    return MyNotification(
      address: map['address'] as String,
      fullName: map['full-name'] as String,
      phoneNumber: map['phone-number'] as String,
      email: map['email'] as String,
      gender: map['gender'] as String,
      uid: map['uid'] as String,
      // createdAt: DateTime.parse(map['created-at'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory MyNotification.fromJson(String source) => MyNotification.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      address,
      fullName,
      phoneNumber,
      email,
      gender,
    ];
  }
}
