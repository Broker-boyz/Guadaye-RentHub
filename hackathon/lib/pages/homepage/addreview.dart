import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackathon/pages/homepage/review_data_model.dart';
import 'package:lottie/lottie.dart';

class AddReview extends StatefulWidget {
  final double initialRate;
  const AddReview({Key? key, required this.initialRate}) : super(key: key);

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  late double currentRate;
  String userReview = '';

  @override
  void initState() {
    super.initState();
    currentRate = widget.initialRate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('lib/animation/Animation - welcome.json'),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Rate Gojo RentHub App !!',
                  style: TextStyle(color: Colors.blue, fontSize: 24),
                ),
              ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: RatingBar.builder(
                  glowRadius: 30,
                  initialRating: currentRate,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 40,
                  itemBuilder: (context, _) =>
                      const Icon(Icons.star, color: Colors.pink),
                  onRatingUpdate: (rating) {
                    setState(() {
                      currentRate = rating;
                    });
                  },
                ),
              ),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Write your review here',
                ),
                maxLines: null,
                onChanged: (value) {
                  setState(() {
                    userReview = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  _submitReview();
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitReview() {
    final Reviewer reviewer =
        Reviewer(profile: 'profile_url', name: 'John Doe');
    final Rate rate = Rate(value: currentRate);
    final Review review = Review(
      description: userReview,
      rate: rate,
      reviewer: reviewer,
      replies: [],
      date: DateTime.now(), id: 'id',
    );

    FirebaseFirestore.instance
        .collection('reviews')
        .add(review.toJson())
        .then((value) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Review submitted successfully'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to submit review: $error'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    });
  }
}
