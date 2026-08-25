import 'package:flutter/material.dart';
import 'profile_screen.dart'; // Imports the Profile Screen file so it can be used as the home screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intern App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ProfileScreen(), // App starts on the Profile Screen
    );
  }
}