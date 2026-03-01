import 'package:portfolio_app/features/chat/domain/chat_message.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'chat_list_screen_state.mapper.dart';

@MappableClass()
class ChatListScreenState with ChatListScreenStateMappable {
  const ChatListScreenState({
    this.chatMessages = const [],
    this.isBotResponding = false,
  });

  final List<ChatMessage> chatMessages;
  final bool isBotResponding;

  static const fromMap = ChatListScreenStateMapper.fromMap;
  static const fromJson = ChatListScreenStateMapper.fromJson;
}
