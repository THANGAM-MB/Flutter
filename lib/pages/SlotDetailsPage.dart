import 'dart:convert';

import 'package:demo_application/Services/SlotDetailsService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SlotDetailsPage extends StatefulWidget {
  final int userId; // User ID

  SlotDetailsPage({required this.userId});
  @override
  _SlotDetailsPageState createState() => _SlotDetailsPageState();
}

class _SlotDetailsPageState extends State<SlotDetailsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController amountPerHourController;
  late TextEditingController slotNumberController;
  late TextEditingController slotSizeController;
  late TextEditingController addressController;
  late TextEditingController pincodeController;
  List<String> locationIds=[];
  String selectedLocationId='';
  

  @override
  void initState() {
    super.initState();
    amountPerHourController = TextEditingController();
    slotNumberController = TextEditingController();
    slotSizeController = TextEditingController();
    addressController = TextEditingController();
    pincodeController = TextEditingController();
    fetchLocationIds(); 
  }

  @override
  void dispose() {
    amountPerHourController.dispose();
    slotNumberController.dispose();
    slotSizeController.dispose();
    addressController.dispose();
    pincodeController.dispose();
    super.dispose();
  }


  Future<void> fetchLocationIds() async {
    // Replace with your actual API call to fetch location IDs
    // Example:
    var response = await http.post(Uri.parse('http://localhost:8080/showLocationDetails'));

    if (response.statusCode == 200) {
      List<dynamic> map=jsonDecode(response.body);
      map.forEach((element) {
        locationIds.add(element['pincode'].toString());
      });
      print(response.body);
      setState(() {
        if (locationIds.isNotEmpty) {
          selectedLocationId = locationIds.first;
        }
      });
    } else {
      print('Failed to load location IDs');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('WELCOME',style:TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter Slot Details',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                
              ),
              SizedBox(height: 20.0),
              _buildInputField(
                controller: amountPerHourController,
                labelText: 'Amount per Hour',
                icon: Icons.money,
              ),
              SizedBox(height: 20.0),
              _buildInputField(
                controller: slotNumberController,
                labelText: 'Slot Number',
                icon: Icons.numbers,
              ),
              SizedBox(height: 20.0),
              _buildInputField(
                controller: slotSizeController,
                labelText: 'Slot Size',
                icon: Icons.area_chart,
              ),
              SizedBox(height: 20.0),
              _buildInputField(
                controller: addressController,
                labelText: 'Address',
                icon: Icons.location_city,
              ),
              SizedBox(height: 20.0),
              _buildDropdownField(
                
                labelText: 'pincode',
                icon: Icons.add_location,
                onChanged: (String? newValue) {
                setState(() {
                  selectedLocationId = newValue!;
                });
              },
              items: locationIds.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
              SizedBox(height: 32.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (selectedLocationId != null)  {
                        await slotDetails(
                          amountPerHour:amountPerHourController.text,
                          slotNo:slotNumberController.text,
                          streetName:addressController.text,
                          locationId:selectedLocationId,
                          slotSize:slotSizeController.text, 
                          userId: widget.userId.toString(),
                          context: context
                        );
                        // Form is valid, process data
                      }
                    },
              child: Text(
                  'Register',
                style: TextStyle(color: Colors.white),
                ),
                  style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(vertical: 16.0),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.black,
                  ),
                ),                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $labelText';
        }
        return null;
      },
    );
  }
}

  Widget _buildDropdownField({
    required String labelText,
    required IconData icon,
    required List<DropdownMenuItem<String>> items,
    required void Function(String?)? onChanged,
    String? Function(String?)? validator,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(),
        // filled: true,
        // fillColor: Colors.grey[200],
      ),
      items: items,
      validator: validator,
      onChanged: onChanged,
    );
  }
// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: SlotDetailsPage(slo),
//   ));
// }
