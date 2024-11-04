import 'dart:convert';
import 'package:demo_application/pages/SlotDetailsPage.dart';
import 'package:demo_application/pages/vehicleDetailsPage.dart';
import 'package:flutter/material.dart'; // Import material.dart for TextEditingController
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

// Define controllers outside of the function to make them accessible throughout the class/file


final TextEditingController aadharController=TextEditingController();
final TextEditingController dobController=TextEditingController();
final TextEditingController emailController=TextEditingController();
final TextEditingController firstNameController=TextEditingController();
final TextEditingController lastNameController=TextEditingController();
final TextEditingController licenseNoController=TextEditingController();
final TextEditingController occupationController=TextEditingController();
final TextEditingController passwordController=TextEditingController();
final TextEditingController confirmPasswordController=TextEditingController();
final TextEditingController phoneNumberController=TextEditingController();
final TextEditingController phoneNumber2Controller=TextEditingController();
final TextEditingController userRoleController=TextEditingController();
final DateFormat formatter = DateFormat('yyyy-MM-dd');

void main() {
  runApp(RegisterService());
}

class RegisterService extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
      // home: LoginPage(),
    );
  }
}


Future<void> Register({required BuildContext context,required String aadhar,required DateTime dateOfBirth,required String emailId,required String firstName,
required String lastName,required String licenseNumber,required String occupation,
required String password,required String confirmPassword,required String phoneNumber1,
required String phoneNumber2,required String userRole }) async {
  bool army=occupation=='Ex Army'?true:false;
  bool student=occupation=='Student'?true:false;
  print('army....$army');
  print('student...$student');
  print('register role...${userRole}');
    print('register occupation...${occupation}');
  // Construct the request body
  Map<String,Object> requestBody = {

    'aadhar':aadhar,
    'dateOfBirth':formatter.format(dateOfBirth),
    'emailId': emailId,
    'firstName':firstName,
    'lastName':lastName,
    'licenseNo':licenseNumber,
    'occupation':occupation,
    'password':password,
    'confirmPassword':confirmPassword,
    'phoneNo1':phoneNumber1,
    'phoneNo2':phoneNumber2,    
    'userRole':userRole,
    'isStudent':student,
    'isExArmy':army
  };
  // Make the POST request
  var response = await http.post(
    Uri.parse('http://localhost:8080/details'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(requestBody),
  );

  // Check the response status code
  if (response.statusCode == 200) {
   print('Registration successful!');
   var userId = jsonDecode(response.body)['userId'];
  print('userId...$userId');

   if(userRole=='Slot Owner'){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SlotDetailsPage(userId: userId),
                      ),
                      );
                 }
                  else{
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => VehicleDetailsPage(userId:userId),
                      ),
                      );
                  }
    print('navigation successful!');
  } else {
    // Login failed
    // Display an error message or handle the error in any other way
    print('Registration failed: ${response.statusCode}');
  }
}

