import 'package:flutter/material.dart';

class ArticleDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final article = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(title: Text(article['title'])),
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
}