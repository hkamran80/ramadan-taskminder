import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:jhijri/jHijri.dart';
import 'package:ramadan_taskminder/date.dart';
import 'package:ramadan_taskminder/extensions/date.dart';
import 'package:ramadan_taskminder/theme.dart';
import 'package:ramadan_taskminder/quran.dart';
import 'package:ramadan_taskminder/widgets/page_footer.dart';
import 'package:ramadan_taskminder/widgets/page_header.dart';
import 'package:ramadan_taskminder/widgets/quran_addition_row.dart';
import 'package:ramadan_taskminder/widgets/screen_footer.dart';
import 'package:ramadan_taskminder/widgets/section_header.dart';
import 'package:ramadan_taskminder/widgets/stacked_card.dart';
import 'package:ramadan_taskminder/widgets/wide_card.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  List history = [];
  Box quran = Hive.box("quran");

  // Logging
  int startingSurah = -1;
  int startingAyah = 0;

  int endingSurah = -1;
  int endingAyah = 0;

  // Statistics
  int ayahsRead = 0;
  String percentageRead = "0";

  // Helpers
  bool showHelp = false;
  int deletingHistoryEntry = -1;

  @override
  void initState() {
    super.initState();
    initializeHistory();
    setStartingEntry();
    calculateStatistics();
  }

  void initializeHistory() {
    List? quranHistory = quran.get("history");
    if (quranHistory == null) {
      quran.put("history", []);
    } else {
      history = quranHistory;
      history.sort(
        (a, b) => DateTime.parse(a[0][0].toString())
            .compareTo(DateTime.parse(b[0][0].toString())),
      );
    }
  }

  void setStartingEntry() {
    if (history.isNotEmpty) {
      final lastEntry = (history.last[1] as List<String>)[1]
          .split("-")
          .map(int.parse)
          .toList();

      int currentSurahAyahs =
          int.parse(surahs[lastEntry[0] - 1]["ayahs"].toString());

      startingSurah = surahs.length == lastEntry[0] ? 1 : lastEntry[0];
      if (lastEntry[1] < currentSurahAyahs) {
        startingSurah = lastEntry[0] - 1;
      }

      startingAyah = lastEntry[1] < currentSurahAyahs ? lastEntry[1] + 1 : 1;
    } else {
      startingSurah = -1;
      startingAyah = 0;

      endingSurah = -1;
      endingAyah = 0;
    }
  }

  void confirmEntryDelete() {
    if (deletingHistoryEntry != -1) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          final entry = history[deletingHistoryEntry];
          final date = DateTime.parse(entry[0].toString());
          final hijriDate = HijriCalendar.fromDate(date);

          final starting = (entry[1] as List<String>)[0].split("-");
          final ending = (entry[1] as List<String>)[1].split("-");

          return AlertDialog(
            title: const Text("Confirm Entry Deletion"),
            content: SingleChildScrollView(
              child: Wrap(
                runSpacing: 15,
                children: [
                  const Text(
                      "Are you sure you want to delete the following entry?"),
                  StackedCard(
                    header:
                        "${DateFormat.MMMMd().format(date)} / ${hijriDate.longMonthName} ${hijriDate.hDay}",
                    title:
                        "${surahs[int.parse(starting[0]) - 1]["name"].toString()} ${starting[1]} - ${surahs[int.parse(ending[0]) - 1]["name"].toString()} ${ending[1]}",
                    fullWidth: true,
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
                    history.removeAt(deletingHistoryEntry);
                    setStartingEntry();
                  });

                  quran.put("history", history);
                  deletingHistoryEntry = -1;

                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void calculateStatistics() {
    ayahsRead = calculateAyahsRead(history);
    percentageRead = ((ayahsRead / totalAyahCount) * 100).toStringAsFixed(1);
    if (percentageRead.endsWith(".0")) {
      percentageRead = percentageRead.split(".")[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    String currentDate = DateTime.now().toIso8601String().split("T")[0];
    List todaysEntries =
        history.where((entry) => entry[0] == currentDate).toList();

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
                          header: "Qur'an",
                          title: todaysEntries.isEmpty
                              ? "Nothing read today"
                              : "${calculateAyahsRead(todaysEntries)} ayahs read today",
                        ),
                        const SizedBox(height: 15),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SectionHeader(
                              title: "Overview",
                            ),
                            const SizedBox(height: 15),
                            Wrap(
                              runSpacing: 10,
                              children: [
                                WideCard(
                                  content: "$percentageRead% read of Qur'an",
                                ),
                                WideCard(
                                  content: "$ayahsRead ayahs read",
                                ),
                              ],
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
                              title: "Log Reading",
                              buttonText: "Help",
                              onClick: (() =>
                                  setState(() => showHelp = !showHelp)),
                            ),
                            showHelp
                                ? const Text(
                                    "Enter the starting surah/ayah, then the ending surah/ayah. The ending input will be visible after the starting input is set, and the log button will be visible after the ending input is set.",
                                    style: TextStyle(fontSize: 12),
                                  )
                                : const SizedBox(),
                            const SizedBox(height: 10),
                            Wrap(
                              runSpacing: 10,
                              children: [
                                QuranAdditionRow(
                                  surahIndex: startingSurah,
                                  ayah: startingAyah,
                                  setSurah: (int index) {
                                    setState(() {
                                      startingSurah = index;
                                    });
                                  },
                                  setAyah: (int ayah) {
                                    setState(() {
                                      startingAyah = ayah;
                                    });
                                  },
                                ),
                                startingSurah != -1 && startingAyah != 0
                                    ? QuranAdditionRow(
                                        surahIndex: endingSurah,
                                        ayah: endingAyah,
                                        setSurah: (int index) {
                                          setState(() {
                                            endingSurah = index;
                                          });
                                        },
                                        setAyah: (int ayah) {
                                          setState(() {
                                            endingAyah = ayah;
                                          });
                                        },
                                      )
                                    : const SizedBox(),
                                startingSurah != -1 &&
                                        startingAyah != 0 &&
                                        endingSurah != -1 &&
                                        endingAyah != 0
                                    ? WideCard(
                                        content: "Log",
                                        textAlign: TextAlign.center,
                                        onTap: () => setState(
                                          () {
                                            final entry = [
                                              [
                                                DateTime.now()
                                                    .toIso8601String()
                                                    .split("T")[0],
                                                JHijri(
                                                  fDate:
                                                      DateTime.now().subtract(
                                                    const Duration(days: 1),
                                                  ),
                                                  fDisplay:
                                                      DisplayFormat.YYYYMMDD,
                                                ).fullDate,
                                              ],
                                              [
                                                "${startingSurah + 1}-$startingAyah",
                                                "${endingSurah + 1}-$endingAyah"
                                              ]
                                            ];

                                            history.add(entry);
                                            quran.put("history", history);

                                            endingSurah = -1;
                                            endingAyah = 0;

                                            setStartingEntry();
                                            calculateStatistics();
                                          },
                                        ),
                                      )
                                    : const SizedBox(),
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
                              title: "History",
                            ),
                            SizedBox(height: history.isNotEmpty ? 10 : 5),
                            history.isNotEmpty
                                ? Wrap(
                                    runSpacing: 10,
                                    children: history.reversed.map(
                                      (entry) {
                                        final date = DateTime.parse(
                                          entry[0][0].toString(),
                                        );
                                        final hijriDate =
                                            jHijriFromIso8601Style(entry[0][1]);

                                        final starting =
                                            (entry[1] as List<String>)[0]
                                                .split("-");
                                        final ending =
                                            (entry[1] as List<String>)[1]
                                                .split("-");

                                        return StackedCard(
                                          header:
                                              "${DateFormat.MMMMd().format(date)} / ${hijriDate.hijriMonth()} ${hijriDate.day}",
                                          title:
                                              "${surahs[int.parse(starting[0]) - 1]["name"].toString()} ${starting[1]} - ${surahs[int.parse(ending[0]) - 1]["name"].toString()} ${ending[1]}",
                                          fullWidth: true,
                                          onLongPress: () {
                                            deletingHistoryEntry =
                                                history.indexOf(entry);
                                            confirmEntryDelete();
                                          },
                                        );
                                      },
                                    ).toList(),
                                  )
                                : const Text("Log some reading first!"),
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
