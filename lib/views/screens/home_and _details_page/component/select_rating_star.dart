import 'package:flutter/material.dart';

Widget ratingStarSelection(double rating) {
  switch (rating.round()) {
    case 0:
    case 1:
      return const Icon(
        Icons.star_border,
        color: Colors.amber,
      );
    case 2:
    case 3:
      return const Icon(
        Icons.star_half_sharp,
        color: Colors.amber,
      );
    case 4:
      return const Icon(
        Icons.star_purple500_sharp,
        color: Colors.amber,
      );
    case 5:
      return const Icon(
        Icons.stars,
        color: Colors.red,
      );
    default:
      return const SizedBox();
  }
}
