import 'package:portfolio_app/app_theme/app_theme.dart';
import 'package:portfolio_app/app_theme/app_theme_dimensions.dart';
import 'package:portfolio_app/base_widgets/base_state_widgets.dart';
import 'package:portfolio_app/base_widgets/loaders/loading_dots.dart';
import 'package:portfolio_app/features/chat/ui/widgets/message_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReceivingMessage extends BaseConsumerWidget {
  const ReceivingMessage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref, AppTheme appTheme) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 72,
          maxWidth: AppThemeDimensions.maxScreenWidth(context),
          minWidth: AppThemeDimensions.maxScreenWidth(context),
        ),
        child: IntrinsicHeight(child: _buildRecievingMessage(appTheme)),
      ),
    );
  }

  Widget _buildRecievingMessage(AppTheme appTheme) {
    return Row(
      spacing: 8,
      children: [
        _buildAvatar(chatMessageRecipientAvatarUrl),
        Flexible(child: _buildMessageContainer(appTheme)),
      ],
    );
  }

  Widget _buildMessageContainer(AppTheme appTheme) {
    return Card(
      color: appTheme.colours.corePaleMint,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: const LoadingDots(),
      ),
    );
  }

  Widget _buildAvatar(String imageUrl) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
    );
  }
}
