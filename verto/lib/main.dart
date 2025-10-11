import 'package:flutter/material.dart';
import 'package:verto/pages/main.dart';
import 'package:verto/pages/register/register.dart';
import 'package:verto/services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService().init();

  runApp(const VertoApp());
}

class VertoApp extends StatelessWidget {
  const VertoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      
      home: MainPage());
  }
}
