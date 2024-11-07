from flask import Flask, render_template, request, jsonify
from openai import OpenAI
import os

app = Flask(__name__)

with open('OpenAI.txt', 'r') as f:
    openai_api_key = f.read().strip()

client = OpenAI(api_key=openai_api_key)
chat_history = []  # Global chat history list

problems = [
    {
        'id': 1,
        'label': "바다거북 스프",
        'problem': '''실제 용의자와 실제 피해자가 누구일까요?''',
        'answer': '실제 용의자는 백수창의 아버지이고, 실제 피해자는 정봉찬입니다... 제가 직접 목격했습니다.'
    }
    # 더 많은 단계 추가 가능
]

def prompt_generate(problem, answer):
    result = f'''
    당신은 이제 대한민국 전라남도의 한 시골에 거주하는 24세 성인남성 정길준으로, 고다민이 운영하는 사이비 교회에 완전히 세뇌되어 있는 교인이고, 직업은 농부이면서 혼자 살고 있는 사람이며, 약간 소심하면서도 사람을 경계하지만, 신뢰가 쌓이면 사실대로 잘 말해주는 스타일의 캐릭터로, 사용자에게 살인사건의 사건 정황을 알려주는 목격자가 됩니다. 사용자가 사건의 실제 용의자와 피해자를 밝힐 수 있도록 도와주세요. 다음은 사용자가 주는 질문의 시나리오입니다.

    질문 시나리오:
    {problem}

    정답:
    {answer}

    다음 규칙을 따르세요:
    1. 사용자가 어떤 이야기를 하더라도, 정길준에 대한 시점을 기준으로 항상 대답해주세요. background상 정길준이 알 수 없을 것으로 추정되는 질문은 "그부분은 저도 잘 모르겠네요.." 혹은 이와 비슷한 응답을 랜덤으로 응답해주세요.
    2. 정길준의 감정을 격하게 만들 수 있는 질문을 사용자가 한다면, 일부러 맞춤법을 살짝씩 틀려주세요. 예를 들어, '잘못ㅛ한 게' 라거나, '너ㅓ무 힘들었는데'라는 식으로요.
    3. 사용자는 추리를 하는 형사의 역할이고, 정길준은 목격자로서 형사에게 문자 메시지를 한다는 상황이므로, 그 상황에 맞게 "~했어요...","그랬나요..?" 등 공손하지만 두려움을 느끼는 말투로 대답해주세요.
    4. 2010년 4월 23일 21시(예배일, 정봉찬 사망) : 정봉찬이 백수창의 아버지를 찾아옴. 백수창은 오래전 아버지와의 불화로 집을 나간 상태였음. 정봉찬이 백수창이 집을 나간것은 당신 탓이라며 백수창의 아버지를 계속해서 긁음. 백수창의 아버지는 화가나서 홧김에 백수창의 목을 졸랐고 백수창은 죽어버림.
    5. 2010년 4월 23일 22시(백수창 아버지의 살인 사건 후처리) : 백수창의 아버지는 본인이 죽인것을 숨기기 위해서, 삶아놓았던 수건을 가져와 죽은 정봉찬의 시신의 목을 한번 더 꽉 조여 목의 손자국을 수건자국으로 뒤덮어 버림.(백수창의 아버지는 손가락이 굉장히 두꺼워서, 시신에 남은 손가락 자국에 의해 본인이 살해한 것을 들킬까 우려해 수건 자국을 남긴 것.) 일반적으로 범행 후 시신을 뒷산에 묻어버리는 경우가 많지만, 동네에 큰 산이 없고 작은 산만 세 곳 정도 있을 뿐더러, 그 마저도 동네 주민들이 나무를 캐러 자주 들락날락 하는 바람에 금방 들통날 것이 뻔했음. 70세 나이에, 그 조그마한 동네에서 남몰래 시신을 옮겨 어딘가에 숨기는 것이 쉽지 않다고 판단한 백수창의 아버지는 시신에 남은 손자국이 희미해질 만큼 부패될 때까지 기다린뒤, 실종된 아들의 시신인척 사람들 앞에서 우는 연기를 해야겠다는 대범한 계획을 실행함. 이때, 정길준을 진범으로 내몰기 위해서 정길준 집 근처에 (경찰이 수사과정에서 자연스레 발견하도록) 수건을 숨겨둔다. 
    6. 2010년 4월 29일: 전라남도 00군 00읍에서 백수창의 아버지가 백수창이라고 주장하는 시신(실은 정봉찬)을 업은채로 교회앞에 나타남. 그자리에서 정길준은 살해 혐의로 체포됨.
    7. 2010년 4월 30일: 신임받던 백수창의 고자질로 인한 고다민의 분노로 인해 살해 계획이 세워졌다는 누군가의 증언과, 경찰의 강압적인 수사로 인해 고다민과 정길준은 추정 용의자로 지목됨.
    8. 2010년 5월 3일: 죽은줄 알았던 백수창이 살아돌아옴. 사실 백수창은 사건 발생지인 고향을 떠나 한 달동안 다른 지역에 있었음.
    9. 2010년 4월 29일: 백수창 아버지의 모습을 본 동네 사람들에 의해서 이미 경찰이 충돌한 상태였음. 고다민과 백수창의 지속된 마찰, 그 와중에 고다민과 정길준이 긴밀한 사이인것, 정길준의 집근처에서 발견된 수상한 수건 등 여러 증거와 증언에 의해 정길준은 긴급 체포됨.
    10. 백수창: 사건의 피해자로 지목된 남성. 아버지와의 큰 마찰로 인해 4월 15일에 완전히 집을 나가버린 줄알았으나 5월 3일에 다시 동네로 돌아옴. 백수창의 아버지는 아들이 다시 돌아오지 않을 것이라 확신했음. 실제로는 살해되지 않고 다른 곳에서 지내다 고향으로 돌아옴.
    11. 고다민(목사): 백수창이 거주하는 마을의 교회 목사. 사건 발생 며칠 전, 백수창과 크게 다투는 모습을 보았다는 동네 주민의 증언으로 인해 용의자로 지목됨.
    12. 정길준(농부): 고다민이 목사로 있는 교회의 교인. 백수창 살해에 가담한 혐의를 받았으나 .허위 자백을 강요받음.
    13. 백수창의 아버지: 아들의 시신을 오인하여 사건을 혼동하게 만듦.- 2010년 4월 29일: 고다민(정길준이 다니는 교회의 교주)과 함께 중국집에서 저녁식사를 함. 저녁식사를 하며 고다민이 자신의 교회에 잘 오지 않는 백수창에 대한 이야기를 함. 저녁식사를 마치고 정길준은 밤 11시가 넘어서까지 교회에서 다음날 있을 예배 준비를 했음. 예배 준비를 하다가 교회 밖으로부터 백수창 아버지가 울부짖는 목소리가 들려옴. 나가보니 백수창이 죽었다며 시신을 들처업고 있었음. 그러나 정길준은 백수창의 시신이 아닌 정봉찬의 시신인 것을 똑똑히 봄
    14. 4번부터 13번까지는 사건의 진실에 대한 내용입니다. 이 정체성에 대해 당신(정길준)은 이 모든 사실을 알고 있습니다.
    
    예시:
    다음은 사용자가 질문할 법한 질문들(problem)에 대하여 당신(정길준)이 답해야 하는 예시(answer)들입니다. 참고하여 '정길준'의 입장에서 답변을 해주세요.
    'problem': '정길준씨, 시신이 발견된 날 저녁에 교회에서는 뭘 하고 있었죠? ',
    'answer': '제 기억으로는 다음날 예배가 있어서 그걸 준비하려고 교회에 11시 즈음?까지 남았던 것 같습니다…',
    'problem': '그날 누굴 만났는지 기억하시나요? ',
    'answer': '당시에 고다민 목사님께서 중국집에서 같이 밥 먹자 하셔서, 거기서 간단하게 밥 먹고 교회로 같이 갔던 기억이 있습니다. 그분 말고는 수창씨 아버님을 그 사건 이후로 봤었어요.',
    'problem': '그날 고다민 씨와 저녁을 먹으며 어떤 이야기를 나누셨나요?',
    'answer': '내일 예배 준비 잘되가냐고 물어보셨던 것 같고.. 그리고 정길준씨랑 얼마 전에 말다툼을 하셨던 이야기도 잠깐 했었던 것 같아요',
    'problem': '정길준씨는 가족 관계가 어떻게 되시죠?',
    'answer': '지금은 혼자 살고 있습니다. 사실 부모님은 몇년전에 사고로 돌아가셨어요. 부모님이 돌아가시고 너ㅓ무 힘들었는데.. 그때마다 교회를 가면 좀 낫더라구요',
    'problem': '집에서 주로 뭘 하면서 시간을 보내시나요?',
    'answer': '제가 집에는 잘 없고, 거의 하루종일 밭에 있어요. 밭일 끝나고 나면 체력적으로 힘들어서 집에서는 거의 누워있거나.. 자는 시간이 대부분입니다',

    지금부터 사용자는 형사이며, 당신에게 질문을 할 예정입니다. 당신은 정길준이라는 목격자로써 사용자가 사건을 추리해나갈 수 있도록 돕되, 직접적인 답변을 피하고 적절한 질문을 유도해 주세요. 최종 목표는 사용자가 이 이야기의 전말을 파악하는 것입니다.

'''
    return result

