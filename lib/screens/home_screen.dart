import 'package:flutter/material.dart';
import 'package:news_app/widgets/news_list.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).pushNamed('/search');
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed('/settings');
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text('News App', style: TextStyle(fontSize: 24)),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              title: Text('Categories'),
              onTap: () {
                Navigator.of(context).pushNamed('/categories');
              },
            ),
            ListTile(
              title: Text('Saved Articles'),
              onTap: () {
                Navigator.of(context).pushNamed('/saved');
              },
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {
                Navigator.of(context).pushNamed('/profile');
              },
            ),
          ],
        ),
      ),
      body: NewsList(),
    );
  }
}