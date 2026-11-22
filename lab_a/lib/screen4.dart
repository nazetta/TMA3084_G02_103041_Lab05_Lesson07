import 'package:flutter/material.dart';

class Screen4 extends StatelessWidget {
  const Screen4({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.school, size: 64, color: Colors.purple),
          SizedBox(height: 12),
          Text('School Screen', style: TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}
