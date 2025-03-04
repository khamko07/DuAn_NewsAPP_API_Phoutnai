import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsList extends StatefulWidget {
  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  List _articles = [];

  @override
  void initState() {
    super.initState();
    _fetchArticles();
  }

  _fetchArticles() async {
    final response = await http.get(Uri.parse('https://newsapi.org/v2/top-headlines?country=us&apiKey=cd5b0eec1871449d9c3d9f6f0cb2e027'));
    if (response.statusCode == 200) {
      setState(() {
        _articles = json.decode(response.body)['articles'];
      });
    } else {
      throw Exception('Failed to load articles');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _articles.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_articles[index]['title']),
          subtitle: Text(_articles[index]['description']),
          onTap: () {
            Navigator.of(context).pushNamed('/article', arguments: _articles[index]);
          },
        );
      },
    );
  }
}