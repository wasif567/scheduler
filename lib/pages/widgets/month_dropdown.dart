import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/core/app_colors/app_colors.dart';
import 'package:scheduler/provider/meeting_provider.dart';

class CustomMonthDropDown extends StatefulWidget {
  const CustomMonthDropDown({super.key});

  @override
  State<CustomMonthDropDown> createState() => _CustomMonthDropDownState();
}

class _CustomMonthDropDownState extends State<CustomMonthDropDown> {
  final int currentYear = DateTime.now().year;
  int? selectedDate;

  List<int> get months => List.generate(12, (index) => index + 1);

  @override
  void initState() {
    selectedDate = DateTime.now().month;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MeetingProvider>(
      builder: (context, state, child) {
        return DropdownButton<int>(
          dropdownColor: AppColors.greyColor,
          style: TextStyle(color: Colors.white),
          underline: const SizedBox(),
          value: state.focusedDay.month,
          hint: Text("Select a month"),
          onChanged: (int? newValue) {
            if (newValue != null) {
              selectedDate = newValue;

              state.focusedDay = DateTime(
                state.focusedDay.year,
                selectedDate!,
                state.focusedDay.day,
              );
              state.fetchingMeeting(state.focusedDay);
            }
          },
          items:
              months.map<DropdownMenuItem<int>>((int date) {
                return DropdownMenuItem<int>(
                  value: date,
                  child: Text(monthNames[date - 1]),
                );
              }).toList(),
        );
      },
    );
  }

  List<String> get monthNames => const [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
}
