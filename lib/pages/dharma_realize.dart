import 'package:flutter/material.dart';

class DharmaRealizePage extends StatelessWidget {
  const DharmaRealizePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.menu_book, size: 80, color: Color(0xFFF5C518)),
          SizedBox(height: 16),
          Text(
            '了解佛法',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            '深入了解佛法的基本教義與修行方法',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}