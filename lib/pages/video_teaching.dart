import 'package:flutter/material.dart';

class VideoTeachingsPage extends StatelessWidget {
  const VideoTeachingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.play_circle_fill, size: 80, color: Color(0xFFF5C518)),
          SizedBox(height: 16),
          Text(
            '影音開示',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            '佛法影音教學資源',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}