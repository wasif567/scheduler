import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scheduler/models/meeting_item/meeting_item.dart';
import 'package:scheduler/models/meeting_model/meeting_response.dart';
import 'package:scheduler/service/meeting_service.dart';
import 'package:table_calendar/table_calendar.dart';

class MeetingProvider with ChangeNotifier {
  CalendarBuilders calendarBuilders = CalendarBuilders(
    dowBuilder: (context, day) {
      return SizedBox(
        height: 15,
        child: Center(child: Text(DateFormat('EEE').format(day), style: TextStyle(color: Colors.white))),
      );
    },
    markerBuilder: (context, day, events) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Text(
          "${day.day}",
          style: TextStyle(fontSize: 9, fontWeight: FontWeight.w500, color: Colors.green),
        ),
      );
    },
    todayBuilder: (context, day, focusedDay) {
      return Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.red,
          borderRadius: BorderRadius.circular(5),
        ), //Change color
        child: Center(child: Text("${day.day}", style: TextStyle(color: Colors.white))),
      );
    },
    // markerBuilder: (context, day, events) {
    //   return Padding(
    //     padding: const EdgeInsets.only(bottom: 5),
    //     child: Text(
    //       viewState.getLabel(day),
    //       style: AppTypography.interBold.merge(
    //         TextStyle(fontSize: 9, fontWeight: FontWeight.w500, color: viewState.getLabelTxtColor(day)),
    //       ),
    //     ),
    //   );
    // },
    // todayBuilder: (context, day, focusedDay) {
    //   return Container(
    //     margin: const EdgeInsets.all(2),
    //     decoration: BoxDecoration(
    //       shape: BoxShape.rectangle,
    //       color: viewState.getBgColor(day),
    //       borderRadius: BorderRadius.circular(5),
    //     ), //Change color
    //     child: Center(
    //       child: FutureBuilder(
    //         future: TranslationHelper().getTransDayNoText("${day.day}"),
    //         builder: (context, snapshot) {
    //           return Text(
    //             snapshot.data ?? "${day.day}",
    //             style: AppTypography.interBold.merge(const TextStyle(color: Colors.white)),
    //           );
    //         },
    //       ),
    //     ),
    //   );
    // },
    selectedBuilder: (context, day, focusedDay) {
      return Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(5)),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.red ,
            borderRadius: BorderRadius.circular(5),
          ), //Change color
          child: Center(
            child: FutureBuilder(
              future: TranslationHelper().getTransDayNoText("${day.day}"),
              builder: (context, snapshot) {
                return Text(
                  snapshot.data ?? "${day.day}",
                  style: AppTypography.interBold.merge(
                    const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                );
              },
            ),
          ),
        ),
      );
    },
    // outsideBuilder: (context, day, focusedDay) {
    //   return Container(
    //     padding: const EdgeInsets.all(2),
    //     child: Container(
    //       decoration: BoxDecoration(
    //         shape: BoxShape.rectangle,
    //         borderRadius: BorderRadius.circular(5),
    //       ), //Change color
    //       child: Center(
    //         child: FutureBuilder(
    //           future: TranslationHelper().getTransDayNoText("${day.day}"),
    //           builder: (context, snapshot) {
    //             return Text(
    //               snapshot.data ?? "${day.day}",
    //               style: AppTypography.interBold.merge(TextStyle(color: viewState.getDefaultBgColor(day))),
    //             );
    //           },
    //         ),
    //       ),
    //     ),
    //   );
    // },
    // defaultBuilder: (context, day, focusedDay) {
    //   return Container(
    //     padding: const EdgeInsets.all(2),
    //     child: Container(
    //       decoration: BoxDecoration(
    //         shape: BoxShape.rectangle,
    //         color: viewState.getBgColor(day),
    //         borderRadius: BorderRadius.circular(5),
    //       ), //Change color
    //       child: Center(
    //         child: FutureBuilder(
    //           future: TranslationHelper().getTransDayNoText("${day.day}"),
    //           builder: (context, snapshot) {
    //             return Text(
    //               snapshot.data ?? "${day.day}",
    //               style: AppTypography.interBold.merge(TextStyle(color: viewState.getDefaultBgColor(day))),
    //             );
    //           },
    //         ),
    //       ),
    //     ),
    //   );
    // },
  );
  // final MeetingService meetingService;
  /* List<MeetingDate> _meetings = [];
  DateTime _selectedDate = DateTime.now();
  bool _isLoading = false;
  String _error = '';

  MeetingProvider({required this.meetingService});

  List<MeetingDate> get meetings => _meetings;
  DateTime get selectedDate => _selectedDate;
  bool get isLoading => _isLoading;
  String get error => _error;

  List<MeetingItem> get upcomingMeetings => _meetings.where((m) => m.isUpcoming(DateTime.now())).toList();
  List<MeetingItem> get currentMeetings => _meetings.where((m) => m.isCurrent(DateTime.now())).toList();
  List<MeetingItem> get previousMeetings => _meetings.where((m) => m.isPrevious(DateTime.now())).toList();

  List<MeetingDate> get meetingsForSelectedDate =>
      _meetings
          .where(
            (m) =>
                m.m.year == _selectedDate.year &&
                m.startTime.month == _selectedDate.month &&
                m.startTime.day == _selectedDate.day,
          )
          .toList(); */

  /* Future<void> fetchMeetings() async {
    _isLoading = true;
    notifyListeners();

    try {
      _meetings = await meetingService.fetchMeetings();
      _error = '';
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  } */
}
