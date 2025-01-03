import 'package:flutter/material.dart';

class TimeWidget extends StatelessWidget {
  final DateTime timestamp;
  final double fontSize;
  final Color? color;

  const TimeWidget({
    super.key,
    required this.timestamp,
    this.fontSize = 12,
    this.color,
  });

  String _formatTime() {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays == 0) {
      // Today: show hour:minute
      return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays == 1) {
      // Yesterday
      return 'Yesterday';
    } else {
      // Over 2 days ago: show month and day
      return '${timestamp.month}/${timestamp.day}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatTime(),
      style: TextStyle(
        fontSize: fontSize,
        color: color ?? Colors.grey[600],
      ),
    );
  }
}
