import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ramadan_taskminder/constants.dart';
import 'package:ramadan_taskminder/widgets/page_footer.dart';
import 'package:ramadan_taskminder/widgets/page_header.dart';
import 'package:ramadan_taskminder/widgets/section_header.dart';
import 'package:ramadan_taskminder/widgets/wide_card.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  final List<String> incomplete = [
    "Istighfar (70+)",
    "Shukr (Alhamduillah)",
    "Give Charity",
    "Recite Qur'an",
    "Evening Adhkar",
    "Adhkar Before Sleep",
  ];
  final List<String> complete = [
    "Morning Adhkar",
    "Random Kindess",
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      child: CustomScrollView(
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
                    PageHeader(
                      header: "Tasks",
                      title:
                          "${complete.length}/${complete.length + incomplete.length} completed",
                      hintText: "Tap an item to mark it as complete/incomplete",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionHeader(
                          title: "Incomplete",
                        ),
                        SizedBox(height: incomplete.isNotEmpty ? 15 : 5),
                        incomplete.isNotEmpty
                            ? Wrap(
                                runSpacing: 10,
                                children: incomplete
                                    .map(
                                      (task) => WideCard(
                                        content: task,
                                        onTap: () => setState(() {
                                          incomplete.remove(task);
                                          complete.add(task);
                                        }),
                                      ),
                                    )
                                    .toList(),
                              )
                            : const Text(
                                "You've completed all tasks! Congratulations!",
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
                          title: "Complete",
                        ),
                        SizedBox(height: complete.isNotEmpty ? 15 : 5),
                        complete.isNotEmpty
                            ? Wrap(
                                runSpacing: 10,
                                children: complete
                                    .map(
                                      (task) => WideCard(
                                        content: task,
                                        onTap: () => setState(() {
                                          complete.remove(task);
                                          incomplete.add(task);
                                        }),
                                      ),
                                    )
                                    .toList(),
                              )
                            : const Text(
                                "No completed tasks yet. Complete tasks by tapping the card.",
                              )
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const PageFooter()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
