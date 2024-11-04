import 'dart:async';
import 'dart:convert';
import 'package:demo_application/pages/LoginPage.dart';
import 'package:flutter/material.dart'; // Import material.dart for TextEditingController
import 'package:http/http.dart' as http;

final TextEditingController emailIdController=TextEditingController();

void main(){
  runApp(ChangePasswordService());
}

class ChangePasswordService extends StatelessWidget{

  @override
  Widget build(BuildContext context){
      return MaterialApp();
  }

}

Future<void> ChangePassword({required String emailId , required BuildContext context})async {

    Map<String,String> requestBody={
      'emailId':emailId
    
      
    };

    var response =await http.post(
      Uri.parse('http://localhost:8080/initiatePasswordReset'),
      headers: <String, String>{
       'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(requestBody),
  );
  if (response.statusCode == 200) {
    Navigator.push(
                        context as BuildContext,
                        MaterialPageRoute(builder: (context) => LoginPage(),
                      ),
                      );
    // Navigate to the next screen or perform any desired actions
    print('Check Your Email and Click the link to reset your password');
  } else {
    // Login failed
    // Display an error message or handle the error in any other way
    print(' failed: ${response.statusCode}');
  }

}

