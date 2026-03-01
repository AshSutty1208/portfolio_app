import 'dart:convert';
import 'dart:math';

import 'package:portfolio_app/features/chat/domain/chat_message.dart';
import 'package:portfolio_app/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_repository.g.dart';

@riverpod
class ChatRepository extends _$ChatRepository {
  @override
  ChatRepository build() => ChatRepository();

  Future<List<ChatMessage>> getInitialChatMessages() async {
    try {
      final List<ChatMessage> chatMessages = [];

      for (final chatMessage in jsonDecode(chatMessagesJson)['chatMessages']) {
        chatMessages.add(ChatMessage.fromMap(chatMessage));
      }

      chatMessages.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      return Future.value(chatMessages);
    } catch (e) {
      logException('ChatRepository', e, stackTrace: StackTrace.current);
      return [];
    }
  }

  ChatMessage? getRandomBotResponse() {
    try {
      final List<ChatMessage> botResponses = [];
      for (final botResponse in jsonDecode(botResponsesJson)['botResponses']) {
        botResponses.add(ChatMessage.fromMap(botResponse));
      }

      final randomBotResponse =
          botResponses[Random().nextInt(botResponses.length)];

      return randomBotResponse.copyWith(timestamp: DateTime.now());
    } catch (e) {
      logException('ChatRepository', e, stackTrace: StackTrace.current);
    }
    return null;
  }
}

final chatMessagesJson = '''
{
  "chatMessages": [
    {
      "message": "Hi Dr. Chen, I'm reviewing the new admission in Ward 204. Patient is a 68-year-old male with history of hypertension and diabetes. Can you take a look at his current medication list?",
      "timestamp": "2025-10-27T08:00:00Z",
      "chatMessageType": "sent"
    },
    {
      "message": "Sure, just pulled up his chart. I see he's on Metformin 1000mg twice daily and Lisinopril 10mg. Has he been taking these regularly at home?",
      "timestamp": "2025-10-27T08:15:00Z",
      "chatMessageType": "received"
    },
    {
      "message": "According to the family, he's been compliant. However, his HbA1c is 8.2% and BP was 158/92 on admission. I'm thinking we might need to adjust dosages.",
      "timestamp": "2025-10-27T08:30:00Z",
      "chatMessageType": "sent"
    },
    {
      "message": "Agreed. Let's increase the Lisinopril to 20mg and consider adding a second antihypertensive. What brought him in today?",
      "timestamp": "2025-10-27T08:45:00Z",
      "chatMessageType": "received"
    },
    {
      "message": "He presented with a non-healing ulcer on his left foot, approximately 3cm diameter. There's some surrounding erythema but no purulent discharge yet. I've ordered wound cultures.",
      "timestamp": "2025-10-27T09:00:00Z",
      "chatMessageType": "sent"
    },
    {
      "message": "Good call. Given his diabetes, we should start empiric antibiotics while waiting for cultures. I'd recommend Augmentin 875mg twice daily. Also, has vascular surgery been consulted?",
      "timestamp": "2025-10-27T09:15:00Z",
      "chatMessageType": "received"
    },
    {
      "message": "Not yet, but I'll put in the consult now. His pedal pulses are weak bilaterally. We might need a vascular doppler study to assess perfusion.",
      "timestamp": "2025-10-27T09:30:00Z",
      "chatMessageType": "sent"
    },
    {
      "message": "Absolutely. In the meantime, keep him non-weight bearing on that foot and get wound care involved for daily dressing changes. What's his renal function like?",
      "timestamp": "2025-10-27T09:45:00Z",
      "chatMessageType": "received"
    },
    {
      "message": "Creatinine is 1.4, eGFR is 52. Slightly decreased from his baseline six months ago which was eGFR of 61. We should probably get nephrology's input too.",
      "timestamp": "2025-10-27T10:00:00Z",
      "chatMessageType": "sent"
    },
    {
      "message": "Yes, especially before we adjust his Metformin. They may want to switch him to a different diabetes medication. Let me know when the culture results come back and we'll adjust antibiotics if needed.",
      "timestamp": "2025-10-27T10:15:00Z",
      "chatMessageType": "received"
    },
    {
      "message": "Will do. I've also scheduled a family meeting for tomorrow morning at 10am to discuss the treatment plan. His daughter has medical POA and wants to be involved in all decisions.",
      "timestamp": "2025-10-27T10:30:00Z",
      "chatMessageType": "sent"
    },
    {
      "message": "Perfect. I'll join if I'm available. In the meantime, make sure we have a diabetes educator see him before discharge. This is a good opportunity for patient education.",
      "timestamp": "2025-10-27T10:45:00Z",
      "chatMessageType": "received"
    }
  ]
}
''';

