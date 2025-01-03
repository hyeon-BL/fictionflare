import 'package:fictionflare_app/hive/chat_history.dart';
import 'package:fictionflare_app/providers/chat_provider.dart';
import 'package:fictionflare_app/screens/chat_screen.dart';
import 'package:fictionflare_app/utils/prompt_generator.dart';
import 'package:fictionflare_app/utils/utils.dart';
import 'package:fictionflare_app/widgets/time_widget.dart';
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
    final name = chat.name;
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(CharacterImage.getProfileImage(name)),
        ),
        title: Text(
          chat.name,
          maxLines: 1,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          chat.response,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TimeWidget(timestamp: chat.timestamp),
          ],
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatScreen(chat: chat)),
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
