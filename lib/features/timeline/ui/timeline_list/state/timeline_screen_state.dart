import 'package:portfolio_app/features/timeline/domain/timeline_item.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'timeline_screen_state.mapper.dart';

@MappableClass()
class TimelineState with TimelineStateMappable {
  const TimelineState({this.timelineItems = const []});

  final List<TimelineItem> timelineItems;

  static const fromMap = TimelineStateMapper.fromMap;
  static const fromJson = TimelineStateMapper.fromJson;
}
