import 'package:fictionflare_app/hive/boxes.dart';
import 'package:fictionflare_app/widgets/profile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/friend_list_item.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  @override
  Widget build(BuildContext context) {
    final chatHistoryBox = Boxes.getChatHistory();
    final characters = chatHistoryBox.values.toList();
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        centerTitle: true,
        title: const Text('Contacts'),
      ),
      body: Column(
        children: [
          // my profile
          ProfileCard(
            name: "Your Name",
            username: user?.email ?? "No email",
            profileImage: "https://via.placeholder.com/150",
            bio: "This is my bio description",
          ),
          const Divider(thickness: 1),

          // friends list
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: characters.length,
                itemBuilder: (context, index) {
                  final chat = characters[index];
                  return FriendListItem(
                    name: chat.name,
                    lastChat: chat.response,
                    isOnline: true,
                    chat: chat,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
