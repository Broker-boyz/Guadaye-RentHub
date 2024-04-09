import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateBarIndicator extends StatefulWidget {
  final double initialRate;
  RateBarIndicator({
    
    required this.initialRate,
  }) ;

  @override
  _RateBarIndicatorState createState() => _RateBarIndicatorState();
}

class _RateBarIndicatorState extends State<RateBarIndicator> {
  late double currentRate;

  @override
  void initState() {
    super.initState();
    currentRate = widget.initialRate;
  }

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: currentRate,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 20,
      itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.pink),
      ignoreGestures: true,
      onRatingUpdate: (rating) {
        setState(() {
          currentRate = rating;
        });
      },
    );
  }
}
