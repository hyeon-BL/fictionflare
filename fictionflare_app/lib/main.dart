import 'package:fictionflare_app/features/landing/screens/landing_screen.dart';
import 'package:fictionflare_app/firebase_options.dart';
import 'package:fictionflare_app/router.dart';
import 'package:flutter/material.dart';
import 'package:fictionflare_app/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fictionflare_app/providers/chat_provider.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
