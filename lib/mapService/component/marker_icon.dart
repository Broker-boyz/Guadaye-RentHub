import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

Widget customMarker(String symbol) {
  return ClipPath(
    clipper: MessageClipper(borderRadius: 2),
    child: Container(
      height: 28,
      padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5, top: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: Colors.white,
      ),
      child: Center(
          child: Text(
        symbol,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
      )),
    ),
  );
}