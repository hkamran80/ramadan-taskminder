import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ramadan_taskminder/theme.dart';
import 'package:ramadan_taskminder/tasks.dart';
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
  List<String> complete = [];
  List<String> incomplete = [];

  Box tasks = Hive.box("tasks");

  @override
  void initState() {
    super.initState();

    initializeTasks();
  }

  void initializeTasks() {
    for (var task in initialTasks) {
      bool? taskStatus = tasks.get(task);
      if (taskStatus == null || taskStatus == false) {
        tasks.put(task, false);
        incomplete.add(task);
      } else if (taskStatus == true) {
        complete.add(task);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        PageHeader(
                          header: "Tasks",
                          title:
                              "${complete.length}/${initialTasks.length} completed",
                          hintText:
                              "Tap an item to mark it as complete/incomplete",
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
                            SizedBox(height: incomplete.isNotEmpty ? 10 : 5),
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
                                              tasks.put(task, true);
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
                            SizedBox(height: complete.isNotEmpty ? 10 : 5),
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
                                              tasks.put(task, false);
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
