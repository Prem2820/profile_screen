import 'package:flutter/material.dart';
import 'welcome_screen.dart'; // Needed for navigation to Welcome Screen
import 'user_list_screen.dart'; // Needed for navigation to the User List screen

class ProfileScreen extends StatefulWidget {
  // Changed from StatelessWidget to StatefulWidget because this screen
  // now needs to hold data that changes over time (follow status, like count, theme).
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
  // createState() links this widget to its matching State class below,
  // which is where all the mutable data and setState() calls actually live.
}

class _ProfileScreenState extends State<ProfileScreen> {
  // This class holds the "state" — variables that can change and trigger a UI rebuild.

  bool isFollowing = false; // Tracks whether the Follow button has been tapped (Follow vs Following)
  int likeCount = 0; // Tracks how many times the Like button has been tapped
  bool isDarkMode = false; // Tracks whether dark text/theme mode is currently on

  void _toggleFollow() {
    // Called when the Follow button is tapped
    setState(() {
      // setState() tells Flutter: "data changed, please rebuild the UI"
      isFollowing = !isFollowing; // Flips true/false each tap
    });
  }

  void _incrementLike() {
    // Called when the Like button is tapped
    setState(() {
      likeCount++; // Increases the counter by 1 each tap
    });
  }

  void _toggleTheme() {
    // Called when the Dark/Light toggle is tapped
    setState(() {
      isDarkMode = !isDarkMode; // Flips true/false each tap
    });
  }

  @override
  Widget build(BuildContext context) {
    // build() re-runs every time setState() is called, redrawing the UI with updated values

    // Colors change based on isDarkMode — this is the "Dark/Light text change" requirement
    final Color backgroundColor = isDarkMode ? Colors.black : Colors.white;
    final Color textColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: backgroundColor, // Whole screen background flips with the toggle
      appBar: AppBar(
        title: const Text('Intern Profile'),
        backgroundColor: Colors.blue,
        centerTitle: true,
        actions: [
          // actions places widgets on the right side of the AppBar
          IconButton(
            // A tappable icon button for toggling dark/light mode
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
              // Icon changes to reflect the CURRENT mode, showing what tapping it will switch TO
              color: Colors.white,
            ),
            onPressed: _toggleTheme, // Calls our toggle function when tapped
            tooltip: 'Toggle Dark/Light Mode',
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, size: 60, color: Colors.white),
                // Using an Icon instead of NetworkImage avoids internet-dependency errors
              ),
              const SizedBox(height: 20),
              Text(
                'Premsai',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: textColor, // Text color reacts to dark/light mode
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Mobile App Development Intern passionate about Flutter and building cross-platform apps.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                  // Slightly different grey shades for readability in each mode
                ),
              ),
              const SizedBox(height: 30),

              // ---------- FOLLOW BUTTON ----------
              ElevatedButton(
                onPressed: _toggleFollow, // Runs _toggleFollow() on tap
                style: ElevatedButton.styleFrom(
                  backgroundColor: isFollowing ? Colors.grey : Colors.blue,
                  // Button color changes depending on follow state
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: Text(
                  isFollowing ? 'Following' : 'Follow',
                  // Label swaps text based on isFollowing's current value
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),

              // ---------- LIKE COUNTER ----------
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    onPressed: _incrementLike, // Runs _incrementLike() on tap
                  ),
                  Text(
                    '$likeCount Likes', // Displays the current like count; rebuilds every tap
                    style: TextStyle(fontSize: 16, color: textColor),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // ---------- NAVIGATION BUTTON (kept from earlier task) ----------
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const WelcomeScreen()),
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
              const SizedBox(height: 20), // Spacing before the new button

              // ---------- NEW: USER LIST NAVIGATION BUTTON ----------
              ElevatedButton(
                onPressed: () {
                  // Navigates to the User List screen, which fetches and displays
                  // users from the jsonplaceholder API
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UserListScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  // Different color from the other buttons so it's visually distinct
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: const Text(
                  'View User List',
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