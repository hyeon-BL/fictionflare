import 'package:fictionflare_app/features/auth/screens/login_screens.dart';
import 'package:fictionflare_app/screens/mobile_chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreens extends StatelessWidget {
  const AuthScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth Screens'),
      ),
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in
          if (snapshot.hasData) {
            return MobileChatScreen();
        }
          // user is not logged in
          return LoginScreen();
        },
      ),
    );
  }
}