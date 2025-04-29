import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/provider/meeting_provider.dart';

class MeetingList extends StatelessWidget {
  const MeetingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MeetingProvider>(
      builder: (context, state, child) {
        if (state.selectedMeetings != null && state.selectedMeetings!.isNotEmpty) {
          return Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return Container();
              },
              separatorBuilder: (context, index) {
                return SizedBox();
              },
              itemCount: state.selectedMeetings!.length,
            ),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
