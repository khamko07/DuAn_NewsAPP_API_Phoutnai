import 'package:flutter/material.dart';

class SavedArticlesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Saved Articles')),
      body: Center(
        child: Text('List of saved articles'),
      ),
    );
  }
}