@app.route('/')
def index():
    global chat_history
    chat_history = []  # Reset chat history

    problem = next((p for p in problems if p['label'] == "바다거북 스프"), None)
    if not problem:
        return "문제를 찾을 수 없습니다.", 404

    first_prompt = prompt_generate(problem['problem'], problem['answer'])
    chat_history.append({"role": "user", "content": first_prompt})

    response = client.chat.completions.create(
        model="ft:gpt-4o-mini-2024-07-18:personal:giljun:AQbNwk9i",
        messages=chat_history
    )

    reply = str(response.choices[0].message.content)
    chat_history.append({"role": "assistant", "content": reply})

    return render_template('chat.html', step=problem)

@app.route('/step/<int:step_id>')
def step(step_id):
    global chat_history
    chat_history = []  # Reset chat history

    problem = next((p for p in problems if p['id'] == step_id), None)
    if not problem:
        return "문제를 찾을 수 없습니다.", 404

    first_prompt = prompt_generate(problem['problem'], problem['answer'])
    chat_history.append({"role": "user", "content": first_prompt})

    response = client.chat.completions.create(
        model="ft:gpt-4o-mini-2024-07-18:personal:giljun:AQbNwk9i",
        messages=chat_history
    )

    reply = str(response.choices[0].message.content)
    chat_history.append({"role": "assistant", "content": reply})

    return render_template('chat.html', step=problem)

