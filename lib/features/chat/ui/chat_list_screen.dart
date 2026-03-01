import 'package:portfolio_app/base_widgets/base_state_widgets.dart';
import 'package:portfolio_app/base_widgets/navigation/app_bar.dart';
import 'package:portfolio_app/features/chat/ui/chat_list_view_model.dart';
import 'package:portfolio_app/features/chat/ui/widgets/message_item.dart';
import 'package:portfolio_app/features/chat/ui/widgets/recieving_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatListScreen extends BaseConsumerStatefulWidget {
  const ChatListScreen({super.key});

  @override
  BaseConsumerState<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends BaseConsumerState<ChatListScreen> {
  final ScrollController _controller = ScrollController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(chatListViewModelProvider.notifier).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseAppBar(
        context,
        ref,
        appTheme,
        Text('Your Chat', style: appTheme.textStyles.label2),
        actions: [
          IconButton(
            onPressed: () {
              showBottomSheet(
                context: context,
                builder: (context) => BottomSheet(
                  onClosing: () {},
                  builder: (context) => IntrinsicHeight(
                    child: Column(
                      children: [
                        AppBar(
                          leading: SizedBox.shrink(),
                          title: Text(
                            'Participants',
                            style: appTheme.textStyles.label2,
                          ),
                          backgroundColor: Colors.transparent,
                          actions: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.close),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            spacing: 8,
                            children: [
                              Row(
                                spacing: 8,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      chatMessageRecipientAvatarUrl,
                                    ),
                                  ),
                                  Text(
                                    'Random DR',
                                    style: appTheme.textStyles.body1,
                                  ),
                                ],
                              ),
                              Row(
                                spacing: 8,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      chatMessageSenderAvatarUrl,
                                    ),
                                  ),
                                  Text(
                                    'Random User',
                                    style: appTheme.textStyles.body1,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.group),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                        final chatMessages = ref
                            .watch(chatListViewModelProvider)
                            .chatMessages;

                        return CustomScrollView(
                          controller: _controller,
                          reverse: true,
                          slivers: [
                            SliverList.builder(
                              itemBuilder: (BuildContext context, int index) {
                                return ChatMessageItem(
                                  key: ValueKey(index),
                                  chatMessage: chatMessages[index],
                                );
                              },
                              itemCount: chatMessages.length,
                            ),
                          ],
                        );
                      },
                ),
              ),
            ),
            if (ref.watch(chatListViewModelProvider).isBotResponding)
              const ReceivingMessage(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: TextField(
                controller: _messageController,
                style: appTheme.textStyles.body1,
                decoration: InputDecoration(
                  icon: Icon(Icons.message),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _handleSendMessage(_messageController.text);
                    },
                    icon: Icon(Icons.send),
                  ),
                  hintText: 'Message',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onSubmitted: (value) {
                  _handleSendMessage(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSendMessage(String value) {
    if (value.isEmpty) {
      return;
    }

    ref.read(chatListViewModelProvider.notifier).sendMessage(value);

    _controller.animateTo(
      _controller.position.minScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    _messageController.clear();
  }
}
