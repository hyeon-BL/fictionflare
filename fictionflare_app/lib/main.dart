import 'package:fictionflare_app/features/landing/screens/landing_screen.dart';
import 'package:fictionflare_app/firebase_options.dart';
import 'package:fictionflare_app/router.dart';
import 'package:flutter/material.dart';
import 'package:fictionflare_app/colors.dart';
import 'package:fictionflare_app/screens/mobile_layout_screen.dart';
import 'package:fictionflare_app/screens/web_layout_screen.dart';
import 'package:fictionflare_app/utils/responsive_layout.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FictionFlare',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: appBarColor,
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const LandingScreen(),
    );
  }
}
