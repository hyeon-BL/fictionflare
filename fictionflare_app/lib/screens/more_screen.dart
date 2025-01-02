import 'dart:developer';
import 'dart:io';
import 'package:fictionflare_app/hive/boxes.dart';
import 'package:fictionflare_app/hive/settings.dart';
import 'package:fictionflare_app/providers/settings_provider.dart';
import 'package:fictionflare_app/widgets/settings_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  File? file;
  String userImage = '';
  // String userName = 'Dexter';
  final ImagePicker _picker = ImagePicker();

  // pick an image
  void pickImage() async {
    try {
      final pickedImage = await _picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 800,
        maxWidth: 800,
        imageQuality: 95,
      );
      if (pickedImage != null) {
        setState(() {
          file = File(pickedImage.path);
        });
      }
    } catch (e) {
      log('error : $e');
    }
  }

  // get user data
  void getUserData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // get user data fro box
      final userBox = Boxes.getUser();

      // check is user data is not empty
      if (userBox.isNotEmpty) {
        final user = userBox.getAt(0);
        setState(() {
          userImage = user!.name;
          // userName = user.image;
        });
      }
    });
  }

  void logOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);

      // clear the user box
      final userBox = Boxes.getUser();
      userBox.clear();

      // clear the settings box
      final settingsBox = Boxes.getSettings();
      settingsBox.clear();

      // clear the chat history box
      final chatHistoryBox = Boxes.getChatHistory();
      chatHistoryBox.clear();
    }
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          centerTitle: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          actions: [
            IconButton(
              icon: const Icon(Icons.logout_rounded),
              onPressed: () => logOut(context),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                    // child: BuildDisplayImage(
                    //     file: file,
                    //     userImage: userImage,
                    //     onPressed: () {
                    //       // open camera or gallery
                    //       pickImage();
                    //     }),
                    ),

                const SizedBox(height: 20.0),

                // user name
                // Text(userName, style: Theme.of(context).textTheme.titleLarge),

                const SizedBox(height: 40.0),

                ValueListenableBuilder<Box<Settings>>(
                    valueListenable: Boxes.getSettings().listenable(),
                    builder: (context, box, child) {
                      if (box.isEmpty) {
                        return Column(
                          children: [
                            // ai voice
                            SettingsTile(
                                icon: Icons.mic,
                                title: 'Enable AI voice',
                                value: false,
                                onChanged: (value) {
                                  final settingProvider =
                                      context.read<SettingsProvider>();
                                  settingProvider.toggleSpeak(
                                    value: value,
                                  );
                                }),

                            const SizedBox(height: 10.0),

                            // theme
                            SettingsTile(
                                icon: Icons.light_mode,
                                title: 'Theme',
                                value: false,
                                onChanged: (value) {
                                  final settingProvider =
                                      context.read<SettingsProvider>();
                                  settingProvider.toggleDarkMode(
                                    value: value,
                                  );
                                }),
                          ],
                        );
                      } else {
                        final settings = box.getAt(0);
                        return Column(
                          children: [
                            // ai voice
                            SettingsTile(
                                icon: Icons.mic,
                                title: 'Enable AI voice',
                                value: settings!.shouldSpeak,
                                onChanged: (value) {
                                  final settingProvider =
                                      context.read<SettingsProvider>();
                                  settingProvider.toggleSpeak(
                                    value: value,
                                  );
                                }),

                            const SizedBox(height: 10.0),

                            // theme
                            SettingsTile(
                                icon: settings.isDarkTheme
                                    ? Icons.dark_mode
                                    : Icons.light_mode,
                                title: 'Theme',
                                value: settings.isDarkTheme,
                                onChanged: (value) {
                                  final settingProvider =
                                      context.read<SettingsProvider>();
                                  settingProvider.toggleDarkMode(
                                    value: value,
                                  );
                                }),
                          ],
                        );
                      }
                    })
              ],
            ),
          ),
        ));
  }
}
