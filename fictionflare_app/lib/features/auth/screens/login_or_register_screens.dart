import 'package:fictionflare_app/features/auth/screens/login_screens.dart';
import 'package:fictionflare_app/features/auth/screens/register_screens.dart';
import 'package:flutter/material.dart';

class LoginOrRegisterScreens extends StatefulWidget {
  const LoginOrRegisterScreens({super.key});

  @override
  State<LoginOrRegisterScreens> createState() => _LoginOrRegisterScreensState();
}

class _LoginOrRegisterScreensState extends State<LoginOrRegisterScreens> {
  // initially show login screen
  bool _showLogin = true;

  // toggle between login and register screens
  void _toggleLoginRegister() {
    setState(() {
      _showLogin = !_showLogin;
    });
  }


  @override
  Widget build(BuildContext context) {
    if (_showLogin) {
      return LoginScreen(onTap: _toggleLoginRegister);
  } else {
    return RegisterScreens(onTap: _toggleLoginRegister);
  }
  }
}