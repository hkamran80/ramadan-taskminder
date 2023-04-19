import 'package:flutter/material.dart';
import 'package:ramadan_taskminder/constants.dart';
import 'package:ramadan_taskminder/theme.dart';
import 'package:ramadan_taskminder/widgets/page_footer.dart';
import 'package:ramadan_taskminder/widgets/page_header.dart';
import 'package:ramadan_taskminder/widgets/screen_footer.dart';
import 'package:ramadan_taskminder/widgets/stacked_card.dart';
import 'package:ramadan_taskminder/widgets/takbeer_segment.dart';
import 'package:ramadan_taskminder/widgets/wide_card.dart';
import 'package:url_launcher/url_launcher.dart';

class EidTakbeerScreen extends StatefulWidget {
  const EidTakbeerScreen({super.key});

  @override
  State<EidTakbeerScreen> createState() => _EidTakbeerScreenState();
}

class _EidTakbeerScreenState extends State<EidTakbeerScreen> {
  void _launchUrl(Uri uri) async {
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $uri';
    }
  }

  ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose(); // dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: getBackgroundColor(context),
      child: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
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
                          title: "Eid Takbeer",
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            WideCard(
                              content: "Listen on YouTube",
                              halfWidth: true,
                              onTap: () => _launchUrl(eidTakbeerVideo),
                            ),
                            WideCard(
                              content: "Read the PDF",
                              halfWidth: true,
                              onTap: () => _launchUrl(eidTakbeerPdf),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Wrap(
                          runSpacing: 15,
                          children: const [
                            TakbeerSegment(
                              arabic: "اللّهُ أكبر اللّهُ أكبر",
                              transliteration: "Allahu Akbar, Allahu Akbar",
                              translation: "Allah is Great, Allah is Great",
                            ),
                            TakbeerSegment(
                              arabic: "اللّهُ أكبر",
                              transliteration: "Allahu Akbar",
                              translation: "Allah is Great",
                            ),
                            TakbeerSegment(
                              arabic: "لا إلَهَ الا اللّه",
                              transliteration: "La illaha il Allah",
                              translation: "There is no God, but Allah",
                            ),
                            TakbeerSegment(
                              arabic: "اللّهُ أكبر اللّهُ أكبر",
                              transliteration: "Allahu Akbar, Allahu Akbar",
                              translation: "Allah is Great, Allah is Great",
                            ),
                            TakbeerSegment(
                              arabic: "و لِلّه الحمدَ",
                              transliteration: "Walilahil Hamd",
                              translation: "to Him belongs all Praise",
                            ),
                            TakbeerSegment(
                              arabic: "اللّهُ أكبرُ كَبيِرَا",
                              transliteration: "Allahu Akbaru Kabeera",
                              translation: "Allah is the Greatest",
                            ),
                            TakbeerSegment(
                              arabic: "وَالحَمدُ لِلّهِ كَثِيرا ",
                              transliteration: "Wal-Hamdulilahi katheera",
                              translation:
                                  "And praise be to Allah in abundance",
                            ),
                            TakbeerSegment(
                              arabic: "وَ سُبحَان اللّهِ",
                              transliteration: "Wa Subhan allahi",
                              translation: "And Glory to Allah",
                            ),
                            TakbeerSegment(
                              arabic: "بُكرَةً وَأصْيِلا ",
                              transliteration: "Bukratan wa aseila",
                              translation:
                                  "In the early morning and the late afternoon",
                            ),
                            TakbeerSegment(
                              arabic: "لا إلَهَ الا اللّه وحده",
                              transliteration: "La ilaha illallah Wahdah",
                              translation:
                                  "There is no God, but Allah the Unique",
                            ),
                            TakbeerSegment(
                              arabic: "صَدَقَ وَعدَه ",
                              transliteration: "Sadaqa wa'dah",
                              translation: "He has fufilled His Promise",
                            ),
                            TakbeerSegment(
                              arabic: "وَنَصَرَ عبده",
                              transliteration: "Wa nasara abda",
                              translation: "And made Victorious His Servant",
                            ),
                            TakbeerSegment(
                              arabic: "وأعزَ جُنَده ",
                              transliteration: "Wa a'azza jundahu",
                              translation: "And made Mighty His soldiers",
                            ),
                            TakbeerSegment(
                              arabic: "وَهزم الأحْزَابَ وحْدَه ",
                              transliteration: "Wa hazamal-ahzaaba wahdah",
                              translation:
                                  "And by Himself defeated the enemy parties",
                            ),
                            TakbeerSegment(
                              arabic: "لا إلَهَ الا اللّه",
                              transliteration: "La illaha il Allah",
                              translation: "There is no God, but Allah",
                            ),
                            TakbeerSegment(
                              arabic: "وَلا نَعبُد الا أياه",
                              transliteration: "Wa laa na'budu illa iyyah",
                              translation: "He alone we worship",
                            ),
                            TakbeerSegment(
                              arabic: "مُخلِصِّينَ لَهُ الدّيِنَ ",
                              transliteration: "Mukhlessena lahud-deena",
                              translation:
                                  "With sincere and exclusive devotion",
                            ),
                            TakbeerSegment(
                              arabic: "وَلوْ كَرِهَ الكَافِروُن",
                              transliteration: "Walaw karehal-Kafeeroon",
                              translation: "Even though the idolaters hate it",
                            ),
                            TakbeerSegment(
                              arabic: "اللّهمَ صَلِّ على سيْدنَا مُحَمد",
                              transliteration:
                                  "Allahumma salli ala sayyedna Muhammad",
                              translation:
                                  "O Allah, have Mercy on our Prophet Muhammad",
                            ),
                            TakbeerSegment(
                              arabic: "وَعَلى آلِ سيْدنَا مُحَمد",
                              transliteration: "Wa ala aalie sayyedna Muhammad",
                              translation:
                                  "And on the family of our Prophet Muhammad",
                            ),
                            TakbeerSegment(
                              arabic: "وَعَلى اصْحَابِ سيْدنَا مُحَمد ",
                              transliteration:
                                  "Wa ala as-haabie sayyedna Muhammad",
                              translation:
                                  "And on the companions of our Prophet Muhammad",
                            ),
                            TakbeerSegment(
                              arabic: "وَعَلى أنصَارِ سيْدنَا مُحَمد ",
                              transliteration:
                                  "Wa ala ansari sayyedna Muhammad",
                              translation:
                                  "And on the helpers of our Prophet Muhammad",
                            ),
                            TakbeerSegment(
                              arabic: "وَعَلى أزوَاجِ سيْدنَا مُحَمد",
                              transliteration:
                                  "Wa ala azwajie sayyedna Muhammad",
                              translation:
                                  "And on the wives of our Prophet Muhammad",
                            ),
                            TakbeerSegment(
                              arabic: "وَعَلى ذُرِّيَةِ سيْدنَا مُحَمد ",
                              transliteration:
                                  "Wa ala dhurreyatie sayyedna Muhammad",
                              translation:
                                  "And on the progeny of our Prophet Muhammad",
                            ),
                            TakbeerSegment(
                              arabic: "وَ سَلّم تَسْلِيماَ كَثّيرا ",
                              transliteration: "Wa sallim tasleeman katheera",
                              translation: "And Bestow upon them much peace",
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        WideCard(
                          content: "Back to top",
                          onTap: () => _scrollController.animateTo(
                            0,
                            duration: const Duration(milliseconds: 125),
                            curve: Curves.linear,
                          ),
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
