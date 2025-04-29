import 'package:flutter/material.dart';
import 'package:scheduler/pages/widgets/meeting_list.dart';
import 'package:scheduler/pages/widgets/table_calendar.dart';

class MeetingSchedulerScreen extends StatelessWidget {
  const MeetingSchedulerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: appBar(context),
      backgroundColor: Colors.black,
      body: SizedBox(
        height: kSize.height,
        width: kSize.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CustomTableCalendar(), MeetingList()],
          ),
        ),
      ),
    );
  }
}

AppBar appBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.black,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.calendar_month, color: Colors.white),
        Text("Meeting Scheduler", style: TextStyle(color: Colors.white)),
      ],
    ),
  );
}


/* import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/models/meeting_item/meeting_item.dart';
import 'package:scheduler/models/meeting_model/meeting_model.dart';
import 'package:scheduler/provider/meeting_provider.dart';
import 'package:table_calendar/table_calendar.dart';

class MeetingSchedulerScreen extends StatefulWidget {
  const MeetingSchedulerScreen({super.key});

  @override
  State<MeetingSchedulerScreen> createState() => _MeetingSchedulerScreenState();
}

class _MeetingSchedulerScreenState extends State<MeetingSchedulerScreen> {
  /*  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MeetingProvider>(context, listen: false).fetchMeetings();
    });
  } */

  @override
  Widget build(BuildContext context) {
    final meetingProvider = Provider.of<MeetingProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Meeting Scheduler')),
      body:
      /* meetingProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : meetingProvider.error.isNotEmpty
              ? Center(child: Text('Error: ${meetingProvider.error}'))
              : */
      Column(
        children: [
          _buildCalendar(meetingProvider),
          const SizedBox(height: 16),
          // Expanded(child: _buildMeetingList(meetingProvider)),
        ],
      ),
    );
  }

  Widget _buildCalendar(MeetingProvider meetingProvider) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: TableCalendar(
        firstDay: DateTime.now().subtract(const Duration(days: 365)),
        lastDay: DateTime.now().add(const Duration(days: 365)),
        focusedDay: DateTime.now(),
        // focusedDay: meetingProvider.selectedDate,
        calendarFormat: CalendarFormat.month,
        headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
        // selectedDayPredicate: (day) => isSameDay(day, meetingProvider.selectedDate),
        onDaySelected: (selectedDay, focusedDay) {
          // meetingProvider.setSelectedDate(selectedDay);
        },
        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, date, events) {
            // final meetingsOnDay = meetingProvider.meetings.where((m) => isSameDay(m, date)).toList();

            // if (meetingsOnDay.isEmpty) return null;

            return Positioned(
              right: 1,
              bottom: 1,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // color: _getMarkerColor(date, meetingProvider),
                ),
                child: Text(
                  "Marj",
                  // meetingsOnDay.length.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  /* Color _getMarkerColor(DateTime date, MeetingProvider provider) {
    final now = DateTime.now();
    /* final meetings = provider.meetings.where((m) => isSameDay(m.startTime, date)).toList();

    if (meetings.any((m) => m.isCurrent(now))) return Colors.amber;
    if (meetings.any((m) => m.isUpcoming(now))) return Colors.green; */
    return Colors.grey;
  }

  Widget _buildMeetingList(MeetingProvider meetingProvider) {
    final meetingsForDate = meetingProvider.meetingsForSelectedDate;
    final now = DateTime.now();

    final previousMeetings = meetingsForDate.where((m) => m.isPrevious(now)).toList();
    final currentMeetings = meetingsForDate.where((m) => m.isCurrent(now)).toList();
    final upcomingMeetings = meetingsForDate.where((m) => m.isUpcoming(now)).toList();

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        if (currentMeetings.isNotEmpty) ...[
          _buildMeetingSection('Current Meetings', currentMeetings, Colors.amber),
          const SizedBox(height: 16),
        ],
        if (upcomingMeetings.isNotEmpty) ...[
          _buildMeetingSection('Upcoming Meetings', upcomingMeetings, Colors.green),
          const SizedBox(height: 16),
        ],
        if (previousMeetings.isNotEmpty) ...[
          _buildMeetingSection('Previous Meetings', previousMeetings, Colors.grey),
        ],
        if (meetingsForDate.isEmpty) const Center(child: Text('No meetings scheduled for this day')),
      ],
    );
  }

  Widget _buildMeetingSection(String title, List<MeetingDate> meetings, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(height: 8),
        ...meetings.map((meeting) => _buildMeetingCard(meeting, color)).toList(),
      ],
    );
  }

  Widget _buildMeetingCard(Meeting meeting, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 8,
                  height: 40,
                  decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(meeting.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(meeting.formattedTime, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(meeting.description, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16),
                const SizedBox(width: 4),
                Text(meeting.location, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
    );
  } */
}
 */