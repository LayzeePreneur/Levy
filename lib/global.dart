import 'package:flutter/material.dart';

InputDecoration addTxField(String fieldHintText) {
  return InputDecoration(
    contentPadding: const EdgeInsets.all(16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: const BorderSide(width: 0.9),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide(width: 1.1, color: Colors.grey[350]),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide(width: 1.1, color: Colors.grey[400]),
    ),
    filled: true,
    fillColor: Colors.grey[200],
    hintText: fieldHintText,
    hintStyle: const TextStyle(
      fontFamily: 'Quicksand',
      color: Colors.black38,
      fontSize: 15,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.8,
    ),
  );
}

TextStyle chartbarFontPortrait() {
  return const TextStyle(
    fontFamily: 'Quicksand',
    fontWeight: FontWeight.w700,
    color: Colors.black54,
  );
}

TextStyle chartbarFontLandscape(double fontSize) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: 'Quicksand',
    fontWeight: FontWeight.w600,
    color: Colors.black54,
  );
}
