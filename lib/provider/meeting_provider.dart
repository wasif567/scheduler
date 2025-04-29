import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scheduler/core/app_colors/app_colors.dart';
import 'package:scheduler/models/meeting_item/meeting_item.dart';
import 'package:scheduler/models/meeting_model/meeting_response.dart';
import 'package:scheduler/pages/widgets/meeting_list.dart';
import 'package:scheduler/service/meeting_service.dart';
import 'package:table_calendar/table_calendar.dart';

class MeetingProvider with ChangeNotifier {
  MeetingProvider() {
    fetchingMeeting(DateTime.now());
  }

  MeetingResponse? _meetingResponse;
  MeetingResponse? get meetingResponse => _meetingResponse;
  set meetingResponse(MeetingResponse? val) {
    _meetingResponse = val;
    notifyListeners();
  }

  DateTime _focusedDay = DateTime.now();
  DateTime get focusedDay => _focusedDay;
  set focusedDay(DateTime val) {
    _focusedDay = val;
    notifyListeners();
  }

  DateTime _selectedDay = DateTime.now();
  DateTime get selectedDay => _selectedDay;
  set selectedDay(DateTime val) {
    _selectedDay = val;
    notifyListeners();
  }

  List<DateTime> parsedDates = [];

  fetchingMeeting(DateTime date) async {
    try {
      parsedDates = [];
      MeetingService service = MeetingService();
      MeetingResponse? meetingRes = await service.fetchMeetings(date: date);

      if (meetingRes != null) {
        meetingResponse = meetingRes;
        notifyListeners();

        log("${meetingResponse!.toJson()}");
        if (meetingResponse!.data.isNotEmpty) {
          for (var meetindata in meetingResponse!.data) {
            DateTime date = DateTime.parse(meetindata.date);

            if (!parsedDates.contains(date)) {
              parsedDates.add(date);
            }

            log("${meetindata.toJson()}");
            for (var item in meetindata.items) {
              log("${item.toJson()}");
            }
          }
          log("${parsedDates.length}");
        }
      }
    } catch (_) {
      meetingResponse = null;
    }
  }

  Color defaultDayColor(DateTime day) {
    final today = DateTime.now();
    final DateTime justDate = DateTime(day.year, day.month, day.day);
    final DateTime justToday = DateTime(today.year, today.month, today.day);
    if (meetingResponse != null) {
      if (meetingResponse!.data != null && meetingResponse!.data.isNotEmpty) {
        if (meetingResponse!.data.any((meetingDate) => isSameDay(DateTime.parse(meetingDate.date), day))) {
          if (isSameDay(justDate, justToday)) {
            return Colors.yellow; // current day meeting
          } else if (justDate.isAfter(justToday)) {
            return Colors.green; // upcoming meeting
          } else {
            return Colors.grey; // past meeting
          }
        }
      }
    }

    return Colors.transparent; // no meeting
  }

  List<MeetingItem>? _selectedMeetings = [];
  List<MeetingItem>? get selectedMeetings => _selectedMeetings;
  set selectedMeetings(List<MeetingItem>? val) {
    _selectedMeetings = val;
    notifyListeners();
  }

  getMeetingsList(DateTime day) {
    try {
      if (selectedMeetings == null || selectedMeetings!.isEmpty) {
        DateTime targetedDate = DateTime(day.year, day.month, day.day);
        MeetingDate? meetings = meetingResponse!.data.firstWhere(
          (entry) => DateTime.parse(entry.date) == targetedDate,
        );
        if (meetings != null) {
          List<MeetingItem> items = meetings.items;
          if (items.isNotEmpty) {
            selectedMeetings!.addAll(items);
          }
        }
      } else {
        selectedMeetings = [];
      }
    } catch (_) {}
  }
}
