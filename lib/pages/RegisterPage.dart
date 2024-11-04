
import 'package:flutter/material.dart';
import 'package:demo_application/Services/RegisterService.dart';
import 'package:intl/intl.dart';



class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController aadharController;
  late TextEditingController emailController;
  late TextEditingController phoneNumber1Controller;
  late TextEditingController phoneNumber2Controller;
  // late TextEditingController dobController;
  late TextEditingController licenseNoController;
  late TextEditingController occupationController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController userRoleController;

  String? selectedUserRole;
  String? selectedOccupation;

  final List<String> userRoles = ['Car Owner', 'Slot Owner'];
  final List<String> occupations = ['Student', 'Ex Army', 'Others'];
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
    print('dateTime...${DateTime.parse('2003-05-20')}');
    print('formatted...${formatter.format(DateTime.parse('2003-05-20'))}');

    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    aadharController = TextEditingController();
    emailController = TextEditingController();
    phoneNumber1Controller = TextEditingController();
    phoneNumber2Controller = TextEditingController();
    // dobController = TextEditingController();
    licenseNoController = TextEditingController();
    occupationController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    userRoleController=TextEditingController();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    aadharController.dispose();
    emailController.dispose();
    phoneNumber1Controller.dispose();
    phoneNumber2Controller.dispose();
    dobController.dispose();
    licenseNoController.dispose();
    occupationController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    userRoleController.dispose();
    super.dispose();
  }

  OutlineInputBorder _customBorder(bool isError) {
    Color borderColor = isError ? Colors.red : Colors.grey;
    return OutlineInputBorder(
      borderSide: BorderSide(color: borderColor),
      borderRadius: BorderRadius.circular(10.0),
    );
  }

  String? _validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
DateTime selectedDate = DateTime.now();
TextEditingController _date = new TextEditingController();

Future<Null> _selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1901, 1),
      lastDate: DateTime(2100));
  if (picked != null && picked != selectedDate)
    setState(() {
      selectedDate = picked;
      _date.value = TextEditingValue(text: picked.toString());
      
    });
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Create an Account',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(child: 
                  _buildInputField(
                    controller: firstNameController,
                    labelText: 'First name*',
                    icon: Icons.person,
                    validator: _validateRequired,
                  ),
                  ),
                  SizedBox(width: 20.0,),
                  Expanded(child: 
                  _buildInputField(
                    controller: lastNameController,
                    labelText: 'Lastname',
                    icon: Icons.person,
                  ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              _buildInputField(
                controller: emailController,
                labelText: 'Email*',
                icon: Icons.email,
                validator: _validateRequired,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20.0),
              _buildInputField(
                controller: aadharController,
                labelText: 'Aadhar*',
                icon: Icons.assignment_ind,
                validator: _validateRequired,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: _buildInputField(
                      controller: phoneNumber1Controller,
                      labelText: 'Phone Number 1*',
                      icon: Icons.phone,
                      validator: _validateRequired,
                      // keyboardType: TextInputType.phone,
                    ),
                  ),
                  SizedBox(width: 20.0),
                  Expanded(
                    child: _buildInputField(
                      controller: phoneNumber2Controller,
                      labelText: 'Phone Number 2',
                      icon: Icons.phone,
                      // keyboardType: TextInputType.phone,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              GestureDetector(              
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: _buildInputField(
                    controller: _date,
                    keyboardType: TextInputType.datetime,
                    labelText: 'Date of birth',
                    icon: Icons.calendar_today,
                    validator: _validateRequired,
                  ),
                ),
              ),
            
              SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(child: 
                  _buildInputField(
                    controller: passwordController,
                    labelText: 'Password*',
                    icon: Icons.lock,
                    validator: _validatePassword,
                    obscureText: true,
                  ),
                  ),
                   SizedBox(width: 20.0),
                Expanded(child:                 
                _buildInputField(
                controller: confirmPasswordController,
                labelText: 'Confirm Password*',
                icon: Icons.lock,
                validator: _validateConfirmPassword,
                obscureText: true,
              ),),
                ],
              ),
             
              SizedBox(height: 20.0),
              _buildDropdownField(
                labelText: 'User Role*',
                icon: Icons.work,
                validator: _validateRequired,
                items: userRoles.map((String role) {
                  return DropdownMenuItem<String>(
                    value: role,
                    child: Text(role),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedUserRole = newValue;
                  });
                },
              ),
              SizedBox(height: 20.0),
              _buildDropdownField(
                labelText: 'Occupation*',
                icon: Icons.work,
                validator: _validateRequired,
                items: occupations.map((String occupation) {
                  return DropdownMenuItem<String>(
                    value: occupation,
                    child: Text(occupation),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedOccupation = newValue;
                    if (newValue == 'Others') {
                      occupationController.clear();
                    }
                  });
                },
              ),
              SizedBox(height: 20.0),
              if (selectedOccupation == 'Others')
                _buildInputField(
                  controller: occupationController,
                  labelText: 'Other Occupation',
                  icon: Icons.work,
                  keyboardType: TextInputType.text,
                ),
              SizedBox(height: 20.0),
              if (selectedUserRole == 'Car Owner')
                _buildInputField(
                  controller: licenseNoController,
                  labelText: 'License Number*',
                  icon: Icons.card_membership,
                  validator: _validateRequired,
                  keyboardType: TextInputType.text,
                ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async{
                  print('userMobileController....${phoneNumber1Controller.text}');
                //   if(selectedUserRole=='Slot Owner'){
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(builder: (context) => SlotDetailsPage(),
                //       ),
                //       );
                //  }
                //   else{
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(builder: (context) => VehicleDetailsPage(),
                //       ),
                //       );
                //   }
                  if (_formKey.currentState!.validate()) {                                   
                      await Register(
                        context:context,
                        aadhar:aadharController.text,
                        dateOfBirth:DateTime.parse(_date.text),
                        emailId:emailController.text,
                        firstName:firstNameController.text,
                        lastName: lastNameController.text,
                        licenseNumber:licenseNoController.text,
                        occupation:selectedOccupation.toString(),
                        password: passwordController.text,
                        confirmPassword:confirmPasswordController.text,
                        phoneNumber1:phoneNumber1Controller.text,
                        phoneNumber2: phoneNumber2Controller.text,
                        userRole:selectedUserRole.toString()
                      );                                    
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
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        border: _customBorder(false),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
    );
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
        border: _customBorder(false),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      items: items,
      validator: validator,
      onChanged: onChanged,
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: RegisterPage(),
  ));
}
