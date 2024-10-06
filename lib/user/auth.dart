import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _response = '';

  // Function to handle signup and login
  Future<void> _authenticate(String action) async {
    final response = await http.post(
      Uri.parse('https://script.google.com/macros/s/AKfycbz_lPpLoPlUnbqkv-3OrlPR1PRX4UqleGf5hsmACJ8OZBVGhI5-EX-bwkYoJPJwCLT4vg/exec'),  // Replace with your Web App URL
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "action": action,
        "name": _nameController.text,
        "email": _emailController.text,
        "password": _passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      print("---------------");
      final data = jsonDecode(response.body);
    /*  if (data['error'] != null) {
        print("---------------11");
        setState(() {
          _response = data['error'];
        });
      } else {
        setState(() {
          print("---------------22");
          _response = '$action successful! Token: ${data['token']}';
        });
      }*/
    } else {
      setState(() {
        _response = 'Failed to $action';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Signup/Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => _authenticate('signup'),
                  child: Text('Signup'),
                ),
                ElevatedButton(
                  onPressed: () => _authenticate('login'),
                  child: Text('Login'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(_response),
          ],
        ),
      ),
    );
  }
}

