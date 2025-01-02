import 'package:fictionflare_app/hive/chat_history.dart';
import 'package:fictionflare_app/providers/chat_provider.dart';
import 'package:fictionflare_app/utils/utils.dart';
import 'package:fictionflare_app/widgets/bottom_chat_field.dart';
import 'package:fictionflare_app/widgets/chat_messages.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final ChatHistory chat;
  const ChatScreen({super.key, required this.chat});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // scroll controller
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients &&
          _scrollController.position.maxScrollExtent > 0.0) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, chatProvider, child) {
        if (chatProvider.inChatMessages.isNotEmpty) {
          _scrollToBottom();
        }

        // auto scroll to bottom on new message
        chatProvider.addListener(() {
          if (chatProvider.inChatMessages.isNotEmpty) {
            _scrollToBottom();
          }
        });

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            centerTitle: true,
            title: Text(widget.chat.name),
            actions: [
              if (chatProvider.inChatMessages.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    child: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () async {
                        // show my animated dialog to start new chat
                        showMyAnimatedDialog(
                          context: context,
                          title: 'Start New Chat',
                          content:
                              'Do you want to start a new chat with ${widget.chat.name}?',
                          actionText: 'Yes',
                          onActionPressed: (value) async {
                            if (value) {
                              // prepare chat room
                              await chatProvider.prepareChatRoom(
                                  isNewChat: true, chatID: widget.chat.chatId);
                            }
                          },
                        );
                      },
                    ),
                  ),
                )
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: chatProvider.inChatMessages.isEmpty
                        ? const Center(
                            child: Text('No messages yet'),
                          )
                        : ChatMessages(
                            scrollController: _scrollController,
                            chatProvider: chatProvider,
                          ),
                  ),

                  // input field
                  BottomChatField(
                    chatProvider: chatProvider,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
