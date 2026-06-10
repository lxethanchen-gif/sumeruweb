import 'package:flutter/material.dart';

class JiYuanDaoZhiPage extends StatelessWidget {
  const JiYuanDaoZhiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.self_improvement, size: 80, color: Color(0xFFF5C518)),
          SizedBox(height: 16),
          Text(
            '機緣道旨',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            '機緣與道的指引',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}