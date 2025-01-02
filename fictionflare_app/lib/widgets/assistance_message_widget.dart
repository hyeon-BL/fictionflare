import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AssistantMessageWidget extends StatelessWidget {
  const AssistantMessageWidget({
    super.key,
    required this.message,
    required this.timestamp,
  });

  final String message;
  final DateTime timestamp;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage('assets/default_profile.png'),
          radius: 16,
        ),
        SizedBox(width: 8),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(12),
                child: message.isEmpty
                    ? const SizedBox(
                        width: 50,
                        child: SpinKitThreeBounce(
                          color: Colors.blueGrey,
                          size: 20.0,
                        ),
                      )
                    : MarkdownBody(
                        selectable: true,
                        data: message,
                      ),
              ),
              SizedBox(height: 4),
              Text(
                '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
        SizedBox(width: 40),
      ],
    );
  }
}
