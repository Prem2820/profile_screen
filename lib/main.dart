import 'package:flutter/material.dart'; // Imports Flutter's Material Design widget library (buttons, AppBar, Scaffold, etc.)

void main() {
  runApp(const MyApp()); // Entry point of the app; runApp() inflates the given widget and attaches it to the screen
}

class MyApp extends StatelessWidget { // Root widget of the app; StatelessWidget means it doesn't hold mutable state
  const MyApp({super.key}); // Constructor; 'key' helps Flutter identify widgets uniquely in the widget tree

  @override
  Widget build(BuildContext context) { // build() describes the UI this widget should render
    return MaterialApp( // MaterialApp sets up app-wide config (theme, routes, title, etc.)
      title: 'Intern Profile', // Title used by the OS (e.g., in app switcher), not shown on screen
      debugShowCheckedModeBanner: false, // Hides the red "DEBUG" banner in the top-right corner
      theme: ThemeData(
        primarySwatch: Colors.blue, // Sets the default color scheme of the app to shades of blue
      ),
      home: const ProfileScreen(), // The first screen shown when the app launches
    );
  }
}

class ProfileScreen extends StatelessWidget { // The Profile Screen widget; stateless since nothing changes dynamically here
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Scaffold provides the basic visual structure (AppBar, body, etc.)
      appBar: AppBar( // The top bar of the screen
        title: const Text('Intern Profile'), // Text displayed in the AppBar, as required
        backgroundColor: Colors.blue, // Sets AppBar's background color
        centerTitle: true, // Centers the title text horizontally in the AppBar
      ),
      body: Center( // Centers its child widget both vertically and horizontally
        child: Padding(
          padding: const EdgeInsets.all(24.0), // Adds 24 pixels of space on all sides around the child
          child: Column( // Arranges its children vertically, one below another
            mainAxisAlignment: MainAxisAlignment.center, // Centers children vertically within the Column
            children: [
              const CircleAvatar( // A circular widget commonly used for profile pictures
                radius: 60, // Sets the size of the circle (radius in pixels)
                backgroundImage: NetworkImage(
                  'https://images.hdqwalls.com/download/doctor-doom-behind-the-mask-mv-1920x1080.jpg', // Placeholder image URL shown inside the circle
                ),
                backgroundColor: Colors.grey, // Fallback color shown while the image loads or if it fails
              ),
              const SizedBox(height: 20), // Empty box used purely to create 20px vertical spacing
              const Text(
                'Premsai', // The name text displayed on the profile
                style: TextStyle(
                  fontSize: 24, // Sets text size
                  fontWeight: FontWeight.bold, // Makes the name text bold
                ),
              ),
              const SizedBox(height: 10), // 10px spacing between name and bio
              const Text(
                'Mobile App Development Intern passionate about Flutter and building cross-platform apps.',
                // The bio text describing the intern
                textAlign: TextAlign.center, // Centers the bio text if it wraps to multiple lines
                style: TextStyle(
                  fontSize: 16, // Sets bio text size
                  color: Colors.grey, // Makes bio text a muted grey color
                ),
              ),
              const SizedBox(height: 30), // 30px spacing before the button
              ElevatedButton(
                onPressed: () {
                  // Function that runs when the button is tapped
                  ScaffoldMessenger.of(context).showSnackBar(
                    // Shows a small message at the bottom of the screen
                    const SnackBar(
                      content: Text('Profile button pressed!'), // Message text inside the SnackBar
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Sets the button's background color
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32, // Adds horizontal internal padding inside the button
                    vertical: 12, // Adds vertical internal padding inside the button
                  ),
                ),
                child: const Text(
                  'Contact Me', // Text label displayed on the button
                  style: TextStyle(fontSize: 16, color: Colors.white), // Styles the button text
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}