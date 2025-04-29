import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/core/app_colors/app_colors.dart';
import 'package:scheduler/pages/widgets/meeting_list.dart';
import 'package:scheduler/pages/widgets/month_dropdown.dart';
import 'package:scheduler/pages/widgets/table_calendar.dart';
import 'package:scheduler/pages/widgets/year_dropdown.dart';
import 'package:scheduler/provider/meeting_provider.dart';

class MeetingSchedulerScreen extends StatelessWidget {
  const MeetingSchedulerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: appBar(context),
      backgroundColor: Colors.black,
      body: Consumer<MeetingProvider>(
        builder: (context, state, child) {
          return SingleChildScrollView(
            child: SizedBox(
              height: kSize.height,
              width: kSize.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomMonthDropDown(),
                        YearDropdown(
                          onChanged: (value) {
                            state.focusedDay = DateTime(
                              value,
                              state.focusedDay.month,
                              1,
                            );
                            state.fetchingMeeting(state.focusedDay);
                          },
                        ),
                      ],
                    ),
                    CustomTableCalendar(),
                    if (state.selectedDate != null &&
                        state.selectedDate!.items.isNotEmpty) ...{
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Meetings ",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.withValues(alpha: 0.4),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 2,
                                color: Colors.grey.withValues(alpha: 0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    },
                    MeetingList(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

AppBar appBar(BuildContext context) {
  final kSize = MediaQuery.sizeOf(context);
  return AppBar(
    backgroundColor: Colors.black,
    actions: [
      IconButton(
        style: IconButton.styleFrom(
          shape: CircleBorder(),
          backgroundColor: AppColors.greyColor,
        ),
        onPressed: () {},
        icon: Icon(Icons.bar_chart_outlined, color: AppColors.upcomingColor),
      ),
      IconButton(
        style: IconButton.styleFrom(
          shape: CircleBorder(),
          backgroundColor: AppColors.greyColor,
        ),
        onPressed: () {},
        icon: Icon(Icons.mail_outline_sharp, color: AppColors.upcomingColor),
      ),
      IconButton(
        style: IconButton.styleFrom(
          shape: CircleBorder(),
          backgroundColor: AppColors.greyColor,
        ),
        onPressed: () {},
        icon: Icon(
          Icons.notifications_active_outlined,
          color: AppColors.upcomingColor,
        ),
      ),
      IconButton(
        style: IconButton.styleFrom(
          shape: CircleBorder(),
          backgroundColor: AppColors.greyColor,
        ),
        onPressed: () {},
        icon: Icon(Icons.menu, color: AppColors.upcomingColor),
      ),
      SizedBox(width: 16),
    ],
    bottom: PreferredSize(
      preferredSize: Size(kSize.width, kSize.height * 0.07),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Meeting List",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            IconButton(
              style: IconButton.styleFrom(
                shape: CircleBorder(),
                backgroundColor: AppColors.upcomingColor,
              ),
              onPressed: () {},
              icon: Icon(Icons.add, color: Colors.white),
            ),
          ],
        ),
      ),
    ),
  );
}
