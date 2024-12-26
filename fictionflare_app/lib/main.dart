import 'package:fictionflare_app/features/landing/screens/landing_screen.dart';
import 'package:fictionflare_app/firebase_options.dart';
import 'package:fictionflare_app/providers/settings_provider.dart';
import 'package:fictionflare_app/router.dart';
import 'package:fictionflare_app/themes/dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fictionflare_app/providers/chat_provider.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Hive
  await Hive.initFlutter();
  await ChatProvider.initHive();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ChatProvider()),
    ChangeNotifierProvider(create: (context) => SettingsProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    setTheme();
    super.initState();
  }

  void setTheme() {
    final settingsProvider = context.read<SettingsProvider>();
    settingsProvider.getSavedSettings();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FictionFlare',
        theme: context.watch<SettingsProvider>().isDarkMode
            ? darkTheme
            : lightTheme,
        onGenerateRoute: (settings) => generateRoute(settings),
        home: const LandingScreen(),
      ),
    );
  }
}
