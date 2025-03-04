import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
import 'package:news_app/screens/category_news_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isDarkMode = prefs.getBool('darkMode') ?? false;
  runApp(MyApp(isDarkMode: isDarkMode));
}

class MyApp extends StatefulWidget {
  final bool isDarkMode;
  MyApp({Key? key, required this.isDarkMode}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool _isDarkMode;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
  }

  void toggleTheme(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
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
        '/settings': (context) => SettingsScreen(onThemeChanged: toggleTheme),
        '/category_news': (context) => CategoryNewsScreen(),
      },
    );
  }
}