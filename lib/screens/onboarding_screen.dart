import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Image.network(
            'https://scontent.fdad7-2.fna.fbcdn.net/v/t39.30808-6/475207667_1028228862670286_6288073128008475261_n.jpg?stp=cp6_dst-jpg_tt6&_nc_cat=105&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeFgcLFrSAqSytSK6gOsBiKYyrULtk9TtsDKtQu2T1O2wKU6SV6P4nJ8OfNJEpFD2YSw_U0UOXhp7VVK3lxTTz8a&_nc_ohc=syp2JV2MrgUQ7kNvgETc2a6&_nc_oc=Adi1WxD5VGn0nuPCbCnrjK9TDT7Opt02Ac_2J0KppwE5yZ7-sJGgB6JV48P-MyfNTfc&_nc_zt=23&_nc_ht=scontent.fdad7-2.fna&_nc_gid=ABmWhhxC2Zuvrh0tVYEOYJw&oh=00_AYCUReK_3ICpAQdgM0suVfUvkrpguATUh_3mi5TSQ6NQEA&oe=67CCDA14',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to News UED',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Ensure text is visible on the background
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'Stay updated with the latest news from around the world. Customize your news feed and save articles for later reading.',
                  style: TextStyle(fontSize: 16, color: Colors.white), // Ensure text is visible
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
        ],
      ),
    );
  }
}