import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String _firstName = '';
  String _lastName = '';
  String _username = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter your first name';
                  return null;
                },
                onSaved: (value) {
                  _firstName = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter your last name';
                  return null;
                },
                onSaved: (value) {
                  _lastName = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter a username';
                  return null;
                },
                onSaved: (value) {
                  _username = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) return 'Please enter a valid email';
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty || value.length < 4) return 'Password must be at least 4 characters';
                  if (!RegExp(r'^[0-9]+$').hasMatch(value))
                    return 'Password must include only numbers';
                  _password = value; // Update _password here
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty || value != _password) return 'Passwords do not match';
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _register,
                child: Text('Register'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/login');
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _register() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('firstName', _firstName);
      await prefs.setString('lastName', _lastName);
      await prefs.setString('username', _username);
      await prefs.setString('email', _email);
      await prefs.setString('password', _password);
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }
}