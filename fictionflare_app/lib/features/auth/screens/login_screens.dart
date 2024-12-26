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
            const SizedBox(height: 100),
            const Text('Enter your email to continue',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: greyColor,
                )),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: size.width * 0.6,
                  child: TextField(
                    controller: numberController,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      hintStyle: const TextStyle(color: greyColor),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tabColor,
                  ),
                  onPressed: () {},
                  child: const Text('Enter',
                      style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Color.fromRGBO(200, 200, 200, 0.8),
                ),
                onPressed: () {},
                child: Text('Join', style: TextStyle(color: Colors.black))),
            SizedBox(height: size.height / 3),
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
