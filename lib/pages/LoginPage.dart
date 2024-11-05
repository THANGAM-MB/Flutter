// ignore_for_file: prefer_const_constructors_in_immutables, file_names

// import 'package:demo_application/components/my_button.dart';
import 'package:demo_application/components/my_textfied.dart';
import 'package:demo_application/components/square_tile.dart';
import 'package:demo_application/pages/ForgotPassword.dart';
import 'package:flutter/material.dart';
import 'RegisterPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:demo_application/Services/LoginService.dart';


class LoginPage extends StatefulWidget{
  LoginPage({super.key});
   @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  bool rememberMe = false;

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
    super.dispose();
  }



  void toggleRememberMe(bool newValue) {
    setState(() {
      rememberMe = newValue;
      saveRememberMe(newValue); // Save rememberMe state

    });
  }




  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(child: 
      Stack(children:[
        // Container(
        //     decoration: BoxDecoration(
        //       image: DecorationImage(
        //         image: ExactAssetImage('lib/images/car.jpg'),
        //         fit: BoxFit.cover,
        //       ),
        //     ),
        //   ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
      Color(0xFF6C7A89), // Slate Grey
      Color(0xFFBDC3C7), // Dusty Blue
      Color(0xFFF2F4F5), 
              ],
              begin: Alignment.topLeft,end: Alignment.bottomRight),
            ),
          ),
      Column(children: [
        const SizedBox(height: 50,),

        const Icon(
          Icons.lock,
          size:100,
        ),
        const SizedBox(height: 50),

        Text(
          'welcome back'.toUpperCase(),
          style: TextStyle(color:Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w500                   
          ),
          
        ),
        const SizedBox(height: 30),
//username text field
      my_textfield(
        controller: usernameController,
        hintText: 'Username',
        obsecureText: false,

      ),
      const SizedBox(height: 10),
        
        // //password textfield
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
          children:[Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [            
            Checkbox(value: rememberMe, onChanged: (value) {
              setState((){
                  rememberMe=value!;  
                }               
              );
            },
            ),

            Text(
              'Remember me',
              style: TextStyle(color: Colors.blue),
            ),
          ],),
          
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForgotPasswordPage()),
                      );
                    },
                    child: Text(
                      'forgot passoword?',
                      style: TextStyle(color:Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

       const SizedBox(height: 10),

     

      // my_button(
      //   onTap: signUserIn,
      // ),
      
Padding(
  padding: const EdgeInsets.all(8.0),
  child: ElevatedButton(
    onPressed: () async {
      await signUserIn(
        username: usernameController.text,
        password: passwordController.text,
      );
    },
    child: Text(
      'Sign In',
      style: TextStyle(color: Colors.white),
    ),
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(
        Colors.black,
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
          
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account? ',
                    style: TextStyle(color: Colors.black),
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
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
           
            // ),
          ],
        ),
      ),

      const SizedBox(height: 50),

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            Expanded(
              child:Divider(thickness: 1,
              color: Colors.grey[400],
            ),
            ),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text('Or Continue with',
              style: TextStyle(color: Colors.grey[700]),),
            ),
        
            Expanded(
              child:Divider(thickness: 1,
              color: Colors.grey[400],
            ),)
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
          SquareTile(imagePath: 'lib/images/fb.png')
        ],
      )
      ],
      )
      ]
      )
      ),

    );
  }
}

