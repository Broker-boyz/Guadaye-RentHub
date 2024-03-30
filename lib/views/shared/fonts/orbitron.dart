import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle textStyleOrbitron(
    double size, Color color, FontWeight fontWeight, double letterSpacing) {
  return GoogleFonts.orbitron(
      fontSize: size,
      color: color,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing);
}
