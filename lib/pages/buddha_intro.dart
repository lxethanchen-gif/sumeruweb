import 'package:flutter/material.dart';

class BuddhaIntroPage extends StatelessWidget {
  const BuddhaIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person, size: 80, color: Color(0xFFF5C518)),
          SizedBox(height: 16),
          Text(
            '諦深佛陀簡介',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            '關於諦深佛陀的生平與教化',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}