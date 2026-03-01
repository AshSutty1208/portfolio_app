import 'dart:convert';

import 'package:portfolio_app/features/timeline/domain/timeline_item.dart';
import 'package:portfolio_app/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'timeline_repository.g.dart';

@riverpod
class TimelineRepository extends _$TimelineRepository {
  @override
  TimelineRepository build() => TimelineRepository();

  Future<List<TimelineItem>> getTimelineItems() async {
    try {
      final List<TimelineItem> timelineItems = [];

      for (final timelineItem in jsonDecode(timeLineJson)['timelineItems']) {
        timelineItems.add(TimelineItem.fromMap(timelineItem));
      }

      timelineItems.sort((a, b) => a.timestamp.compareTo(b.timestamp));

      return Future.value(timelineItems);
    } catch (e) {
      logException('TimelineRepository', e, stackTrace: StackTrace.current);
      return [];
    }
  }
}

final timeLineJson = '''
{
  "timelineItems": [
    {
      "title": "Check Patient History and Medications",
      "timestamp": "2025-10-27T11:00:00Z",
      "message": "Checked patient history and medications as the patient is a new patient",
      "timelineItemType": "note"
    },
    {
      "title": "Audit Patient Medications",
      "timestamp": "2025-10-27T10:00:00Z",
      "message": "Reviewed patient medications and updated the medications",
      "timelineItemType": "audit"
    },
    {
      "title": "Check Patient Stats",
      "timestamp": "2025-10-27T09:00:00Z",
      "message": "Patient has high blood pressure and needs to be monitored",
      "timelineItemType": "note"
    },
    {
      "title": "Review Ward 204",
      "timestamp": "2025-10-27T08:00:00Z",
      "message": "Reviewed ward 204 and updated the ward in the system",
      "timelineItemType": "audit"
    },
    {
      "title": "Reviewed Patient Medications",
      "timestamp": "2025-10-27T07:00:00Z",
      "message": "Reviewed patient medications and updated the medications in the system",
      "timelineItemType": "note"
    },
    {
      "title": "Wound Care Assessment",
      "timestamp": "2025-10-27T06:15:00Z",
      "message": "Performed wound care assessment for post-operative patient, healing progressing well",
      "timelineItemType": "audit"
    },
    {
      "title": "Vital Signs Monitoring",
      "timestamp": "2025-10-27T05:30:00Z",
      "message": "Recorded vital signs - BP 120/80, HR 72, Temp 98.6°F, all within normal range",
      "timelineItemType": "note"
    },
    {
      "title": "Dietary Consultation",
      "timestamp": "2025-10-27T04:45:00Z",
      "message": "Coordinated with nutritionist for diabetic patient meal plan adjustments",
      "timelineItemType": "note"
    },
    {
      "title": "Patient Transport Coordination",
      "timestamp": "2025-10-27T03:20:00Z",
      "message": "Arranged patient transport to radiology for scheduled CT scan",
      "timelineItemType": "audit"
    },
    {
      "title": "Family Conference Call",
      "timestamp": "2025-10-27T02:00:00Z",
      "message": "Conducted family meeting to discuss treatment progress and next steps",
      "timelineItemType": "note"
    }
  ]
}
''';
