import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/core/app_images/app_images.dart';
import 'package:scheduler/models/meeting_item/meeting_item.dart';
import 'package:scheduler/provider/meeting_provider.dart';

class MeetingList extends StatelessWidget {
  const MeetingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MeetingProvider>(
      builder: (context, state, child) {
        if (state.selectedDate != null &&
            state.selectedDate!.items.isNotEmpty) {
          return Expanded(
            child: Column(
              children: List.generate(state.selectedMeetings!.length, (index) {
                MeetingItem item = state.selectedDate!.items[index];
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  margin: EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: Color(0xFF131925),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            item.meetingTime,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Divider(
                          color: Colors.grey.withValues(alpha: 0.6),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat(
                              'EEEE, MMMM d',
                            ).format(DateTime.parse(state.selectedDate!.date)),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          if (item.conflicted) ...{
                            Image.asset(AppImages.conflictIcon),
                          },
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
