// lib/main.dart

import 'package:flutter/material.dart';
import 'package:verto/pages/login/login.dart';
import 'package:verto/pages/register/register.dart';
void main() {
  runApp(const VertoApp());
}

class VertoApp extends StatelessWidget {
  const VertoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage()
    );
  }
}

