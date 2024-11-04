// ignore_for_file: prefer_const_constructors

import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter

import 'package:demo_application/pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


final TextEditingController amountPerHourController=TextEditingController();
final TextEditingController slotNumberController=TextEditingController();
final TextEditingController slotSizeController=TextEditingController();
final TextEditingController addressController=TextEditingController();
final TextEditingController pincodeController=TextEditingController();

void main()
{
  runApp(SlotDetailsService());
}

class SlotDetailsService extends StatelessWidget{
  const SlotDetailsService({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App',
    );

  }
  
}

Future<void> slotDetails({
  required BuildContext context,
  required String amountPerHour,
  required String slotNo,
  required String slotSize,
  required String streetName,
  required String locationId,
  required String userId,
}) async {
  Map<String, Object> requestBody = {
    'amountPerHour':amountPerHour,
    'slotNo': slotNo,
    'streetName': streetName,
    'locationId': locationId,
    'slotSize': slotSize,
    'userId': userId,
  };

  try {
    var response = await http.post(
      Uri.parse('http://localhost:8080/slotDetails'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      print('Registration successful!');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
      print('Slot navigation successful!');
    } else {
      print('Registration failed: ${response.statusCode}');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
}