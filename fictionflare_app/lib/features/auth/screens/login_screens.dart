import 'package:fictionflare_app/colors.dart';
import 'package:fictionflare_app/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final numberController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    numberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter your credentials'),
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const Text('you need to be verified to start',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: greyColor,
                )),
            const SizedBox(height: 20),
            IntrinsicWidth(
              child: TextButton(
                onPressed: () {},
                child: Text('Pick Country'),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: size.width * 0.6,
                  child: TextField(
                    controller: numberController,
                    decoration: InputDecoration(
                      hintText: 'Enter your detective number',
                      hintStyle: const TextStyle(color: greyColor),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Verify'),
                ),
              ],
            ),
            SizedBox(height: size.height / 2),
            SizedBox(
              width: 150,
              child: CustomButton(text: 'Next', onPressed: () {}),
            )
          ],
        ),
      ),
    );
  }
}
