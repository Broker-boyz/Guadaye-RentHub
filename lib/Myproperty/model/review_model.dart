// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final String reviewId;
  final String review;
  final double rating;
  final String userId;
  final DateTime date;

  const Review({
    required this.reviewId,
    required this.review,
    required this.rating,
    required this.userId,
    required this.date,
  });

  Review copyWith({
    String? reviewId,
    String? review,
    double? rating,
    String? userId,
    DateTime? date,
  }) {
    return Review(
      reviewId: reviewId ?? this.reviewId,
      review: review ?? this.review,
      rating: rating ?? this.rating,
      userId: userId ?? this.userId,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'reviewId': reviewId,
      'review': review,
      'rating': rating,
      'userId': userId,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      reviewId: map['reviewId'] as String,
      review: map['review'] as String,
      rating: map['rating'] as double,
      userId: map['userId'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) => Review.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      reviewId,
      review,
      rating,
      userId,
      date,
    ];
  }
}
