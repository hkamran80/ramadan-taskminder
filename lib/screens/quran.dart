import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:ramadan_taskminder/constants.dart';
import 'package:ramadan_taskminder/quran.dart';
import 'package:ramadan_taskminder/widgets/page_footer.dart';
import 'package:ramadan_taskminder/widgets/page_header.dart';
import 'package:ramadan_taskminder/widgets/quran_addition_row.dart';
import 'package:ramadan_taskminder/widgets/section_header.dart';
import 'package:ramadan_taskminder/widgets/stacked_card.dart';
import 'package:ramadan_taskminder/widgets/wide_card.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  final history = [
    [
      "2023-3-23",
      ["1-1", "2-166"]
    ],
  ];

  int startingSurah = 0;
  int startingAyah = 0;

  int endingSurah = 0;
  int endingAyah = 0;

  @override
  void initState() {
    super.initState();

    if (history.isNotEmpty) {
      final lastEntry = (history.last[1] as List<String>)[1]
          .split("-")
          .map(int.parse)
          .toList();

      startingSurah = surahs.length == lastEntry[0] ? 1 : lastEntry[0];
      startingAyah = int.parse(surahs[lastEntry[0] - 1]["ayahs"].toString()) >=
              lastEntry[1]
          ? 1
          : lastEntry[1] + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    const PageHeader(
                      header: "Qur'an",
                      title: "Nothing read today",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionHeader(
                          title: "Overview",
                        ),
                        const SizedBox(height: 5),
                        Wrap(
                          runSpacing: 10,
                          children: const [
                            WideCard(content: "2% read of Qur'an"),
                            WideCard(content: "166 ayahs read"),
                            WideCard(content: "85% of Juz 1 complete"),
                            WideCard(content: "29 juz left")
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
                          title: "Log Reading",
                          buttonText: "Help",
                          onClick: () {},
                        ),
                        // TODO: Add toggle
                        const Text(
                          "Enter the starting surah/ayah, then the ending surah/ayah. The ending input will be visible after the starting input is set, and the log button will be visible after the ending input is set.",
                          style: TextStyle(fontSize: 12),
                        ),
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
                            startingSurah != 0 && startingAyah != 0
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
                            startingSurah != 0 &&
                                    startingAyah != 0 &&
                                    endingSurah != 0 &&
                                    endingAyah != 0
                                ? WideCard(
                                    content: "Log",
                                    textAlign: TextAlign.center,
                                    onTap: () => setState(
                                      () {
                                        history.add(
                                          [
                                            DateTime.now()
                                                .toIso8601String()
                                                .split("T")[0],
                                            [
                                              "${startingSurah + 1}-$startingAyah",
                                              "${endingSurah + 1}-$endingAyah"
                                            ]
                                          ],
                                        );
                                        
                                        endingSurah = 0;
                                        endingAyah = 0;

                                        final lastEntry =
                                            (history.last[1] as List<String>)[1]
                                                .split("-")
                                                .map(int.parse)
                                                .toList();

                                        startingSurah =
                                            surahs.length == lastEntry[0]
                                                ? 1
                                                : lastEntry[0];
                                        startingAyah = int.parse(
                                                    surahs[lastEntry[0] - 1]
                                                            ["ayahs"]
                                                        .toString()) >=
                                                lastEntry[1]
                                            ? 1
                                            : lastEntry[1] + 1;
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
                        const SizedBox(height: 10),
                        Wrap(
                          runSpacing: 10,
                          children: history.reversed.map(
                            (entry) {
                              final date = DateTime.parse(entry[0].toString());
                              final hijriDate = HijriCalendar.fromDate(date);

                              final starting =
                                  (entry[1] as List<String>)[0].split("-");
                              final ending =
                                  (entry[1] as List<String>)[1].split("-");

                              return StackedCard(
                                header:
                                    "${DateFormat.MMMMd().format(date)} / ${hijriDate.longMonthName} ${hijriDate.hDay}",
                                title:
                                    "${surahs[int.parse(starting[0]) - 1]["name"].toString()} ${starting[1]} - ${surahs[int.parse(ending[0]) - 1]["name"].toString()} ${ending[1]}",
                                fullWidth: true,
                              );
                            },
                          ).toList(),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const PageFooter()
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
