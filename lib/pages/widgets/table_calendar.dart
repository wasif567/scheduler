import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/core/app_colors/app_colors.dart';
import 'package:scheduler/provider/meeting_provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomTableCalendar extends StatefulWidget {
  const CustomTableCalendar({super.key});

  @override
  State<CustomTableCalendar> createState() => _CustomTableCalendarState();
}

class _CustomTableCalendarState extends State<CustomTableCalendar> {
  @override
  void didUpdateWidget(covariant CustomTableCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MeetingProvider>(
      builder: (context, state, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.greyColor,
          ),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: TableCalendar(
            firstDay: DateTime(2000),
            lastDay: DateTime(2100),
            focusedDay: state.focusedDay,
            calendarFormat: CalendarFormat.month,
            selectedDayPredicate: (day) {
              return isSameDay(state.selectedDay, day);
            },
            onCalendarCreated: (pageController) {
              state.pageController = pageController;
            },
            onPageChanged: (focusedDay) {
              state.focusedDay = focusedDay;
              state.fetchingMeeting(focusedDay);
            },
            onDaySelected: (selectedDay, focusedDay) {
              state.selectedDay = selectedDay;
              state.focusedDay = focusedDay;
              state.getMeetingsList(focusedDay);
            },
            /* headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(
                fontSize: 20.0,
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
              leftChevronIcon: Icon(
                Icons.chevron_left,
                color: Colors.blueAccent,
              ),
              rightChevronIcon: Icon(
                Icons.chevron_right,
                color: Colors.blueAccent,
              ),
            ), */
            headerVisible: false,
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                border: Border.all(color: Colors.yellow),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Color(0xFF99C139),
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
              todayTextStyle: TextStyle(color: Colors.white),
              defaultTextStyle: TextStyle(color: Colors.white),
              outsideDaysVisible: true,
            ),
            daysOfWeekVisible: true,
            daysOfWeekStyle: DaysOfWeekStyle(
              weekendStyle: TextStyle(color: Colors.grey),
              weekdayStyle: TextStyle(color: Colors.grey),
            ),
            calendarBuilders: CalendarBuilders(
              todayBuilder: (context, day, focusedDay) {
                return Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.currentColor),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    "${day.day}",
                    style: TextStyle(
                      color: AppColors.currentColor,
                      fontSize: 16,
                    ),
                  ),
                );
              },
              defaultBuilder: (context, day, focusedDay) {
                return Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "${day.day}",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    Positioned(
                      right: 3,
                      top: 6,
                      child: Badge(backgroundColor: state.defaultDayColor(day)),
                    ),
                  ],
                );
              },
              outsideBuilder: (context, day, focusedDay) {
                return Container(
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "${day.day}",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                );
              },
              selectedBuilder: (context, day, focusedDay) {
                return Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.upcomingColor),
                    color: AppColors.upcomingColor,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    "${day.day}",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