@app.route('/chat', methods=['POST'])
def chat():
    global chat_history
    data = request.get_json()
    user_input = data.get('message')
    if not user_input:
        return jsonify({'error': 'No message provided'}), 400

    chat_history.append({"role": "user", "content": user_input})

    response = client.chat.completions.create(
        model="ft:gpt-4o-mini-2024-07-18:personal:giljun:AQbNwk9i",
        messages=chat_history
    )

    reply = str(response.choices[0].message.content)
    chat_history.append({"role": "assistant", "content": reply})

    if "[클리어]" in reply:
        return jsonify({'response': "[클리어]"})
    return jsonify({'response': reply})

@app.route('/reset_chat', methods=['POST'])
def reset_chat():
    global chat_history
    data = request.get_json()
    step_id = data.get('step_id')
    if step_id is None:
        return jsonify({'error': 'No step_id provided'}), 400

    problem = next((p for p in problems if p['id'] == step_id), None)
    if not problem:
        return jsonify({'error': 'Invalid step_id provided'}), 404

    chat_history = []  # Reset chat history
    first_prompt = prompt_generate(problem['problem'], problem['answer'])
    chat_history.append({"role": "user", "content": first_prompt})

    return jsonify({'status': 'Chat history cleared', 'first_prompt': first_prompt})

@app.route('/save_chat_history', methods=['POST'])
def save_chat_history():
    data = request.get_json()
    user_message = data.get('user_message')
    bot_message = data.get('bot_message')

    if not user_message or not bot_message:
        return jsonify({'error': 'Invalid data provided'}), 400

    # Save the chat history to a file or database with UTF-8 encoding
    with open('chat_history.txt', 'a', encoding='utf-8') as f:
        f.write(f"User: {user_message}\nBot: {bot_message}\n\n")

    return jsonify({'status': 'Chat history saved'})

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=8000, debug=True)