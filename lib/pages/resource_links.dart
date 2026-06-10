import 'package:flutter/material.dart';

class ResourceLinksPage extends StatelessWidget {
  const ResourceLinksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.link, size: 80, color: Color(0xFFF5C518)),
          SizedBox(height: 16),
          Text(
            '資源連結',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            '相關佛法資源與連結',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}