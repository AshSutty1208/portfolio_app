// ignore_for_file: unused_import

import 'package:portfolio_app/base_api/base_service.dart';
import 'package:portfolio_app/features/chat/domain/chat_message.dart';
import 'package:portfolio_app/features/chat/domain/chat_repository.dart';
import 'package:portfolio_app/features/chat/ui/chat_list_screen.dart';
import 'package:portfolio_app/features/chat/ui/state/chat_list_screen_state.dart';
import 'package:portfolio_app/features/timeline/domain/timeline_repository.dart';
import 'package:portfolio_app/features/timeline/ui/timeline_list/state/timeline_screen_state.dart';
import 'package:portfolio_app/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_list_view_model.g.dart';

@riverpod
class ChatListViewModel extends _$ChatListViewModel {
  ChatRepository get _chatRepository => ref.watch(chatRepositoryProvider);

  @override
  ChatListScreenState build() => const ChatListScreenState();

  void init() {
    _callGetInitialChatMessages();
  }

  Future<ApiResult?> _callGetInitialChatMessages() async {
    try {
      final chatMessages = await _chatRepository.getInitialChatMessages();

      if (chatMessages.isEmpty) {
        return Failed('No chat messages found');
      }

      state = state.copyWith(chatMessages: chatMessages);
    } catch (e) {
      logException('ChatListViewModel', e, stackTrace: StackTrace.current);
    }
    return null;
  }

  void sendMessage(String message) {
    try {
      final chatMessage = ChatMessage(
        message: message,
        timestamp: DateTime.now(),
        chatMessageType: ChatMessageType.sent,
      );

      final newChatMessages = [chatMessage, ...state.chatMessages];
      state = state.copyWith(chatMessages: newChatMessages);

      startBotResponse(message);
    } catch (e) {
      logException('ChatListViewModel', e, stackTrace: StackTrace.current);
    }
  }

  void startBotResponse(String message) {
    Future.delayed(const Duration(seconds: 2), () {
      state = state.copyWith(isBotResponding: true);
    });

    Future.delayed(const Duration(seconds: 4), () {
      try {
        final chatMessage = _chatRepository.getRandomBotResponse();

        if (chatMessage != null) {
          final newChatMessages = [chatMessage, ...state.chatMessages];
          state = state.copyWith(
            chatMessages: newChatMessages,
            isBotResponding: false,
          );
        } else {
          state = state.copyWith(isBotResponding: false);
        }
      } catch (e) {
        logException('ChatListViewModel', e, stackTrace: StackTrace.current);
        state = state.copyWith(isBotResponding: false);
      }
    });
  }
}
