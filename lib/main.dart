import 'package:flutter/material.dart';
import 'package:news_app/screens/splash_screen.dart';
import 'package:news_app/screens/onboarding_screen.dart';
import 'package:news_app/screens/register_screen.dart';
import 'package:news_app/screens/login_screen.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/category_screen.dart';
import 'package:news_app/screens/search_screen.dart';
import 'package:news_app/screens/article_details_screen.dart';
import 'package:news_app/screens/saved_articles_screen.dart';
import 'package:news_app/screens/profile_screen.dart';
import 'package:news_app/screens/settings_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/onboarding': (context) => OnboardingScreen(),
        '/register': (context) => RegisterScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/categories': (context) => CategoryScreen(),
        '/search': (context) => SearchScreen(),
        '/article': (context) => ArticleDetailsScreen(),
        '/saved': (context) => SavedArticlesScreen(),
        '/profile': (context) => ProfileScreen(),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}