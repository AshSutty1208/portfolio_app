import 'package:portfolio_app/app_theme/app_theme.dart';
import 'package:portfolio_app/base_widgets/base_state_widgets.dart';
import 'package:portfolio_app/extensions.dart';
import 'package:portfolio_app/features/chat/domain/chat_message.dart';
import 'package:portfolio_app/features/chat/ui/widgets/message_item.dart';
import 'package:flutter/material.dart';

class AnimatedMessageCard extends BaseConsumerStatefulWidget {
  const AnimatedMessageCard({super.key, required this.chatMessage});

  final ChatMessage chatMessage;

  @override
  BaseConsumerState<AnimatedMessageCard> createState() =>
      _AnimatedMessageCardState();
}

class _AnimatedMessageCardState extends BaseConsumerState<AnimatedMessageCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.chatMessage.chatMessageType == ChatMessageType.received
        ? _receivedMessage(widget.chatMessage, appTheme)
        : _sentMessage(widget.chatMessage, appTheme);
  }

  Widget _buildAnimatedMessageCard(ChatMessage chatMessage) {
    return Card(
      color: chatMessage.chatMessageType == ChatMessageType.received
          ? appTheme.colours.corePaleMint
          : appTheme.colours.coreCoralRed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 12.0,
          right: 12.0,
          top: 8.0,
          bottom: 4.0,
        ),
        child: Column(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildMessage(chatMessage, appTheme),
            _buildTimestamp(chatMessage.timestamp, appTheme),
          ],
        ),
      ),
    );
  }

  Widget _receivedMessage(ChatMessage chatMessage, AppTheme appTheme) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(-0.2, 0),
        end: Offset.zero,
      ).animate(_animationController),
      child: Row(
        spacing: 8,
        children: [
          _buildAvatar(
            chatMessageRecipientAvatarUrl,
            appTheme.colours.corePaleMint,
          ),
          Flexible(child: _buildAnimatedMessageCard(chatMessage)),
        ],
      ),
    );
  }

  Widget _sentMessage(ChatMessage chatMessage, AppTheme appTheme) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(0.2, 0),
        end: Offset.zero,
      ).animate(_animationController),
      child: Row(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(child: _buildAnimatedMessageCard(chatMessage)),
          _buildAvatar(
            chatMessageSenderAvatarUrl,
            appTheme.colours.coreCoralRed,
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(ChatMessage chatMessage, AppTheme appTheme) {
    return Text(chatMessage.message, style: appTheme.textStyles.body1);
  }

  Widget _buildTimestamp(DateTime timestamp, AppTheme appTheme) {
    return Text(
      timestamp.formatToDayTime(),
      style: appTheme.textStyles.captionBold,
    );
  }

  Widget _buildAvatar(String imageUrl, Color backgroundColor) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Material(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
        child: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
          backgroundColor: backgroundColor,
        ),
      ),
    );
  }
}
