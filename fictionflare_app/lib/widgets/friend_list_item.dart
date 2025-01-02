import 'package:flutter/material.dart';

class FriendListItem extends StatelessWidget {
  final String name;
  final String username;
  final String lastSeen;
  final bool isOnline;
  final String profileImage;

  const FriendListItem({
    super.key,
    required this.name,
    required this.username,
    required this.lastSeen,
    required this.isOnline,
    required this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Stack(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(profileImage),
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
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(username),
            Text(
              lastSeen,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
        onTap: () {
          // TODO: Implement friend profile view or chat initiation
        },
        onLongPress: () {
          // TODO: Implement additional options menu
        },
      ),
    );
  }
}
