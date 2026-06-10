import 'package:flutter/material.dart';

class MieZuiJuanPage extends StatelessWidget {
  const MieZuiJuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.brightness_high, size: 80, color: Color(0xFFF5C518)),
          SizedBox(height: 16),
          Text(
            '滅罪卷',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            '滅罪消業的修行法門',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}