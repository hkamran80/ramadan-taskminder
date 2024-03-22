import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:ramadan_taskminder/constants.dart';
import 'package:ramadan_taskminder/tasks.dart';
import 'package:ramadan_taskminder/theme.dart';
import 'package:ramadan_taskminder/widgets/data_row.dart';
import 'package:ramadan_taskminder/widgets/page_footer.dart';
import 'package:ramadan_taskminder/widgets/page_header.dart';
import 'package:ramadan_taskminder/widgets/screen_footer.dart';
import 'package:ramadan_taskminder/widgets/section_header.dart';
import 'package:ramadan_taskminder/widgets/stacked_card.dart';
import 'package:ramadan_taskminder/widgets/statistic_card.dart';
import 'package:ramadan_taskminder/widgets/wide_card.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Box tasksBox = Hive.box("tasks");
  Box settingsBox = Hive.box("settings");

  late List<String> allTasks;
  late int dateOffset;

  String version = "";
  String buildNumber = "";

  @override
  void initState() {
    super.initState();
    initializeTasks();
    calculateOffset();
    loadPackageInfo();
  }

  void initializeTasks() {
    allTasks =
        tasksBox.get("allTasks", defaultValue: initialTasks) as List<String>;
  }

  void calculateOffset() {
    setState(() => dateOffset = settingsBox.get("dateOffset", defaultValue: 0));
  }

  void editDateOffset() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Edit Hijri Date Offset"),
          content: StatefulBuilder(
            builder: (
              BuildContext context,
              StateSetter setState,
            ) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  RadioListTile<int>(
                    title: const Text("-1 day"),
                    value: -1,
                    groupValue: dateOffset,
                    visualDensity: const VisualDensity(
                      horizontal: VisualDensity.minimumDensity,
                      vertical: VisualDensity.minimumDensity,
                    ),
                    contentPadding: const EdgeInsets.all(0.0),
                    onChanged: (value) {
                      setState(() {
                        if (value != null) {
                          settingsBox.put("dateOffset", value);
                          calculateOffset();
                        }
                      });
                    },
                  ),
                  RadioListTile<int>(
                    title: const Text("0 days"),
                    value: 0,
                    groupValue: dateOffset,
                    visualDensity: const VisualDensity(
                      horizontal: VisualDensity.minimumDensity,
                      vertical: VisualDensity.minimumDensity,
                    ),
                    contentPadding: const EdgeInsets.all(0.0),
                    onChanged: (value) {
                      setState(() {
                        if (value != null) {
                          settingsBox.put("dateOffset", value);
                          calculateOffset();
                        }
                      });
                    },
                  ),
                  RadioListTile<int>(
                    title: const Text("1 day"),
                    value: 1,
                    groupValue: dateOffset,
                    visualDensity: const VisualDensity(
                      horizontal: VisualDensity.minimumDensity,
                      vertical: VisualDensity.minimumDensity,
                    ),
                    contentPadding: const EdgeInsets.all(0.0),
                    onChanged: (value) {
                      setState(() {
                        if (value != null) {
                          settingsBox.put("dateOffset", value);
                          calculateOffset();
                        }
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              child: Text(
                "Set",
                style: TextStyle(
                  color: isDark(context) ? primaryLightColor : primaryDarkColor,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void loadPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(
      () {
        version = packageInfo.version;
        buildNumber = packageInfo.buildNumber;
      },
    );
  }

  void _launchUrl(Uri uri) async {
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $uri';
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
                          height: 15,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SectionHeader(
                              title: "Hijri Date Offset",
                              buttonText: "Edit",
                              onClick: () => editDateOffset(),
                            ),
                            const SizedBox(height: 5),
                            Statistic(
                              statistic:
                                  "$dateOffset day${dateOffset == 0 ? "s" : ""}",
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        DataHandlingRow(
                          version: "$version ($buildNumber)",
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SectionHeader(
                              title: "About",
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                StackedCard(
                                  header: "Version",
                                  title: "$version ($buildNumber)",
                                ),
                                StackedCard(
                                  header: "Creator",
                                  title: "H. Kamran",
                                  onTap: () => _launchUrl(hkamranUrl),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            WideCard(
                              content: "Submit feedback",
                              onTap: () => _launchUrl(feedbackUrl),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                WideCard(
                                  content: "View source code",
                                  halfWidth: true,
                                  onTap: () => _launchUrl(repositoryUrl),
                                ),
                                WideCard(
                                  content: "View licenses",
                                  halfWidth: true,
                                  onTap: () => showLicensePage(
                                    context: context,
                                    applicationName: appName,
                                    applicationVersion:
                                        "$version ($buildNumber)",
                                    applicationLegalese:
                                        "Copyright © 2023 Thirteenth Willow. All rights reserved.",
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 25),
                            const Text(
                              "No data from $appName ever leaves your device.",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              "Copyright © 2023-2024 Thirteenth Willow. All rights reserved.",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12),
                            ),
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
