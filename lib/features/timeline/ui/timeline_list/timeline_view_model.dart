// ignore_for_file: unused_import

import 'package:portfolio_app/base_api/base_service.dart';
import 'package:portfolio_app/features/timeline/domain/timeline_repository.dart';
import 'package:portfolio_app/features/timeline/ui/timeline_list/state/timeline_screen_state.dart';
import 'package:portfolio_app/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'timeline_view_model.g.dart';

@riverpod
class TimelineViewModel extends _$TimelineViewModel {
  TimelineRepository get _timeLineRepository =>
      ref.watch(timelineRepositoryProvider);

  @override
  TimelineState build() => TimelineState();

  void init() {
    _callGetTimelineItems();
  }

  Future<ApiResult?> _callGetTimelineItems() async {
    try {
      final timelineItems = await _timeLineRepository.getTimelineItems();
      state = state.copyWith(timelineItems: timelineItems);
    } catch (e) {
      logException('TimelineViewModel', e, stackTrace: StackTrace.current);
    }
    return null;
  }
}
