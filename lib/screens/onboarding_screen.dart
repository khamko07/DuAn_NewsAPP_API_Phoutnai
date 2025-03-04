import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to News App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Stay updated with the latest news from around the world. Customize your news feed and save articles for later reading.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/register');
              },
              child: Text('Register'),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/login');
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}