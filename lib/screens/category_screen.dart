import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {'name': 'Sports', 'icon': Icons.sports_basketball, 'color': Colors.orange},
    {'name': 'Entertainment', 'icon': Icons.movie, 'color': Colors.purple},
    {'name': 'Politics', 'icon': Icons.gavel, 'color': Colors.blue},
    {'name': 'Technology', 'icon': Icons.computer, 'color': Colors.cyan},
    {'name': 'Health', 'icon': Icons.health_and_safety, 'color': Colors.green},
    {'name': 'Science', 'icon': Icons.science, 'color': Colors.amber},
    {'name': 'Business', 'icon': Icons.business, 'color': Colors.indigo},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categories')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.1,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  '/category_news', 
                  arguments: categories[index]['name']
                );
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      categories[index]['icon'],
                      size: 50,
                      color: categories[index]['color'],
                    ),
                    SizedBox(height: 12),
                    Text(
                      categories[index]['name'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}