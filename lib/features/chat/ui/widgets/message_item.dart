import 'package:portfolio_app/app_theme/app_theme.dart';
import 'package:portfolio_app/app_theme/app_theme_dimensions.dart';
import 'package:portfolio_app/base_widgets/base_state_widgets.dart';
import 'package:portfolio_app/features/chat/domain/chat_message.dart';
import 'package:portfolio_app/features/chat/ui/widgets/animated_message_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const String chatMessageRecipientAvatarUrl =
    "https://images.pexels.com/photos/1334945/pexels-photo-1334945.jpeg";
const String chatMessageSenderAvatarUrl =
    "https://images.pexels.com/photos/1085517/pexels-photo-1085517.jpeg";

class ChatMessageItem extends BaseConsumerWidget {
  const ChatMessageItem({super.key, required this.chatMessage});

  final ChatMessage chatMessage;

  @override
  Widget build(BuildContext context, WidgetRef ref, AppTheme appTheme) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: AppThemeDimensions.maxScreenWidth(context),
          minWidth: AppThemeDimensions.maxScreenWidth(context),
        ),
        child: IntrinsicHeight(
          child: AnimatedMessageCard(chatMessage: chatMessage),
        ),
      ),
    );
  }
}
