import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
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

  @override
  void initState() {
    super.initState();
    initializeTasks();
  }

  void initializeTasks() {
    allTasks =
        tasksBox.get("allTasks", defaultValue: initialTasks) as List<String>;
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
                          rightAlign: TextButton(
                            onPressed: () => showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) => AddTaskModal(
                                addTask: (String task) {
                                  setState(
                                    () {
                                      allTasks.add(task);
                                    },
                                  );
                                },
                              ),
                            ),
                            child: Text(
                              "Add Task".toUpperCase(),
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
                            onReorder: (int oldindex, int newindex) {
                              setState(() {
                                if (newindex > oldindex) {
                                  newindex -= 1;
                                }
                                final items = allTasks.removeAt(oldindex);
                                allTasks.insert(newindex, items);
                              });
                            },
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
                                      child: const Icon(Icons.drag_handle),
                                    ),
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
