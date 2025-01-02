import 'package:fictionflare_app/widgets/profile_card.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        centerTitle: true,
        title: const Text('Contacts'),
      ),
      body: Column(
        children: [
          // my profile
          const ProfileCard(
            name: "Your Name",
            username: "@yourusername",
            profileImage: "https://via.placeholder.com/150",
            bio: "This is my bio description",
          ),
          const Divider(thickness: 1),

          // friends list
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: 10, // Replace with actual friend count
                itemBuilder: (context, index) {
                  return const FriendListItem(
                    name: "John Doe",
                    username: "@johndoe",
                    lastSeen: "last seen recently",
                    isOnline: true,
                    profileImage: "https://via.placeholder.com/150",
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
