import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Remember Me Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadRememberMeStatus();
  }

  _loadRememberMeStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _rememberMe = (prefs.getBool('rememberMe') ?? false);
      if (_rememberMe) {
        _usernameController.text = (prefs.getString('username') ?? '');
        _passwordController.text = (prefs.getString('password') ?? '');
      }
    });
  }

 _saveRememberMeStatus(bool? value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _rememberMe = value ?? false; // default to false if value is null
      prefs.setBool('rememberMe', _rememberMe);
      if (!_rememberMe) {
        prefs.remove('username');
        prefs.remove('password');
      }
    });
  }


  _login() {
    // Perform login authentication here
    String username = _usernameController.text;
    String password = _passwordController.text;

    // For demonstration, we'll just print the username and password
    print('Username: $username');
    print('Password: $password');

    // Save username and password if Remember Me is checked
    if (_rememberMe) {
      SharedPreferences.getInstance().then((prefs) {
        prefs.setString('username', username);
        prefs.setString('password', password);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            Row(
              children: <Widget>[
                Checkbox(
                  value: _rememberMe,
                  onChanged: _saveRememberMeStatus,
                ),
                Text('Remember Me'),
              ],
            ),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
