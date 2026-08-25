import 'package:flutter/material.dart';
import 'welcome_screen.dart'; // Imports Welcome Screen so we can navigate to it

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Intern Profile'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                backgroundColor: Colors.grey,
              ),
              const SizedBox(height: 20),
              const Text(
                'Premsai',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Mobile App Development Intern passionate about Flutter and building cross-platform apps.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Navigator.push adds a new screen on top of the current one (like moving forward)
                  Navigator.push(
                    context, // The current screen's location in the widget tree; needed so Navigator knows where to insert the new route
                    MaterialPageRoute(
                      // MaterialPageRoute defines a screen transition with Android/iOS-style animation
                      builder: (context) => const WelcomeScreen(),
                      // builder returns the widget (screen) to navigate to
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: const Text(
                  'Go to Welcome',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}