// ignore: file_names
// ignore_for_file: library_private_types_in_public_api

import 'package:demo_application/Services/RegisterService.dart';
import 'package:flutter/material.dart';



class ResetPassword extends StatefulWidget {
    final String emailId;

  // const ResetPassword({super.key});
 ResetPassword({required this.emailId, required TextEditingController password});

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  OutlineInputBorder _customBorder(bool isError) {
    Color borderColor = isError ? Colors.red : Colors.grey;
    return OutlineInputBorder(
      borderSide: BorderSide(color: borderColor),
      borderRadius: BorderRadius.circular(80.0),
    );
  }

  String? _validateRequired(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != _newPasswordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight + 30),
      child: AppBar(
        title: const Text('Change Password',style:TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
        centerTitle: true,
        toolbarHeight: 100,
        backgroundColor: Colors.black,

      ),),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [ 
              const SizedBox(height: 50.0),
              const Icon(
          Icons.key,
          size:75,
        ),
    
        const SizedBox(height: 25),
              
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('New Password',
                    style: TextStyle(fontWeight: FontWeight.bold,
                    fontSize:20.0),
                    
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _newPasswordController,
                    decoration: InputDecoration(
                        labelText: 'New password',
                        border: _customBorder(false),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(80),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(80),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        fillColor: Colors.grey[100],
                        filled: true,
                        
                      ),
                      validator: _validateRequired,
                    obscureText: true,
                  ),
                ],
              ),
              const SizedBox(height: 40.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('Confirm Password',
                    style: TextStyle(fontWeight: FontWeight.bold,
                    fontSize:20.0),
                    
                    ),
                    
                  ),
                  const SizedBox(height: 20.0),

                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: InputDecoration(
                        labelText: 'Confirm password',
                        border: _customBorder(false),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(80),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(80),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                        fillColor: Colors.grey[100],
                        filled: true,
                        
                      ),
                    validator: (value) {
                      return _validateRequired(value) ?? _validateConfirmPassword(value);
                    },
                    obscureText: true,
                  ),
                ],
              ),
              const SizedBox(height: 25.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ElevatedButton(
                      onPressed: () async{
                        await ResetPassword(
                          emailId:widget.emailId.toString(),
                          password:_newPasswordController
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0),
                      ),
                  backgroundColor:Colors.black
                ),
                      child: const Text('Change Password',
                      style: TextStyle(color: Colors.white),),
                      
                    ),
                  ),
                   const Padding(
                     padding: EdgeInsets.symmetric(horizontal: 25.0),
                     child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                                      ),
                   ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// void main() {
//   runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: ResetPassword(),
//   ));
// }