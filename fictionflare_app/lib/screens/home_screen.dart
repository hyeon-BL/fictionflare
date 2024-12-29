import 'package:fictionflare_app/providers/chat_provider.dart';
import 'package:fictionflare_app/screens/chat_history_screen.dart';
import 'package:fictionflare_app/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // list of screens
  final List<Widget> _screens = [
    const ProfileScreen(),
    // const ChatScreen(),
    const ChatHistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, chatProvider, child) {
        return Scaffold(
            body: PageView(
              controller: chatProvider.pageController,
              children: _screens,
              onPageChanged: (index) {
                chatProvider.setCurrentIndex(newIndex: index);
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: chatProvider.currentIndex,
              elevation: 0,
              selectedItemColor: Theme.of(context).colorScheme.primary,
              onTap: (index) {
                chatProvider.setCurrentIndex(newIndex: index);
                chatProvider.pageController.jumpToPage(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat_bubble_rounded),
                  label: 'Chatting',
                ),
                // BottomNavigationBarItem(
                //   icon: Icon(Icons.chat),
                //   label: 'Chat',
                // ),
              ],
            ));
      },
    );
  }
}
