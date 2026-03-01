import 'package:portfolio_app/base_widgets/base_state_widgets.dart';
import 'package:portfolio_app/base_widgets/navigation/app_bar.dart';
import 'package:portfolio_app/features/timeline/ui/timeline_list/timeline_view_model.dart';
import 'package:portfolio_app/features/timeline/ui/timeline_list/widgets/timeline_list_item.dart';
import 'package:flutter/material.dart';

class TimelineScreen extends BaseConsumerStatefulWidget {
  const TimelineScreen({super.key});

  @override
  BaseConsumerState<TimelineScreen> createState() => TimelineScreenState();
}

class TimelineScreenState extends BaseConsumerState<TimelineScreen> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(timelineViewModelProvider.notifier).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final timelineItems = ref.watch(timelineViewModelProvider).timelineItems;

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: baseAppBar(
        context,
        ref,
        appTheme,
        Text('Timeline', style: appTheme.textStyles.label2),
      ),
      body: SafeArea(
        child: CustomScrollView(
          controller: _controller,
          slivers: [
            SliverList.builder(
              itemBuilder: (BuildContext context, int index) {
                return TimelineListItem(
                  key: ValueKey(index),
                  timelineItem: timelineItems[index],
                );
              },
              itemCount: timelineItems.length,
            ),
          ],
        ),
      ),
    );
  }
}
