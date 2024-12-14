import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ramadan_taskminder/theme.dart';
import 'package:ramadan_taskminder/widgets/fast_addition_row.dart';
import 'package:ramadan_taskminder/widgets/page_footer.dart';
import 'package:ramadan_taskminder/widgets/page_header.dart';
import 'package:ramadan_taskminder/widgets/screen_footer.dart';
import 'package:ramadan_taskminder/widgets/section_header.dart';
import 'package:ramadan_taskminder/widgets/stacked_card.dart';
import 'package:ramadan_taskminder/widgets/wide_card.dart';

class FastingScreen extends StatefulWidget {
  const FastingScreen({super.key});

  @override
  State<FastingScreen> createState() => _FastingScreenState();
}

class _FastingScreenState extends State<FastingScreen> {
  List history = [];
  Box fastingBox = Hive.box("fasting");

  // Logging
  DateTime fastDate = DateTime.now();
  bool fastComplete = false;

  // Statistics
  int fastsCompleted = 0;
  int fastsMissing = 0;

  // Helpers
  String deletingHistoryEntry = "";

  @override
  void initState() {
    super.initState();
    calculateStatistics();
  }

  void setStartingEntry() {
    fastDate = DateTime.now();
    fastComplete = false;
  }

  void calculateStatistics() {
    fastsCompleted = fastingBox.values.where((fast) => fast == true).length;
    fastsMissing = fastingBox.length - fastsCompleted;
  }

  void confirmEntryDelete() {
    if (deletingHistoryEntry != "") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          final entry = fastingBox.get(deletingHistoryEntry);
          final date = DateTime.parse(deletingHistoryEntry);

          return AlertDialog(
            title: const Text("Confirm Entry Deletion"),
            content: SingleChildScrollView(
              child: Wrap(
                runSpacing: 15,
                children: [
                  const Text(
                      "Are you sure you want to delete the following entry?"),
                  StackedCard(
                    header: DateFormat.yMMMMd().format(date),
                    title: entry ? "Fasted" : "Didn't Fast",
                    fullWidth: true,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text(
                  "Delete",
                  style: TextStyle(
                    color: destructiveActionColor,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    setStartingEntry();
                  });

                  fastingBox.delete(deletingHistoryEntry);
                  deletingHistoryEntry = "";

                  calculateStatistics();

                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  // TODO: Automatically add missing fasts during Ramadan

  @override
  Widget build(BuildContext context) {
    // String currentDate = DateTime.now().toIso8601String().split("T")[0];

    return Material(
      color: getBackgroundColor(context),
      child: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverSafeArea(
                sliver: SliverPadding(
                  padding: const EdgeInsets.only(
                    top: 25.0,
                    left: 20.0,
                    right: 20.0,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        const PageHeader(
                          header: "Fasting",
                          title: "Nothing read today",
                        ),
                        const SizedBox(height: 15),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SectionHeader(
                              title: "Overview",
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                StackedCard(
                                  header: "Completed",
                                  title: fastsCompleted.toString(),
                                ),
                                StackedCard(
                                  header: "Missing",
                                  title: fastsMissing.toString(),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SectionHeader(
                              title: "Log Fast",
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              runSpacing: 10,
                              children: [
                                FastAdditionRow(
                                  date: fastDate,
                                  value: fastComplete,
                                  setDate: (DateTime newDate) {
                                    setState(() {
                                      fastDate = newDate;
                                    });
                                  },
                                  setValue: (bool value) {
                                    setState(() {
                                      fastComplete = value;
                                    });
                                  },
                                ),
                                WideCard(
                                  content: "Log",
                                  textAlign: TextAlign.center,
                                  onTap: () => setState(
                                    () {
                                      final date = fastDate
                                          .toIso8601String()
                                          .split("T")[0];

                                      fastingBox.put(date, fastComplete);

                                      setStartingEntry();
                                      calculateStatistics();
                                    },
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SectionHeader(
                              title: "History",
                            ),
                            SizedBox(height: fastingBox.isNotEmpty ? 10 : 5),
                            fastingBox.isNotEmpty
                                ? Wrap(
                                    runSpacing: 10,
                                    children:
                                        fastingBox.keys.toList().reversed.map(
                                      (dateString) {
                                        final date = DateTime.parse(
                                          dateString.toString(),
                                        );

                                        return StackedCard(
                                          header:
                                              DateFormat.yMMMMd().format(date),
                                          title: fastingBox.get(dateString)
                                              ? "Fasted"
                                              : "Didn't Fast",
                                          fullWidth: true,
                                          onLongPress: () {
                                            deletingHistoryEntry = dateString;
                                            confirmEntryDelete();
                                          },
                                        );
                                      },
                                    ).toList(),
                                  )
                                : const Text("Log some reading first!"),
                          ],
                        ),
                        const ScreenFooter(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const PageFooter()
        ],
      ),
    );
  }
}
