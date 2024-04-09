import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ramadan_taskminder/constants.dart';
import 'package:ramadan_taskminder/extensions/date.dart';
import 'package:ramadan_taskminder/prayers.dart';
import 'package:ramadan_taskminder/quran.dart';
import 'package:ramadan_taskminder/theme.dart';
import 'package:ramadan_taskminder/tasks.dart';
import 'package:ramadan_taskminder/widgets/page_footer.dart';
import 'package:ramadan_taskminder/widgets/page_header.dart';
import 'package:ramadan_taskminder/widgets/screen_footer.dart';
import 'package:ramadan_taskminder/widgets/section_header.dart';
import 'package:ramadan_taskminder/widgets/statistic_card.dart';
import 'package:ramadan_taskminder/widgets/wide_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime current = DateTime.now();
  HijriCalendar hijriCurrent = HijriCalendar.now();

  Box tasksBox = Hive.box("tasks");
  Box prayersBox = Hive.box("prayers");
  Box quran = Hive.box("quran");

  late List<String> allTasks;
  late Map<String, bool> tasks;
  late Map<String, bool> prayers;

  @override
  void initState() {
    super.initState();
    firstRun();
    initializeTasks();
    initializeHistory();
    initializePrayers();
  }

  void firstRun() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool firstRun = preferences.getBool("firstRun") ?? true;
    if (firstRun) {
      tasksBox.put("allTasks", initialTasks);
      preferences.setBool("firstRun", false);
    }
  }

  void initializeTasks() {
    allTasks =
        tasksBox.get("allTasks", defaultValue: initialTasks) as List<String>;
    tasks = Map.from(
      tasksBox.get(current.getYMD(), defaultValue: {}),
    );

    for (var task in allTasks) {
      if (!tasks.containsKey(task)) {
        tasks[task] = false;
      }
    }

    Map.from(tasks).forEach(
      (key, _) {
        if (!allTasks.contains(key)) {
          tasks.remove(key);
        }
      },
    );

    tasksBox.put(current.getYMD(), tasks);
  }

  void initializeHistory() {
    List? quranHistory = quran.get("history");
    if (quranHistory == null) {
      quran.put("history", []);
    }
  }

  void initializePrayers() {
    prayers = Map.from(
      prayersBox.get(current.getYMD(), defaultValue: {}),
    );

    for (var task in allPrayers) {
      bool taskPresent = prayers.containsKey(task);
      if (!taskPresent) {
        prayers[task] = false;
      }
    }

    prayersBox.put(current.getYMD(), prayers);
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(
      feedbackUrl,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $feedbackUrl');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<MapEntry<String, bool>> incompleteTasks = tasks.entries
        .where(
          (task) => task.value == false,
        )
        .toList();
    incompleteTasks.sort(
      (a, b) => allTasks.indexOf(a.key).compareTo(
            allTasks.indexOf(b.key),
          ),
    );

    String currentDate = DateTime.now().toIso8601String().split("T")[0];
    List history = quran.get("history");
    List todaysEntries =
        history.where((entry) => entry[0] == currentDate).toList();
    int ayahsRead = calculateAyahsRead(history);
    String percentageRead =
        ((ayahsRead / totalAyahCount) * 100).toStringAsFixed(1);
    if (percentageRead.endsWith(".0")) {
      percentageRead = percentageRead.split(".")[0];
    }

    Iterable completedPrayers = prayers.entries
        .where(
          (prayer) => prayer.value == true,
        )
        .map(
          (prayer) => prayer.key,
        );
    int fardhComplete = completedPrayers
        .where(
          (prayer) =>
              !prayer.contains(
                "Sunnah",
              ) &&
              prayer != "Tahajjud" &&
              prayer != "Taraweeh",
        )
        .length;

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
                                  GoRouter.of(context).push("/tasks")),
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
                              subtitle: todaysEntries.isEmpty
                                  ? "Nothing read today"
                                  : "${calculateAyahsRead(todaysEntries)} ayahs read today",
                              buttonText: "Track",
                              onClick: (() =>
                                  GoRouter.of(context).push("/quran")),
                            ),
                            const SizedBox(height: 15),
                            history.isNotEmpty
                                ? Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: [
                                      Statistic(
                                        statistic: "$percentageRead% read",
                                      ),
                                      Statistic(
                                        statistic: "$ayahsRead ayahs",
                                      ),
                                    ],
                                  )
                                : const Text(
                                    "You haven't logged any entries yet.",
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
                              title: "Prayers",
                              subtitle: completedPrayers.isEmpty
                                  ? "No prayers logged"
                                  : "Keep up the good work!",
                              buttonText: "View All",
                              onClick: (() =>
                                  GoRouter.of(context).push("/prayers")),
                            ),
                            const SizedBox(height: 15),
                            completedPrayers.isNotEmpty
                                ? Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: [
                                      Statistic(
                                        statistic: "$fardhComplete Fardh",
                                      ),
                                      Statistic(
                                        statistic:
                                            "${completedPrayers.length - fardhComplete} Sunnah",
                                      ),
                                    ],
                                  )
                                : const Text(
                                    "Go and pray!",
                                  ),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        WideCard(
                          content: "Eid Takbeers",
                          onTap: () => GoRouter.of(context).push("/eid-takbeer"),
                        ),
                        const SizedBox(height: 15),
                        WideCard(
                          content: "Submit feedback",
                          onTap: () => _launchUrl(),
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
