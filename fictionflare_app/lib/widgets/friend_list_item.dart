import 'package:fictionflare_app/hive/chat_history.dart';
import 'package:fictionflare_app/screens/profile_screen.dart';
import 'package:fictionflare_app/utils/prompt_generator.dart';
import 'package:flutter/material.dart';

class FriendListItem extends StatelessWidget {
  final String name;
  final String lastChat;
  final bool isOnline;
  final ChatHistory chat;

  const FriendListItem({
    super.key,
    required this.name,
    required this.lastChat,
    required this.isOnline,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Stack(
          children: [
            Hero(
              tag: 'profile-$name',
              child: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(CharacterImage.getProfileImage(name)),
              ),
            ),
            if (isOnline)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      width: 2,
                    ),
                  ),
                ),
              ),
          ],
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          lastChat,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileScreen(name: name),
            ),
          );
        },
      ),
    );
  }
}
