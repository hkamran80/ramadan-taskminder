import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ramadan_taskminder/theme.dart';
import 'package:ramadan_taskminder/widgets/stacked_card.dart';

class FastAdditionRow extends StatefulWidget {
  const FastAdditionRow({
    Key? key,
    required this.date,
    required this.value,
    required this.setDate,
    required this.setValue,
  }) : super(key: key);

  final DateTime date;
  final bool value;
  final Function setDate;
  final Function setValue;

  @override
  State<FastAdditionRow> createState() => _FastAdditionRowState();
}

class _FastAdditionRowState extends State<FastAdditionRow> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () async {
            DateTime? newDate = await showDatePicker(
              context: context,
              // builder: ((context, child) {
              //   return Theme(
              //     data: Theme.of(context).copyWith(
              //         colorScheme: isDark(context)
              //             ? ColorScheme.dark(
              //                 primary: primaryDarkColor,
              //                 onPrimary: Colors.white,
              //                 surface: Colors.black,
              //                 onSurface: Colors.white,
              //               )
              //             : null),
              //     child: child!,
              //   );
              // }),
              firstDate: DateTime(2023),
              lastDate: DateTime.now(),
              initialDate: widget.date,
              initialEntryMode: DatePickerEntryMode.calendarOnly,
              helpText: "Select the date of your fast",
            );

            if (newDate != null) widget.setDate(newDate);
          },
          child: StackedCard(
            header: "Date",
            title: DateFormat.yMMMMd().format(widget.date),
          ),
        ),
        InkWell(
          onTap: () => widget.setValue(!widget.value),
          child: StackedCard(
            header: "Fasted?",
            title: widget.value ? "Yes" : "No",
          ),
        ),
      ],
    );
  }
}
