import 'package:flutter/material.dart';

class Screen3 extends StatelessWidget {
  const Screen3({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.business, size: 64, color: Colors.green),
          SizedBox(height: 12),
          Text('Business Screen', style: TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}
