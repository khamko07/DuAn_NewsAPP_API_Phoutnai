import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ArticleDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final article = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(article['title']),
        actions: [
          IconButton(
            icon: Icon(Icons.save, color: Colors.white),
            onPressed: () async {
              await _saveArticle(context, article);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () async {
          await _saveArticle(context, article);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(article['title'], style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            article['urlToImage'] != null
                ? Image.network(
                    article['urlToImage'],
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  )
                : Container(),
            SizedBox(height: 20),
            Text(article['content'] ?? 'No content available'),
          ],
        ),
      ),
    );
  }
  
  Future<void> _saveArticle(BuildContext context, Map<String, dynamic> article) async {
    print('Save article: ${article['title']}');
    
    // Get the SharedPreferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    // Get the current list of saved articles (if any)
    String? savedArticlesJson = prefs.getString('saved_articles');
    List<dynamic> savedArticles = savedArticlesJson != null
        ? jsonDecode(savedArticlesJson)
        : [];
    
    // Add the current article to the list
    savedArticles.add(article);
    
    // Save the updated list back to SharedPreferences
    prefs.setString('saved_articles', jsonEncode(savedArticles));
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Article saved!'),
      ),
    );
  }
}