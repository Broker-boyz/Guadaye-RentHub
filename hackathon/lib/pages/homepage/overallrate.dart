import 'package:flutter/material.dart';
import 'package:hackathon/pages/homepage/ratevalue.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OverallRating extends StatefulWidget {
  const OverallRating({
    Key? key,
  });

  @override
  State<OverallRating> createState() => _OverallRatingState();
}

class _OverallRatingState extends State<OverallRating> {
  double averageRate = 0.0;
  Map<int, double> averageRates = {};

  @override
  void initState() {
    super.initState();
    fetchAverageRate();
    fetchAverageRateForEachValue();
  }

  Future<void> fetchAverageRate() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('reviews').get();

    double totalRate = 0;
    int numberOfReviews = querySnapshot.docs.length;

    if (numberOfReviews > 0) {
      querySnapshot.docs.forEach((doc) {
        var data = doc.data() as Map<String, dynamic>?;

        if (data != null) {
          totalRate += (data['rate'] as Map<String, dynamic>?)?['value'] ?? 0;
        }
      });

      setState(() {
        averageRate = totalRate / numberOfReviews;
      });
    }
  }

  Future<void> fetchAverageRateForEachValue() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('reviews').get();

    Map<int, int> ratingCounts = {
  1: 0,
  2: 0,
  3: 0,
  4: 0,
  5: 0,
};

querySnapshot.docs.forEach((doc) {
  var data = doc.data() as Map<String, dynamic>?;

  if (data != null && data['rate'] != null) {
    int? rateValue = (data['rate']!['value'] as int?) ?? 0;
    ratingCounts[rateValue] = (ratingCounts[rateValue] ?? 0) + 1;
  }
});

Map<int, double> averageRates = {};

ratingCounts.forEach((key, value) {
  if (value > 0) {
    averageRates[key] = value / ratingCounts[key]!.toDouble();
  }
});


    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            '${averageRate.toStringAsFixed(1)}',
            style: TextStyle(color: Colors.black, fontSize: 60),
          ),
        ),
        Expanded(
          flex: 7,
          child: Column(
            children: [
              for (int i = 5; i >= 1; i--)
                RateValue(
                  text: '$i',
                  value: averageRates[i] ?? 0.0,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
