import 'dart:async';
import 'dart:convert';
import 'package:demo_application/pages/LoginPage.dart';
import 'package:flutter/material.dart'; // Import material.dart for TextEditingController
import 'package:http/http.dart' as http;

final TextEditingController insuranceController=TextEditingController();
final TextEditingController rcBookController=TextEditingController();
final TextEditingController modelController=TextEditingController();
final TextEditingController nameController=TextEditingController();
final TextEditingController numberController=TextEditingController();

void main(){
  runApp(vechileDetailsService());
}

class vechileDetailsService extends StatelessWidget{

  @override
  Widget build(BuildContext context){
      return MaterialApp();
  }

}

Future<void> VehicleDetails({  required BuildContext context,
required String userId,required String insuranceNumber,required String rcBookNumber,
required String model,required String vehicleName,required String vehicleNumber })async {

    Map<String,Object> requestBody={
      'vehicleName':vehicleName,
      'vehicleNumber':vehicleNumber,
      'vehicleModel':model,
      'rcBookNumber':rcBookNumber,
      'insuranceNumber':insuranceNumber,
      'userId':userId
      
    };

    var response =await http.post(
      Uri.parse('http://localhost:8080/vehicledetails'),
      headers: <String, String>{
       'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(requestBody),
  );
  if (response.statusCode == 200) {
    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage(),
                      ),
                      );
    // Navigate to the next screen or perform any desired actions
    print('vehicleDetailsSaved Succesfully successful!');
  } else {
    // Login failed
    // Display an error message or handle the error in any other way
    print(' failed: ${response.statusCode}');
  }

}


