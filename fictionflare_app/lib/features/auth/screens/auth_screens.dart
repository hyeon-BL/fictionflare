import 'package:fictionflare_app/features/auth/screens/login_screens.dart';
import 'package:fictionflare_app/screens/mobile_chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreens extends StatelessWidget {
  static const routeName = '/auth-screens';
  const AuthScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Show loading indicator while waiting
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // User is logged in
        if (snapshot.hasData) {
          return const MobileChatScreen();
        }

        // User is not logged in
        return LoginScreen();
      },
    );
  }
}
