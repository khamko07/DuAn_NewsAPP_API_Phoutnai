import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  final List<String> categories = [
    'Sports',
    'Entertainment',
    'Politics',
    'Technology',
    'Health',
    'Science',
    'Business',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categories')),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(categories[index]),
            onTap: () {
              Navigator.of(context).pushNamed('/category', arguments: categories[index]);
            },
          );
        },
      ),
    );
  }
}