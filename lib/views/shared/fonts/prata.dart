import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle textStylePrata(
    double size, Color color, FontWeight fontWeight, double letterSpacing) {
  return GoogleFonts.prata(
      fontSize: size,
      color: color,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing);
}
