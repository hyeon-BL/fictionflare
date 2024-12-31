import 'package:fictionflare_app/colors.dart';
import 'package:fictionflare_app/common/widgets/custom_button.dart';
import 'package:fictionflare_app/features/auth/screens/auth_screens.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  void navigateToAuthScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, AuthScreens.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              const Text(
                'Welcome to FictionFlare',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: size.height / 5),
              Image.asset('assets/logo.png', width: size.width * 0.8),
              SizedBox(height: size.height / 4),
              Text('it\'s time to make your own story',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: greyColor,
                  )),
              SizedBox(height: 20),
              CustomButton(
                  text: 'Get Started',
                  onPressed: () => navigateToAuthScreen(context)),
            ],
          ),
        ),
      ),
    );
  }
}
