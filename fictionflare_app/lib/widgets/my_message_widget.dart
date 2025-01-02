import 'package:fictionflare_app/models/message.dart';
import 'package:fictionflare_app/widgets/preview_images_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MyMessageWidget extends StatelessWidget {
  const MyMessageWidget({
    super.key,
    required this.message,
  });

  final Message message;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 203, 191, 248),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (message.imagesUrls.isNotEmpty)
                PreviewImagesWidget(message: message),
              MarkdownBody(
                selectable: true,
                data: message.message.toString(),
              ),
            ],
          ),
        ),
        SizedBox(height: 4),
        Text(
          '${message.timeSent.hour}:${message.timeSent.minute.toString().padLeft(2, '0')}',
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
      ],
    );
  }
}
