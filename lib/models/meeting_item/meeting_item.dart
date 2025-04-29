import 'dart:developer';

import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';

part 'meeting_item.g.dart';

@JsonSerializable()
class MeetingItem {
  String id;
  String title;
  @JsonKey(name: 'time')
  String meetingTime;
  bool conflicted;

  // Add these fields for meeting status calculations
  DateTime? _startTime;
  DateTime? _endTime;

  MeetingItem({
    required this.id,
    required this.title,
    required this.meetingTime,
    required this.conflicted,
  }) {
    // Parse the meeting time (assuming date comes from MeetingDate)
    _parseTime();
  }

  factory MeetingItem.fromJson(Map<String, dynamic> json) =>
      _$MeetingItemFromJson(json);

  Map<String, dynamic> toJson() => _$MeetingItemToJson(this);

  // Parse meeting time string into DateTime objects
  void _parseTime() {
    try {
      final timeFormat = DateFormat('hh:mm a');
      final timeOfDay = timeFormat.parse(meetingTime);

      // These would need the actual date from MeetingDate to be fully accurate
      // For demo purposes, we'll use today's date
      final now = DateTime.now();
      _startTime = DateTime(
        now.year,
        now.month,
        now.day,
        timeOfDay.hour,
        timeOfDay.minute,
      );
      _endTime = _startTime!.add(
        const Duration(minutes: 30),
      ); // Default 30 min duration
    } catch (e) {
      log('Error parsing meeting time: $e');
    }
  }

  // Meeting status methods
  bool isUpcoming(DateTime now) => _startTime?.isAfter(now) ?? false;
  bool isCurrent(DateTime now) =>
      (_startTime?.isBefore(now) ?? false) && (_endTime?.isAfter(now) ?? false);
  bool isPrevious(DateTime now) => _endTime?.isBefore(now) ?? false;

  // Helper to combine with date from MeetingDate
  void setDate(DateTime date) {
    if (_startTime != null) {
      _startTime = DateTime(
        date.year,
        date.month,
        date.day,
        _startTime!.hour,
        _startTime!.minute,
      );
      _endTime = _startTime!.add(const Duration(minutes: 30));
    }
  }
}
