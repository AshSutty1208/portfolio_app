import 'package:portfolio_app/app_theme/app_theme.dart';
import 'package:portfolio_app/app_theme/app_theme_dimensions.dart';
import 'package:portfolio_app/base_widgets/base_state_widgets.dart';
import 'package:portfolio_app/extensions.dart';
import 'package:portfolio_app/features/timeline/domain/timeline_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimelineListItem extends BaseConsumerWidget {
  const TimelineListItem({super.key, required this.timelineItem});

  final TimelineItem timelineItem;

  static const double _timelineItemTopPadding = 32.0;

  @override
  Widget build(BuildContext context, WidgetRef ref, AppTheme appTheme) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: 48,
        maxWidth: AppThemeDimensions.maxScreenWidth(context),
        minWidth: AppThemeDimensions.maxScreenWidth(context),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 8.0),
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Container(
                            width: 2,
                            color: appTheme.colours.coreBlackLightWhiteDark,
                          ),
                        ),
                        Container(
                          width: 32,
                          height: 32,
                          margin: const EdgeInsets.only(
                            top: _timelineItemTopPadding + 6.0,
                          ),
                          decoration: BoxDecoration(
                            color:
                                timelineItem.timelineItemType ==
                                    TimelineItemType.note
                                ? appTheme.colours.coreSageGreen
                                : appTheme.colours.coreCoralRed,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: appTheme.colours.coreBlackLightWhiteDark,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 9.0,
                            top: _timelineItemTopPadding + 14.0,
                          ),
                          child: Icon(
                            timelineItem.timelineItemType ==
                                    TimelineItemType.note
                                ? Icons.note
                                : Icons.file_copy_sharp,
                            size: 16,
                            color: appTheme.colours.coreBlackLightWhiteDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: _timelineItemTopPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 4.0,
                        right: 16.0,
                        top: 12.0,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              timelineItem.timelineItemType.name.capitalize(),
                              style: appTheme.textStyles.caption,
                            ),
                          ),
                          Text(
                            timelineItem.timestamp.formatToDayTime(),
                            style: appTheme.textStyles.captionBold,
                          ),
                        ],
                      ),
                    ),
                    _buildTimelineItemType(timelineItem, appTheme),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineItemType(TimelineItem timelineItem, AppTheme appTheme) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Card(
            margin: EdgeInsets.only(right: 16.0, top: 8.0),
            color: timelineItem.timelineItemType == TimelineItemType.note
                ? appTheme.colours.corePaleMint
                : appTheme.colours.coreCoralRed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 16.0,
                bottom: 12.0,
              ),
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(timelineItem.title, style: appTheme.textStyles.label1),

                  Text(timelineItem.message, style: appTheme.textStyles.body1),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
