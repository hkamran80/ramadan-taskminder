import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ramadan_taskminder/constants.dart';
import 'package:ramadan_taskminder/extensions/string.dart';
import 'package:ramadan_taskminder/extensions/text_field.dart';
import 'package:ramadan_taskminder/quran.dart';
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

  @override
  Widget build(BuildContext context) {
    final ayahsCount = surahs[widget.surahIndex]["ayahs"].toString();

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
                    title: Text(surahNames[index]),
                    selected:
                        widget.surahIndex != 0 && widget.surahIndex == index,
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
            title: widget.surahIndex == 0
                ? "Not Set"
                : surahs[widget.surahIndex]["name"].toString(),
          ),
        ),
        InkWell(
          onTap: widget.surahIndex == 0
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
                              onChanged: (value) => widget.setAyah(
                                int.parse(value),
                              ),
                              onEditingComplete: () {
                                Navigator.pop(context);
                              },
                              controller: TextEditingController(),
                              keyboardType: TextInputType.number,
                              autofocus: true,
                              decoration: InputDecoration(
                                labelText: "Ayah",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              inputFormatters: [
                                NumericsOnly(),
                                FilteringTextInputFormatter.allow(
                                  RegExp("[0-9]"),
                                ),
                                NumericalRangeFormatter(
                                  min: 1,
                                  max: double.parse(ayahsCount),
                                ),
                              ],
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
