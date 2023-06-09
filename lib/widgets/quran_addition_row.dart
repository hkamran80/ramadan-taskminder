import 'package:flutter/material.dart';
import 'package:ramadan_taskminder/quran.dart';
import 'package:ramadan_taskminder/theme.dart';
import 'package:ramadan_taskminder/widgets/stacked_card.dart';

class QuranAdditionRow extends StatefulWidget {
  const QuranAdditionRow({
    Key? key,
    required this.surahIndex,
    required this.ayah,
    required this.setSurah,
    required this.setAyah,
  }) : super(key: key);

  final int surahIndex;
  final int ayah;
  final Function setSurah;
  final Function setAyah;

  @override
  State<QuranAdditionRow> createState() => _QuranAdditionRowState();
}

class _QuranAdditionRowState extends State<QuranAdditionRow> {
  final surahNames = surahs.map((surah) => surah["name"].toString()).toList();
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ayahsCount = int.tryParse(widget.surahIndex != -1
        ? surahs[widget.surahIndex]["ayahs"].toString()
        : "0");

    controller.addListener(
      () {
        String value = controller.text.trim();
        int? ayah = int.tryParse(value.replaceAll(RegExp(r"[^0-9]"), ""));
        if (ayah != null && ayah > 0 && ayah <= ayahsCount!) {
          widget.setAyah(ayah);
        }
      },
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: surahNames.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text((index + 1).toString()),
                      ],
                    ),
                    title: Text(surahNames[index]),
                    minLeadingWidth: 0,
                    selected:
                        widget.surahIndex != -1 && widget.surahIndex == index,
                    selectedColor: Colors.green,
                    onTap: () {
                      widget.setSurah(index);
                      Navigator.pop(context);
                    },
                  );
                },
              );
            },
          ),
          child: StackedCard(
            header: "Surah",
            title: widget.surahIndex == -1
                ? "Not Set"
                : surahs[widget.surahIndex]["name"].toString(),
          ),
        ),
        InkWell(
          onTap: widget.surahIndex == -1 && ayahsCount == 0
              ? null
              : () => showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Padding(
                        padding: EdgeInsets.fromLTRB(
                          20,
                          20,
                          20,
                          MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Enter the ayah (1-$ayahsCount)",
                              textAlign: TextAlign.left,
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              onEditingComplete: () => Navigator.pop(context),
                              controller: controller,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "Ayah",
                                focusColor: getPrimaryColor(context),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            )
                          ],
                        ),
                      );
                    },
                  ),
          child: StackedCard(
            header: "Ayah",
            title: widget.ayah == 0 ? "Not Set" : widget.ayah.toString(),
          ),
        ),
      ],
    );
  }
}
