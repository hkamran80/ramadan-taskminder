import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ramadan_taskminder/extensions/date.dart';
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
  DateTime current = DateTime.now();
  List<String> complete = [];
  List<String> incomplete = [];

  Box tasksBox = Hive.box("tasks");
  late List<String> allTasks;
  late Map<String, bool> tasks;

  @override
  void initState() {
    super.initState();
    initializeTasks();
  }

  void initializeTasks() {
    allTasks =
        tasksBox.get("allTasks", defaultValue: initialTasks) as List<String>;
    tasks = Map.from(
      tasksBox.get(current.getYMD(), defaultValue: {}),
    );

    for (var task in allTasks) {
      bool taskPresent = tasks.containsKey(task);
      if (!taskPresent) {
        tasks[task] = false;
        incomplete.add(task);
      } else if (tasks[task] == false) {
        incomplete.add(task);
      } else if (tasks[task] == true) {
        complete.add(task);
      }
    }

    tasksBox.put(current.getYMD(), tasks);
  }

  void toggleTask(String task, bool currentState) {
    if (currentState == true) {
      complete.remove(task);
      incomplete.add(task);
    } else {
      incomplete.remove(task);
      complete.add(task);
    }

    tasks[task] = !currentState;
    tasksBox.put(current.getYMD(), tasks);
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
                              "${complete.length}/${allTasks.length} completed",
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
                                            onTap: () => setState(
                                              () => toggleTask(task, false),
                                            ),
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
                                            onTap: () => setState(
                                              () => toggleTask(task, true),
                                            ),
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
