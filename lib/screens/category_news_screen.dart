import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoryNewsScreen extends StatefulWidget {
  @override
  _CategoryNewsScreenState createState() => _CategoryNewsScreenState();
}

class _CategoryNewsScreenState extends State<CategoryNewsScreen> {
  List<dynamic> _articles = [];
  bool _isLoading = true;
  String _errorMessage = '';
  String _category = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get the category from the route arguments
    _category = ModalRoute.of(context)!.settings.arguments as String;
    _fetchCategoryNews(_category);
  }

  Future<void> _fetchCategoryNews(String category) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    // You'll need to get an API key from newsapi.org
    final apiKey = 'cd5b0eec1871449d9c3d9f6f0cb2e027'; // Replace with your actual API key
    final url = 'https://newsapi.org/v2/top-headlines?country=us&category=${category.toLowerCase()}&apiKey=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _articles = data['articles'];
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load news. Please try again later.';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$_category News'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => _fetchCategoryNews(_category),
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))
              : _articles.isEmpty
                  ? Center(child: Text('No news articles found for this category'))
                  : RefreshIndicator(
                      onRefresh: () => _fetchCategoryNews(_category),
                      child: ListView.builder(
                        itemCount: _articles.length,
                        itemBuilder: (context, index) {
                          final article = _articles[index];
                          return Card(
                            margin: EdgeInsets.all(8),
                            child: Column(
                              children: [
                                if (article['urlToImage'] != null)
                                  Image.network(
                                    article['urlToImage'],
                                    width: double.infinity,
                                    height: 200,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      height: 200,
                                      color: Colors.grey[200],
                                      child: Icon(Icons.broken_image),
                                    ),
                                  ),
                                ListTile(
                                  contentPadding: EdgeInsets.all(16),
                                  title: Text(
                                    article['title'] ?? 'No title',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 8),
                                      Text(article['description'] ?? 'No description'),
                                      SizedBox(height: 8),
                                      Text(
                                        'Source: ${article['source']['name'] ?? 'Unknown'}',
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    // Navigate to article details
                                    Navigator.of(context).pushNamed(
                                      '/article',
                                      arguments: article,
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
    );
  }
}