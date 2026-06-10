import 'package:flutter/material.dart';

class YingShiJuanPage extends StatelessWidget {
  const YingShiJuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.auto_stories, size: 80, color: Color(0xFFF5C518)),
          SizedBox(height: 16),
          Text(
            '應世卷',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            '應世卷的教義與法要',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}