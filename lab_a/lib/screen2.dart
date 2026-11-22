import 'package:flutter/material.dart';

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.alarm, size: 64, color: Colors.orange),
          SizedBox(height: 12),
          Text('Alarm Screen', style: TextStyle(fontSize: 24)),
        ],
      ),
    );
  }
}
