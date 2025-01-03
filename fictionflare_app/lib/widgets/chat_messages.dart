import 'package:fictionflare_app/hive/boxes.dart';
import 'package:fictionflare_app/models/message.dart';
import 'package:fictionflare_app/providers/chat_provider.dart';
import 'package:fictionflare_app/widgets/assistance_message_widget.dart';
import 'package:fictionflare_app/widgets/my_message_widget.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({
    super.key,
    required this.scrollController,
    required this.chatProvider,
  });

  final ScrollController scrollController;
  final ChatProvider chatProvider;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: chatProvider.inChatMessages.length,
      itemBuilder: (context, index) {
        // compare with timeSent bewfore showing the list
        final message = chatProvider.inChatMessages[index];
        final name = Boxes.getChatHistory().get(message.chatId)?.name ?? '';
        return message.role.name == Role.user.name
            ? MyMessageWidget(message: message)
            : AssistantMessageWidget(
                message: message.message.toString(),
                timestamp: message.timeSent,
                name: name,
              );
      },
    );
  }
}
