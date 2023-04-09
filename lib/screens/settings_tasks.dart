import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan_taskminder/constants.dart';
import 'package:ramadan_taskminder/theme.dart';
import 'package:ramadan_taskminder/tasks.dart';
import 'package:ramadan_taskminder/widgets/add_task_modal.dart';
import 'package:ramadan_taskminder/widgets/page_footer.dart';
import 'package:ramadan_taskminder/widgets/page_header.dart';
import 'package:ramadan_taskminder/widgets/wide_card.dart';

class SettingsTasksScreen extends StatefulWidget {
  const SettingsTasksScreen({super.key});

  @override
  State<SettingsTasksScreen> createState() => _SettingsTasksScreenState();
}

class _SettingsTasksScreenState extends State<SettingsTasksScreen> {
  Box tasksBox = Hive.box("tasks");
  late List<String> allTasks;

  String deletingTask = "";

  @override
  void initState() {
    super.initState();
    initializeTasks();
  }

  void initializeTasks() {
    allTasks =
        tasksBox.get("allTasks", defaultValue: initialTasks) as List<String>;
  }

  void reorder(int oldindex, int newindex) {
    setState(
      () {
        if (newindex > oldindex) {
          newindex -= 1;
        }
        final items = allTasks.removeAt(oldindex);
        allTasks.insert(newindex, items);
      },
    );

    updateTasks();
  }

  void updateTasks() {
    tasksBox.put("allTasks", allTasks);
  }

  void confirmEntryDelete() {
    if (deletingTask != "") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Confirm Entry Deletion"),
            content: SingleChildScrollView(
              child: Wrap(
                runSpacing: 15,
                children: [
                  const Text(
                      "Are you sure you want to delete the following task?"),
                  WideCard(
                    content: deletingTask,
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
                    allTasks.remove(deletingTask);
                  });

                  updateTasks();
                  deletingTask = "";

                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
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
                          header: appName,
                          title: "Edit Tasks",
                          priorPathName: "Settings",
                          hintText: "Drag the handles on each task to rearrange. Long press on a task to delete.",
                          rightAlign: TextButton(
                            onPressed: () => showModalBottomSheet( 
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) => AddTaskModal(
                                addTask: (String task) {
                                  setState(
                                    () {
                                      allTasks.add(task);
                                    },
                                  );

                                  updateTasks();
                                },
                              ),
                            ),
                            child: Text(
                              "ADD TASK",
                              style: TextStyle(
                                color: getButtonTextColor(context),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height - 75,
                          child: ReorderableListView(
                            onReorder: reorder,
                            children: [
                              for (final task in allTasks)
                                Card(
                                  color: Colors.blueGrey,
                                  key: ValueKey(task),
                                  elevation: 2,
                                  child: WideCard(
                                    content: task,
                                    trailing: ReorderableDragStartListener(
                                      index: allTasks.indexOf(task),
                                      child: Icon(
                                        LucideIcons.gripVertical,
                                        color: getButtonTextColor(context),
                                      ),
                                    ),
                                    onLongPress: () {
                                      deletingTask = task;
                                      confirmEntryDelete();
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 75,
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
