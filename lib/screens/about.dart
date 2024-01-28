import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:ramadan_taskminder/constants.dart';
import 'package:ramadan_taskminder/theme.dart';
import 'package:ramadan_taskminder/widgets/page_footer.dart';
import 'package:ramadan_taskminder/widgets/page_header.dart';
import 'package:ramadan_taskminder/widgets/screen_footer.dart';
import 'package:ramadan_taskminder/widgets/stacked_card.dart';
import 'package:ramadan_taskminder/widgets/wide_card.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  void _launchUrl(Uri uri) async {
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $uri';
    }
  }

  String version = "";
  String buildNumber = "";

  @override
  void initState() {
    super.initState();
    loadPackageInfo();
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
                          title: "About",
                          priorPathName: "Settings",
                        ),
                        const SizedBox(
                          height: 15,
                        ),
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
                                applicationVersion: "$version ($buildNumber)",
                                applicationLegalese:
                                    "Copyright © 2023 Thirteenth Willow. All rights reserved.",
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        const Text(
                          "$appName sends no information about you or your device to any server.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Copyright © 2023 Thirteenth Willow. All rights reserved.",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
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
