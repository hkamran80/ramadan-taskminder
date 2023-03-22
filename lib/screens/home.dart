import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ramadan_taskminder/constants.dart';
import 'package:ramadan_taskminder/theme.dart';
import 'package:ramadan_taskminder/tasks.dart';
import 'package:ramadan_taskminder/widgets/page_footer.dart';
import 'package:ramadan_taskminder/widgets/page_header.dart';
import 'package:ramadan_taskminder/widgets/section_header.dart';
import 'package:ramadan_taskminder/widgets/statistic_card.dart';
import 'package:ramadan_taskminder/widgets/wide_card.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime current = DateTime.now();
  HijriCalendar hijriCurrent = HijriCalendar.now();
  Box tasks =
      Hive.box("tasks_${DateTime.now().toIso8601String().split("T")[0]}");
  Box quran = Hive.box("quran");

  @override
  void initState() {
    super.initState();
    initializeTasks();
    initializeHistory();
  }

  void initializeTasks() {
    for (var task in allTasks) {
      if (tasks.get(task) == null) {
        tasks.put(task, false);
      }
    }
  }

  void initializeHistory() {
    List? quranHistory = quran.get("history");
    if (quranHistory == null) {
      quran.put("history", []);
    }
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(feedbackUrl)) {
      throw Exception('Could not launch $feedbackUrl');
    }
  }

  @override
  Widget build(BuildContext context) {
    Iterable incompleteTasks =
        tasks.toMap().entries.where((task) => task.value == false);

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
                          title:
                              "${hijriCurrent.hDay} ${hijriCurrent.longMonthName} ${hijriCurrent.hYear}",
                          rightAlign: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                current.day.toString(),
                                style: GoogleFonts.mPlus1p(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 32,
                                  letterSpacing: 0,
                                ),
                              ),
                              Text(
                                DateFormat.MMMM().format(current).toUpperCase(),
                                style: GoogleFonts.mPlus1p(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14,
                                  letterSpacing: 0,
                                ),
                              ),
                            ],
                          ),
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
                              subtitle:
                                  "${tasks.length - incompleteTasks.length}/${tasks.length} completed",
                              buttonText: "View All",
                              onClick: (() =>
                                  GoRouter.of(context).go("/tasks")),
                            ),
                            const SizedBox(height: 15),
                            incompleteTasks.isNotEmpty
                                ? Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: incompleteTasks
                                        .take(4)
                                        .map(
                                          (task) => Statistic(
                                            statistic: task.key,
                                          ),
                                        )
                                        .toList(),
                                  )
                                : const Text(
                                    "You've completed all tasks! Congratulations!",
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
                            SectionHeader(
                              title: "Qur'an",
                              subtitle:
                                  "${quran.get('history').length} entries",
                              buttonText: "Track",
                              onClick: (() =>
                                  GoRouter.of(context).go("/quran")),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        WideCard(
                          content: "Submit feedback",
                          onTap: () => _launchUrl(),
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
