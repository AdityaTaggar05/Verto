import 'package:flutter/material.dart';

// TODO: Convert to floating snack bar
void showSnackBar(context, String content) {
  final snackBar = SnackBar(
        content: Text(
          content,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(241, 235, 125, 57),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
}