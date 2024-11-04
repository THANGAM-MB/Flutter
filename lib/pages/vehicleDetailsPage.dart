import 'package:demo_application/Services/VehicleDetailsService.dart';
import 'package:flutter/material.dart';

class VehicleDetailsPage extends StatefulWidget {
  final int userId;

 VehicleDetailsPage({required this.userId});

  @override
  _VehicleDetailsPageState createState() => _VehicleDetailsPageState();
}

class _VehicleDetailsPageState extends State<VehicleDetailsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController insuranceController;
  late TextEditingController rcBookController;
  late TextEditingController modelController;
  late TextEditingController nameController;
  late TextEditingController numberController;

  @override
  void initState() {
    super.initState();
    insuranceController = TextEditingController();
    rcBookController = TextEditingController();
    modelController = TextEditingController();
    nameController = TextEditingController();
    numberController = TextEditingController();
  }

  @override
  void dispose() {
    insuranceController.dispose();
    rcBookController.dispose();
    modelController.dispose();
    nameController.dispose();
    numberController.dispose();
    super.dispose();
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
                'Enter Vehicle Details',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              _buildInputField(
                controller: insuranceController,
                labelText: 'Insurance Number',
                icon: Icons.local_car_wash,
              ),
              SizedBox(height: 20.0),
              _buildInputField(
                controller: rcBookController,
                labelText: 'RC Book Number',
                icon: Icons.book,
              ),
              SizedBox(height: 20.0),
              _buildInputField(
                controller: modelController,
                labelText: 'Vehicle Model',
                icon: Icons.directions_car,
              ),
              SizedBox(height: 20.0),
              _buildInputField(
                controller: nameController,
                labelText: 'Vehicle Name',
                icon: Icons.directions_car,
              ),
              SizedBox(height: 20.0),
              _buildInputField(
                controller: numberController,
                labelText: 'Vehicle Number',
                icon: Icons.confirmation_number,
              ),
              SizedBox(height: 32.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await VehicleDetails(
                          userId:widget.userId.toString(),
                          insuranceNumber:insuranceController.text,
                          rcBookNumber:rcBookController.text,
                          model:modelController.text,
                          vehicleName:nameController.text,
                          vehicleNumber:numberController.text,
                          context:context
                        );
                        };// Form is valid, process data
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

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: VehicleDetailsPage(),
//   ));
// }
