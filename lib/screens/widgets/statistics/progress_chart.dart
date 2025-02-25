import 'package:flutter/material.dart';

class ProgressChart extends StatelessWidget {
  final Map<String, int> data;

  const ProgressChart({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text('Progress Chart - Coming Soon'),
        ),
      ),
    );
  }
}
