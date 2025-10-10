// lib/main.dart

import 'package:flutter/material.dart';
//import 'package:verto/pages/profile/profile.dart';
import 'package:verto/pages/sessioncreation/create_session.dart';

void main() {
  runApp(const MyApp()); // Runs the root widget of the app
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CreateSession() ,
    );
  }
}
