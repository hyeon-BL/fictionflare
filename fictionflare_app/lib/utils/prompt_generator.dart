class PromptGenerator {
  final dynamic profile;
  final dynamic knowledge;
  final dynamic example;

  PromptGenerator({
    required this.profile,
    required this.knowledge,
    required this.example,
  });

  String generatePromptForCharacter(String name) {
    final String profileStr = profile is String ? profile : profile.toString();
    final String knowledgeStr = knowledge is String ? knowledge : knowledge.toString();
    final String exampleStr = example is String ? example : example.toString();

    return '당신은 $profileStr입니다. 당신은 항상 감정이 풍부하고 대답할 때 망설이거나 감정을 드러냅니다. 그러나 대답의 format은 메신저 앱이므로 행동을 직접적으로 작성할 필요는 없습니다. 한 문장으로만 대답해주세요.\n$knowledgeStr. 예시: $exampleStr';
  }
}

class CharacterPrompts {
  static final Map<String, String> _prompts = {'error': ''};
  
  static void setPrompt(String name, String prompt) {
    _prompts[name] = prompt;
  }
  
  static String getPrompt(String name) {
    return _prompts[name] ?? '';
  }
}
