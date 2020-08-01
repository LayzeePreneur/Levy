import 'package:flutter/material.dart';

InputDecoration addTxField(String fieldHintText) {
  return InputDecoration(
    contentPadding: EdgeInsets.symmetric(
      vertical: 18,
      horizontal: 15,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide(width: 0.9),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide(width: 0.9, color: Colors.grey[300]),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide(width: 0.9, color: Colors.grey[400]),
    ),
    filled: true,
    fillColor: Colors.grey[200],
    hintText: fieldHintText,
  );
}
