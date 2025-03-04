import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SavedArticlesScreen extends StatefulWidget {
  @override
  _SavedArticlesScreenState createState() => _SavedArticlesScreenState();
}

class _SavedArticlesScreenState extends State<SavedArticlesScreen> {
  List<dynamic> _savedArticles = [];

  @override
  void initState() {
    super.initState();
    _loadSavedArticles();
  }

  _loadSavedArticles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedArticlesJson = prefs.getString('saved_articles');
    if (savedArticlesJson != null) {
      setState(() {
        _savedArticles = jsonDecode(savedArticlesJson);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Saved Articles')),
      body: _savedArticles.isEmpty
          ? Center(child: Text('No saved articles yet.'))
          : ListView.builder(
              itemCount: _savedArticles.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_savedArticles[index]['title']),
                  subtitle: Text(_savedArticles[index]['description'] ?? 'No description'),
                );
              },
            ),
    );
  }
}