import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/core/app_colors/app_colors.dart';
import 'package:scheduler/provider/meeting_provider.dart';

class YearDropdown extends StatefulWidget {
  final Function(int) onChanged;
  const YearDropdown({super.key, required this.onChanged});

  @override
  State<YearDropdown> createState() => _YearDropdownState();
}

class _YearDropdownState extends State<YearDropdown> {
  final List<int> years = List.generate(101, (index) => 2000 + index);

  @override
  Widget build(BuildContext context) {
    return Consumer<MeetingProvider>(
      builder: (context, state, child) {
        int selectedYear = state.focusedDay.year;
        return DropdownButton<int>(
          dropdownColor: AppColors.greyColor,
          value: selectedYear,
          isDense: true,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          underline: const SizedBox(),
          hint: const Text("Select a year"),
          onChanged: (int? newValue) {
            if (newValue != null) {
              setState(() {
                selectedYear = newValue;
                widget.onChanged(selectedYear);
              });
            }
          },
          items:
              years.map<DropdownMenuItem<int>>((int year) {
                return DropdownMenuItem<int>(
                  value: year,
                  child: Text(year.toString()),
                );
              }).toList(),
        );
      },
    );
  }
}


/* import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/provider/meeting_provider.dart';

class YearSelection extends StatefulWidget {
  const YearSelection({super.key});

  @override
  State<YearSelection> createState() => _YearSelectionState();
}

class _YearSelectionState extends State<YearSelection> {
  List<int> years = List.generate(101, (index) => 2000 + index);
  @override
  Widget build(BuildContext context) {
    return Consumer<MeetingProvider>(
      builder: (context, state, child) {
        return DropdownButton(
          underline: const SizedBox(),
          style: TextStyle(color: Colors.white, fontSize: 14),
          value: state.focusedDay.year,
          items:
              years.map((int year) {
                return DropdownMenuItem<int>(
                  value: year,
                  child: Text(year.toString()),
                );
              }).toList(),
          onTap: () async {
            _showYearDialog();
          },
          onChanged: (value) {},
        );
      },
    );
  }

  Future<void> _showYearDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        MeetingProvider provider = Provider.of(context, listen: false);
        int? tempSelectedYear = provider.focusedDay.year;
        return Consumer<MeetingProvider>(
          builder: (context, state, child) {
            return AlertDialog(
              title: Text('Select Year'),
              content: DropdownButton<int>(
                isExpanded: true,
                hint: Text("Choose a year"),
                value: tempSelectedYear,
                items: List.generate(101, (index) {
                  int year = 2000 + index;
                  return DropdownMenuItem(
                    value: year,
                    child: Text(year.toString()),
                  );
                }),
                onChanged: (int? newValue) {
                  setState(() {
                    tempSelectedYear = newValue;
                  });
                  Navigator.of(context).pop(); // Close dialog on selection
                  // setState(() {
                  state.focusedDay = DateTime(
                    newValue!,
                    state.focusedDay.month,
                    state.focusedDay.day,
                  );
                  state.fetchingMeeting(state.focusedDay);
                  // });
                },
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
 */