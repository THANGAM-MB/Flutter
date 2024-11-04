// ignore_for_file: prefer_const_constructors_in_immutables, file_names

import 'package:demo_application/components/my_textfied.dart';
import 'package:demo_application/components/square_tile.dart';
import 'package:demo_application/pages/ForgotPassword.dart';
import 'package:flutter/material.dart';
import 'RegisterPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginPage(),
  ));
}


class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  bool rememberMe = false;
  bool _isLoading = false;
  String _errorMessage = '';
  bool _isButtonDisabled = false;
  int _countdown = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    loadRememberMe();
  }

  void loadRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      rememberMe = prefs.getBool('rememberMe') ?? false;
    });
  }

  void saveRememberMe(bool newValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rememberMe', newValue);
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void toggleRememberMe(bool newValue) {
    setState(() {
      rememberMe = newValue;
      saveRememberMe(newValue);
    });
  }

  void startCountdown(int seconds) {
    setState(() {
      _countdown = seconds;
      _isButtonDisabled = true;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _countdown--;
      });

      if (_countdown <= 0) {
        timer.cancel();
        setState(() {
          _isButtonDisabled = false;
        });
      }
    });
  }

  Future<void> signUserIn({required String username, required String password}) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    Map<String, String> requestBody = {
      'emailId': username,
      'password': password,
    };
    try{
    var response = await http.post(
      Uri.parse('http://localhost:8080/generateToken'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

  
    print('responsebody....${response.body}');
 
    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Login successful!';
      });
    } else {
      print('in else');
      
      final responseBody = json.decode(response.body);
      print('Json decode...$responseBody');
      if (responseBody==60) {
        // final waitingTime = responseBody['waitingTime'];
        startCountdown(responseBody.toInt());
        setState(() {
          _errorMessage = 'Too many attempts. Please wait $responseBody seconds.';
        });
      } else {
        setState(() {
          _errorMessage = responseBody['message'] ?? 'Login failed';
        });
      }
      setState(() {
        _isLoading = false;
      });
    }
    }
    catch(e){
      print('catchException...${e.toString()}');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Icon(
              Icons.lock,
              size: 100,
            ),
            const SizedBox(height: 50),
            Text(
              'Welcome back',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 30),
            my_textfield(
              controller: usernameController,
              hintText: 'Username',
              obsecureText: false,
            ),
            const SizedBox(height: 10),
            my_textfield(
              controller: passwordController,
              hintText: 'Password',
              obsecureText: true,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: rememberMe,
                        onChanged: (value) {
                          toggleRememberMe(value!);
                        },
                      ),
                      Text(
                        'Remember me',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                      );
                    },
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: _isButtonDisabled
                    ? null
                    : () async {
                        await signUserIn(
                          username: usernameController.text,
                          password: passwordController.text,
                        );
                      },
                child: _isLoading
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : Text(
                        _isButtonDisabled
                            ? 'Please wait $_countdown seconds'
                            : 'Sign In',
                        style: TextStyle(color: Colors.white),
                      ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    _isButtonDisabled ? Colors.grey : Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account? ',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    child: Text(
                      'Create',
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey[400],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Or Continue with',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SquareTile(imagePath: 'lib/images/apple.png'),
                SizedBox(width: 10),
                SquareTile(imagePath: 'lib/images/google.png'),
                SizedBox(width: 10),
                SquareTile(imagePath: 'lib/images/fb.png'),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              _errorMessage,
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

  // @override
  // Widget build(BuildContext context) {
  //   // TODO: implement build
  //   throw UnimplementedError();
  // }
