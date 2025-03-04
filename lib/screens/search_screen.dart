import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search articles...',
            border: InputBorder.none,
          ),
          onSubmitted: (query) {
            Navigator.of(context).pushNamed('/search_results', arguments: query);
          },
        ),
      ),
      body: Center(
        child: Text('Search for articles'),
      ),
    );
  }
}