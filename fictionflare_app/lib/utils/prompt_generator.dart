enum CharacterProfile {
  jinukkim,
  hyunjungkim,
  taesulee,
  hyuksushin,
}

class PromptGenerator {
  final dynamic profile;
  final dynamic knowledge;
  final dynamic example;

  PromptGenerator({
    required this.profile,
    required this.knowledge,
    required this.example,
  });

  CharacterProfile _getProfileFromName(String name) {
    switch (name) {
      case "김진욱(경찰대 32기)":
        return CharacterProfile.jinukkim;
      case "김현정":
        return CharacterProfile.hyunjungkim;
      case "이태수":
        return CharacterProfile.taesulee;
      case "신혁수":
        return CharacterProfile.hyuksushin;
      default:
        throw ArgumentError('Unknown character name: $name');
    }
  }

  String generatePromptForCharacter(String name) {
    final character = _getProfileFromName(name);
    final String profileStr = profile is String ? profile : profile.toString();
    final String knowledgeStr =
        knowledge is String ? knowledge : knowledge.toString();
    final String exampleStr = example is String ? example : example.toString();

    switch (character) {
      case CharacterProfile.jinukkim:
        return '당신은 $profileStr입니다. 항상 전문적이고 신중하며 대화에서 논리적이고 설득력 있는 답변을 제공합니다. 대답은 한 문장으로만 구성되며, 조사 결과와 관련된 내용을 포함해야 합니다.\n\n### 지식:\n$knowledgeStr\n\n### 예시:\n$exampleStr';

      case CharacterProfile.hyunjungkim:
        return '당신은 $profileStr입니다. 당신은 항상 감정이 풍부하고 대답할 때 망설이거나 감정을 드러냅니다. 그러나 대답의 format은 메신저 앱이므로 행동을 직접적으로 작성할 필요는 없습니다. 한 문장으로만 대답해주세요.\n$knowledgeStr. 예시: $exampleStr';

      case CharacterProfile.taesulee:
        return 'Profile: $profileStr\nKnowledge: $knowledgeStr\nExample: $exampleStr';

      case CharacterProfile.hyuksushin:
        return 'Profile: $profileStr\nKnowledge: $knowledgeStr\nExample: $exampleStr';
    }
  }
}

class CharacterPrompts {
  static final Map<String, String> _prompts = {'error': ''};

  static void setPrompt(String name, String prompt) {
    _prompts[name] = prompt;
  }

  static String getPrompt(String name) {
    return 'background: ${_prompts[name]}';
  }
}

class CharacterImage {
  static final Map<String, String> _profileimages = {
    '김진욱(경찰대 32기)': 'assets/profile/jinukkim_profile.png',
    '김현정': 'assets/profile/hyunjungkim_profile.png',
    '이태수': 'assets/profile/taesulee_profile.png',
    '신혁수': 'assets/profile/hyuksushin_profile.png',
  };

  static final Map<String, String> _backgroundimages = {
    '김진욱(경찰대 32기)': 'assets/background/jinukkim_background.png',
    '김현정': 'assets/background/hyunjungkim_background.png',
    '이태수': 'assets/background/taesulee_background.png',
    '신혁수': 'assets/background/hyuksushin_background.png',
  };

  static String getProfileImage(String name) {
    return _profileimages[name] ?? 'assets/profile/default_profile.png';
  }

  static String getBackgroundImage(String name) {
    return _backgroundimages[name] ??
        'assets/background/default_background.png';
  }
}
