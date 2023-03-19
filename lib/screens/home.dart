import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ramadan_taskminder/constants.dart';
import 'package:ramadan_taskminder/tasks.dart';
import 'package:ramadan_taskminder/widgets/page_footer.dart';
import 'package:ramadan_taskminder/widgets/page_header.dart';
import 'package:ramadan_taskminder/widgets/section_header.dart';
import 'package:ramadan_taskminder/widgets/stacked_card.dart';
import 'package:ramadan_taskminder/widgets/statistic_card.dart';

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

  @override
  void initState() {
    super.initState();
    initializeTasks();
  }

  void initializeTasks() {
    for (var task in allTasks) {
      if (tasks.get(task) == null) {
        tasks.put(task, false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Iterable incompleteTasks =
        tasks.toMap().entries.where((task) => task.value == false);

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
                        const SectionHeader(
                          title: "Times",
                          subtitle: "Lafayette, CA, U.S.",
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            StackedCard(
                              header: "Suhoor",
                              title: "5:55 AM",
                            ),
                            StackedCard(
                              header: "Iftar",
                              title: "7:25 PM",
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
                        SectionHeader(
                          title: "Tasks",
                          subtitle:
                              "${tasks.length - incompleteTasks.length}/${tasks.length} completed",
                          buttonText: "View All",
                          onClick: (() => GoRouter.of(context).go("/tasks")),
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
                          subtitle: "Nothing read today",
                          buttonText: "Track",
                          onClick: (() => GoRouter.of(context).go("/quran")),
                        ),
                        const SizedBox(height: 15),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: const [
                            Statistic(statistic: "2% read"),
                            Statistic(statistic: "126 ayahs"),
                            Statistic(statistic: "85% of Juz 1"),
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
                          title: "Prayers",
                          subtitle: "Keep up the good work!",
                          buttonText: "Track",
                        ),
                        const SizedBox(height: 15),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: const [
                            Statistic(statistic: "6 Fardh"),
                            Statistic(statistic: "10 Sunnah"),
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
                      children: const [
                        SectionHeader(
                          title: "Hadith of the Day",
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Whoever recites a letter from the Book of Allah, he will receive one good deed as ten good deeds like it. I do not say that Alif Lam Meem is one letter, but rather Alif is a letter, Lam is a letter, and Meem is a letter.\n\nTirmidhi",
                          style: TextStyle(
                            letterSpacing: 0,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SectionHeader(
                          title: "Du'a of the Day",
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "رَّبِّ اغْفِرْ وَارْحَمْ وَأَنتَ خَيْرُ الرَّاحِمِينَ",
                            style: TextStyle(
                              fontSize: 20,
                              letterSpacing: 0,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "My Lord! Forgive and have mercy, for You are the best of those who show mercy.\n\nAl-Mu'minun, 23:118",
                          style: TextStyle(
                            letterSpacing: 0,
                          ),
                        )
                      ],
                    ),
                    const PageFooter(),
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
