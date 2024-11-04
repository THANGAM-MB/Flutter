import 'dart:convert';
import 'package:flutter/material.dart'; // Import material.dart for TextEditingController
import 'package:http/http.dart' as http;

// Define controllers outside of the function to make them accessible throughout the class/file
final TextEditingController usernameController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      // home: LoginPage(),
    );
  }
}


Future<void> signUserIn({required String username,required String password}) async {

  // Construct the request body
  Map<String, String> requestBody = {
    'emailId': username,
    'password': password,
  };
  // Make the POST request
  var response = await http.post(
    Uri.parse('http://localhost:8080/generateToken'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(requestBody),
  );

  // Check the response status code
  if (response.statusCode == 200) {
    // Login successful
    // Navigate to the next screen or perform any desired actions
    print('Login successful!');
  } else {
    // Login failed
    // Display an error message or handle the error in any other way
    print('Login failed: ${response.statusCode}');
  }
}

