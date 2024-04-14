// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class MyUser extends Equatable {
  final String uid;
  final String fullName;
  final String phoneNumber;
  final String accountType;
  final String address;
  final String username;
  final String email;
  final String imagePath;
  final String gender;
  
  const MyUser({
    required this.uid,
    required this.fullName,
    required this.phoneNumber,
    required this.accountType,
    required this.address,
    required this.username,
    required this.email,
    required this.imagePath,
    required this.gender,
  });


  MyUser copyWith({
    String? uid,
    String? fullName,
    String? phoneNumber,
    String? accountType,
    String? address,
    String? username,
    String? email,
    String? imagePath,
    String? gender,
  }) {
    return MyUser(
      uid: uid ?? this.uid,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      accountType: accountType ?? this.accountType,
      address: address ?? this.address,
      username: username ?? this.username,
      email: email ?? this.email,
      imagePath: imagePath ?? this.imagePath,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'accountType': accountType,
      'address': address,
      'username': username,
      'email': email,
      'imagePath': imagePath,
      'gender': gender,
    };
  }

  factory MyUser.fromMap(Map<String, dynamic> map) {
    return MyUser(
      uid: map['uid'] as String,
      fullName: map['full-name'] as String,
      phoneNumber: map['phone-number'] as String,
      accountType: map['account-type'] as String,
      address: map['address'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      imagePath: map['image-path'] as String,
      gender: map['gender'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MyUser.fromJson(String source) => MyUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      uid,
      fullName,
      phoneNumber,
      accountType,
      address,
      username,
      email,
      imagePath,
      gender,
    ];
  }
}
