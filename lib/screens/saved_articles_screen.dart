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

  _removeArticle(int index) async {
    setState(() {
      _savedArticles.removeAt(index);
    });
    
    // Save updated list back to SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('saved_articles', jsonEncode(_savedArticles));
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Article removed from saved list')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Articles'),
        actions: [
          if (_savedArticles.isNotEmpty)
            IconButton(
              icon: Icon(Icons.delete_sweep),
              onPressed: () async {
                // Clear all saved articles
                setState(() {
                  _savedArticles = [];
                });
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('saved_articles');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('All saved articles cleared')),
                );
              },
            ),
        ],
      ),
      body: _savedArticles.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bookmark_border, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No saved articles yet.',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Articles you save will appear here',
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _savedArticles.length,
              itemBuilder: (context, index) {
                final article = _savedArticles[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image if available
                      if (article['urlToImage'] != null)
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          child: Image.network(
                            article['urlToImage'],
                            width: double.infinity,
                            height: 180,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => 
                                Container(
                                  height: 100, 
                                  color: Colors.grey[200],
                                  child: Center(child: Icon(Icons.image_not_supported)),
                                ),
                          ),
                        ),
                        
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              article['title'] ?? 'No title',
                              style: TextStyle(
                                fontSize: 18, 
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              article['description'] ?? 'No description available',
                              style: TextStyle(fontSize: 14),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(
                                      '/article', 
                                      arguments: article
                                    );
                                  },
                                  child: Text('Read More'),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete_outline, color: Colors.red),
                                  onPressed: () => _removeArticle(index),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}