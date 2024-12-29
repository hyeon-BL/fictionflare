import 'package:fictionflare_app/hive/chat_history.dart';
import 'package:fictionflare_app/providers/chat_provider.dart';
import 'package:fictionflare_app/screens/chat_screen.dart';
import 'package:fictionflare_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatHistoryWidget extends StatelessWidget {
  const ChatHistoryWidget({
    super.key,
    required this.chat,
  });

  final ChatHistory chat;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: 10.0, right: 10.0),
        leading: const CircleAvatar(
          radius: 30,
          child: Icon(Icons.chat),
        ),
        title: Text(
          chat.name,
          maxLines: 1,
        ),
        subtitle: Text(
          chat.response,
          maxLines: 2,
        ),
        trailing: Text(
          chat.timestamp.toString().split(' ')[0],
          style: const TextStyle(fontSize: 12),
        ),
        onTap: () async {
          final chatProvider = context.read<ChatProvider>();
          await chatProvider.prepareChatRoom(
            isNewChat: false,
            chatID: chat.chatId,
          );
          // Add delay to ensure chat room is prepared
          await Future.delayed(const Duration(milliseconds: 100));
          if (context.mounted) {
            // Use Navigator instead of page controller
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ChatScreen()),
            );
          }
        },
        onLongPress: () {
          // show my animated dialog to delete the chat
          showMyAnimatedDialog(
            context: context,
            title: 'Delete Chat',
            content: 'Are you sure you want to delete this chat?',
            actionText: 'Delete',
            onActionPressed: (value) async {
              if (value) {
                // delete the chat
                await context
                    .read<ChatProvider>()
                    .deletChatMessages(chatId: chat.chatId);

                // delete the chat history
                await chat.delete();
              }
            },
          );
        },
      ),
    );
  }
}
