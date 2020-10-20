import 'package:flutter/material.dart';

LinearGradient returnGradient(List<Color> colors) {
  LinearGradient gradient = LinearGradient(
      begin: Alignment.centerLeft, end: Alignment.centerRight, colors: colors);

  return gradient;
}