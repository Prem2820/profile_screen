import 'dart:convert'; // Provides jsonDecode() to parse the API's JSON response into Dart objects
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // The http package, aliased as 'http' to avoid name clashes

// ---------- MODEL CLASS ----------
// Represents a single user, matching the shape of data from the API
class User {
  final String name;
  final String email;
  final String company;

  User({required this.name, required this.email, required this.company});

  // Factory constructor: builds a User object from a raw JSON map
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'], // Reads the "name" field from the JSON object
      email: json['email'], // Reads the "email" field
      company: json['company']['name'],
      // The API nests company info as {"company": {"name": "..."}}, so we drill one level deeper
    );
  }
}

// ---------- API CALL FUNCTION ----------
// Fetches the user list from the API and returns a Future (a value that arrives later)
Future<List<User>> fetchUsers() async {
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/users'),
    // Uri.parse converts the string URL into a Uri object that http.get() requires
  );

  if (response.statusCode == 200) {
    // 200 means the request succeeded
    final List<dynamic> data = jsonDecode(response.body);
    // jsonDecode turns the raw JSON string (response.body) into a Dart List of Maps
    return data.map((json) => User.fromJson(json)).toList();
    // .map() converts each raw JSON map into a User object; .toList() collects them into a List<User>
  } else {
    // Any other status code (404, 500, etc.) means something went wrong
    throw Exception('Failed to load users (status code: ${response.statusCode})');
    // Throwing an exception lets FutureBuilder catch it and show an error state
  }
}

// ---------- USER LIST SCREEN ----------
class UserListScreen extends StatefulWidget {
  // StatefulWidget because we need to trigger a retry (re-fetch) if the API call fails
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  late Future<List<User>> futureUsers;
  // 'late' means this variable will be set before it's used, just not at declaration time

  @override
  void initState() {
    // initState() runs ONCE when the widget is first created — perfect place to start the API call
    super.initState();
    futureUsers = fetchUsers(); // Kicks off the network request immediately
  }

  void _retry() {
    // Called when the user taps "Retry" after an error
    setState(() {
      futureUsers = fetchUsers(); // Re-runs the API call and rebuilds the UI with the new Future
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: FutureBuilder<List<User>>(
        // FutureBuilder rebuilds itself automatically based on the Future's state
        future: futureUsers, // The Future it's watching
        builder: (context, snapshot) {
          // 'snapshot' holds the current state of the Future: waiting, error, or data

          if (snapshot.connectionState == ConnectionState.waiting) {
            // While the API call is still in progress
            return const Center(
              child: CircularProgressIndicator(), // Spinner shown during loading
            );
          } else if (snapshot.hasError) {
            // If fetchUsers() threw an exception
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red, size: 48),
                    const SizedBox(height: 12),
                    Text(
                      'Something went wrong:\n${snapshot.error}',
                      // Displays the actual error message for debugging/feedback
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _retry, // Lets the user try the API call again
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasData) {
            // The API call succeeded and returned data
            final users = snapshot.data!;
            // '!' asserts data is non-null here, which is safe since hasData confirmed it exists

            return ListView.builder(
              // ListView.builder is efficient for long lists — builds items on demand as scrolled
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(user.name[0]),
                      // Shows the first letter of the user's name as a simple avatar
                    ),
                    title: Text(user.name),
                    subtitle: Text('${user.email}\n${user.company}'),
                    isThreeLine: true, // Allows the subtitle to wrap onto two lines cleanly
                  ),
                );
              },
            );
          }

          // Fallback case (shouldn't normally be reached)
          return const Center(child: Text('No data available'));
        },
      ),
    );
  }
}