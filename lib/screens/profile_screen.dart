import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final prefs = snapshot.data!;
          final firstName = prefs.getString('firstName') ?? '';
          final lastName = prefs.getString('lastName') ?? '';
          final email = prefs.getString('email') ?? '';

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('First Name: $firstName', style: TextStyle(fontSize: 18)),
                Text('Last Name: $lastName', style: TextStyle(fontSize: 18)),
                Text('Email: $email', style: TextStyle(fontSize: 18)),
              ],
            ),
          );
        },
      ),
    );
  }
}