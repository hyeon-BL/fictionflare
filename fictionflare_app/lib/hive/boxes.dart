import 'package:fictionflare_app/constants.dart';
import 'package:fictionflare_app/hive/chat_history.dart';
import 'package:fictionflare_app/hive/settings.dart';
import 'package:fictionflare_app/hive/user_model.dart';
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

  static const defaultCharacters = [
    {'name': 'Character 1', 'greeting': 'Hello, I am Character 1'},
    {'name': 'Character 2', 'greeting': 'Hi there, I am Character 2'},
    {'name': 'Character 3', 'greeting': 'Greetings, I am Character 3'},
  ];

  static Future<void> initializeDefaultChats() async {
    final box = getChatHistory();
    if (box.isEmpty) {
      for (var character in defaultCharacters) {
        final chatId = const Uuid().v4();
        final chat = ChatHistory(
          name: character['name']!,
          chatId: chatId,
          prompt: character['name']!,
          response: character['greeting']!,
          imagesUrls: [],
          timestamp: DateTime.now(),
        );
        await box.put(chatId, chat);
      }
    }
  }
}