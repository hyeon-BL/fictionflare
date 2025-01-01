import 'dart:convert';
import 'package:fictionflare_app/constants.dart';
import 'package:fictionflare_app/hive/chat_history.dart';
import 'package:fictionflare_app/hive/settings.dart';
import 'package:fictionflare_app/hive/user_model.dart';
import 'package:fictionflare_app/utils/prompt_generator.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class Boxes {
  // get the caht history box
  static Box<ChatHistory> getChatHistory() =>
      Hive.box<ChatHistory>(Constants.chatHistoryBox);

  // get user box
  static Box<UserModel> getUser() => Hive.box<UserModel>(Constants.userBox);

  // get settings box
  static Box<Settings> getSettings() =>
      Hive.box<Settings>(Constants.settingsBox);

  static Future<void> initializeDefaultChats() async {
    final box = getChatHistory();
    if (box.isEmpty) {
      // Load character profile from JSON
      String jsonString =
          await rootBundle.loadString('assets/character_profile.json');
      Map<String, dynamic> characterProfiles = json.decode(jsonString);

      for (var entry in characterProfiles.entries) {
        final String name = entry.key;
        final Map<String, dynamic> profile = entry.value;
        
        // Make sure these fields exist in your JSON
        final identity = profile['identity'] ?? '';
        final knowledge = profile['knowledge'] ?? '';
        final example = profile['example'] ?? '';

        final prompt = PromptGenerator(
            profile: identity,
            knowledge: knowledge,
            example: example);

        final chatId = const Uuid().v4();
        final chat = ChatHistory(
          name: name,
          chatId: chatId,
          prompt: prompt.generatePrompt(),
          response: "안녕하세요, 저는 $name입니다.", // Default greeting
          imagesUrls: [],
          timestamp: DateTime.now(),
        );

        await box.put(chatId, chat);
      }
    }
  }

  // ...existing code...
}
