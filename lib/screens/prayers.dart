import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ramadan_taskminder/extensions/date.dart';
import 'package:ramadan_taskminder/prayers.dart';
import 'package:ramadan_taskminder/theme.dart';
import 'package:ramadan_taskminder/tasks.dart';
import 'package:ramadan_taskminder/widgets/page_footer.dart';
import 'package:ramadan_taskminder/widgets/page_header.dart';
import 'package:ramadan_taskminder/widgets/section_header.dart';
import 'package:ramadan_taskminder/widgets/wide_card.dart';

class PrayersScreen extends StatefulWidget {
  const PrayersScreen({super.key});

  @override
  State<PrayersScreen> createState() => _PrayersScreenState();
}

class _PrayersScreenState extends State<PrayersScreen> {
  DateTime current = DateTime.now();
  List<String> complete = [];
  List<String> incomplete = [];

  Box prayersBox = Hive.box("prayers");
  late Map<String, bool> prayers;

  @override
  void initState() {
    super.initState();
    initializePrayers();
  }

  void initializePrayers() {
    prayers = Map.from(
      prayersBox.get(current.getYMD(), defaultValue: {}),
    );

    for (var task in allPrayers) {
      bool taskPresent = prayers.containsKey(task);
      if (!taskPresent) {
        prayers[task] = false;
        incomplete.add(task);
      } else if (prayers[task] == false) {
        incomplete.add(task);
      } else if (prayers[task] == true) {
        complete.add(task);
      }
    }

    prayersBox.put(current.getYMD(), prayers);
  }

  void togglePrayer(String prayer, bool currentState) {
    if (currentState == true) {
      complete.remove(prayer);
      incomplete.add(prayer);
      sortPrayers();
    } else {
      incomplete.remove(prayer);
      complete.add(prayer);
    }

    prayers[prayer] = !currentState;
    prayersBox.put(current.getYMD(), prayers);
  }

  void sortPrayers() {
    incomplete = [...allPrayers];
    for (var prayer in complete) {
      incomplete.remove(prayer);
    }
  }

  @override
  Widget build(BuildContext context) {
    int fardhComplete = complete
        .where(
          (prayer) => !prayer.contains(
            "Sunnah",
          ),
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
                          header: "Prayers",
                          title: complete.isEmpty
                              ? "Nothing prayed today"
                              : "$fardhComplete Fardh, ${complete.length - fardhComplete} Sunnah prayed",
                          hintText:
                              "Tap a prayer to mark it as prayed/not prayed",
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SectionHeader(
                              title: "Not Prayed",
                            ),
                            SizedBox(height: incomplete.isNotEmpty ? 10 : 5),
                            incomplete.isNotEmpty
                                ? Wrap(
                                    runSpacing: 10,
                                    children: incomplete
                                        .map(
                                          (prayer) => WideCard(
                                            content: prayer,
                                            onTap: () => setState(
                                              () => togglePrayer(prayer, false),
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
                              title: "Prayed",
                            ),
                            SizedBox(height: complete.isNotEmpty ? 10 : 5),
                            complete.isNotEmpty
                                ? Wrap(
                                    runSpacing: 10,
                                    children: complete
                                        .map(
                                          (prayer) => WideCard(
                                            content: prayer,
                                            onTap: () => setState(
                                              () => togglePrayer(prayer, true),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  )
                                : const Text(
                                    "No prayers have been completed yet!",
                                  )
                          ],
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