final botResponsesJson = '''
{
  "botResponses": [
    {
      "message": "I've reviewed the labs and everything looks good. We can proceed with the discharge plan as discussed.",
      "timestamp": "2025-10-27T08:00:00Z",
      "chatMessageType": "received"
    },
    {
      "message": "The patient's family is asking about the timeline for recovery. I told them we'd have a better idea after the consult tomorrow.",
      "timestamp": "2025-10-27T08:00:00Z",
      "chatMessageType": "received"
    },
    {
      "message": "Good call. Let me know if you need me to review the imaging results. I should be available after rounds.",
      "timestamp": "2025-10-27T08:00:00Z",
      "chatMessageType": "received"
    },
    {
      "message": "I agree with your assessment. We should also consider adding a specialist consult just to be safe.",
      "timestamp": "2025-10-27T08:00:00Z",
      "chatMessageType": "received"
    },
    {
      "message": "The nursing staff mentioned some concerns about pain management. Have you had a chance to adjust the medication orders?",
      "timestamp": "2025-10-27T08:00:00Z",
      "chatMessageType": "received"
    },
    {
      "message": "Sure, I can take over that patient if you're tied up with the emergency admission. Just send me the chart notes.",
      "timestamp": "2025-10-27T08:00:00Z",
      "chatMessageType": "received"
    },
    {
      "message": "That makes sense. Let's schedule a follow-up for next week and reassess the treatment plan then.",
      "timestamp": "2025-10-27T08:00:00Z",
      "chatMessageType": "received"
    },
    {
      "message": "I've contacted the specialist and they can see the patient this afternoon. I'll update you once they've completed their evaluation.",
      "timestamp": "2025-10-27T08:00:00Z",
      "chatMessageType": "received"
    },
    {
      "message": "The culture results came back positive. We need to switch to a broader spectrum antibiotic. I'll put in the order now.",
      "timestamp": "2025-10-27T08:00:00Z",
      "chatMessageType": "received"
    },
    {
      "message": "I've spoken with the patient and they understand the risks. They're comfortable proceeding with the recommended treatment.",
      "timestamp": "2025-10-27T08:00:00Z",
      "chatMessageType": "received"
    },
    {
      "message": "Thanks for the heads up. I'll make sure to check in on that patient during my rounds this afternoon.",
      "timestamp": "2025-10-27T08:00:00Z",
      "chatMessageType": "received"
    },
    {
      "message": "The imaging shows some improvement from last week. I think we're on the right track with the current treatment plan.",
      "timestamp": "2025-10-27T08:00:00Z",
      "chatMessageType": "received"
    },
    {
      "message": "I'll coordinate with physical therapy to get them started on mobility exercises before discharge.",
      "timestamp": "2025-10-27T08:00:00Z",
      "chatMessageType": "received"
    },
    {
      "message": "The patient's vitals have stabilized overnight. We can probably move them out of intensive monitoring.",
      "timestamp": "2025-10-27T08:00:00Z",
      "chatMessageType": "received"
    },
    {
      "message": "I've updated the discharge instructions to include the medication changes. The pharmacy has been notified as well.",
      "timestamp": "2025-10-27T08:00:00Z",
      "chatMessageType": "received"
    }
  ]
}
''';
