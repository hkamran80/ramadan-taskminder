import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ramadan_taskminder/constants.dart';
import 'package:ramadan_taskminder/tasks.dart';
import 'package:ramadan_taskminder/theme.dart';
import 'package:ramadan_taskminder/widgets/page_footer.dart';
import 'package:ramadan_taskminder/widgets/page_header.dart';
import 'package:ramadan_taskminder/widgets/section_header.dart';
import 'package:ramadan_taskminder/widgets/statistic_card.dart';
import 'package:ramadan_taskminder/widgets/wide_card.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
                        const PageHeader(
                          header: appName,
                          title: "Settings",
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SectionHeader(
                              title: "Tasks",
                              subtitle: "Add or edit your tasks",
                              buttonText: "Edit",
                              onClick: () =>
                                  GoRouter.of(context).push("/settings/tasks"),
                            ),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: allTasks
                                  .take(4)
                                  .map(
                                    (task) => Statistic(
                                      statistic: task,
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        WideCard(
                          content: "About $appName",
                          onTap: () =>
                              GoRouter.of(context).push("/settings/about"),
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
