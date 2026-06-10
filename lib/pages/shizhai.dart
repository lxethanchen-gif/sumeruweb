import 'package:flutter/material.dart';

class ShiZhaiPage extends StatelessWidget {
  const ShiZhaiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.format_quote, size: 80, color: Color(0xFFF5C518)),
          SizedBox(height: 16),
          Text(
            '詩摘',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            '佛法詩偈精選',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}