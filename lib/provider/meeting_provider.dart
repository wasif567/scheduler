import 'package:flutter/material.dart';
import 'package:scheduler/models/meeting_item/meeting_item.dart';
import 'package:scheduler/models/meeting_model/meeting_response.dart';
import 'package:scheduler/service/meeting_service.dart';
import 'package:table_calendar/table_calendar.dart';

class MeetingProvider with ChangeNotifier {
  PageController pageController = PageController();

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

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  fetchingMeeting(DateTime date) async {
    try {
      focusedDay = date;
      selectedDate = null;
      selectedMeetings = [];
      parsedDates = [];
      notifyListeners();
      MeetingService service = MeetingService();
      meetingResponse = MeetingResponse(status: 0, message: "", data: []);
      MeetingResponse? meetingRes = await service.fetchMeetings(date: date);

      if (meetingRes != null) {
        meetingResponse = meetingRes;
        notifyListeners();

        if (meetingResponse!.data.isNotEmpty) {
          for (var meetindata in meetingResponse!.data) {
            DateTime date = DateTime.parse(meetindata.date);

            if (!parsedDates.contains(date)) {
              parsedDates.add(date);
            }
          }
        }
      }

      notifyListeners();
    } catch (_) {
      isLoading = false;
    }
  }

  Color defaultDayColor(DateTime day) {
    final today = DateTime.now();
    final DateTime justDate = DateTime(day.year, day.month, day.day);
    final DateTime justToday = DateTime(today.year, today.month, today.day);
    if (meetingResponse != null) {
      if (meetingResponse!.data != null && meetingResponse!.data.isNotEmpty) {
        if (meetingResponse!.data.any(
          (meetingDate) => isSameDay(DateTime.parse(meetingDate.date), day),
        )) {
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

  MeetingDate? _selectedDate;
  MeetingDate? get selectedDate => _selectedDate;
  set selectedDate(MeetingDate? val) {
    _selectedDate = val;
    notifyListeners();
  }

  getMeetingsList(DateTime day) {
    try {
      selectedDate = null;
      selectedMeetings = [];
      DateTime? parsedDate;
      if (selectedDate != null) {
        parsedDate = DateTime.parse(selectedDate!.date);
      }
      if (selectedDate == null ||
          selectedDate!.items.isEmpty ||
          !(isSameDay(parsedDate, day))) {
        DateTime targetedDate = DateTime(day.year, day.month, day.day);
        MeetingDate? meetings;
        int index = meetingResponse!.data.indexWhere(
          (entry) => DateTime.parse(entry.date) == targetedDate,
        );
        if (index != -1) {
          meetings = meetingResponse!.data.firstWhere(
            (entry) => DateTime.parse(entry.date) == targetedDate,
          );
          if (meetings != null) {
            selectedDate = MeetingDate(date: "", items: []);
            List<MeetingItem> items = meetings.items;
            if (items.isNotEmpty) {
              selectedMeetings!.addAll(items);
            }
            selectedDate!.date = meetings.date;
            selectedDate!.items.addAll(selectedMeetings!);
          }
        }
      } else {
        selectedDate = null;
        selectedMeetings = [];
      }
      notifyListeners();
    } catch (_) {}
  }
}
