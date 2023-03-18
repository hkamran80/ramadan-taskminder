import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:ramadan_taskminder/constants.dart';
import 'package:ramadan_taskminder/widgets/tab_bar_item.dart';

class PageFooter extends StatelessWidget {
  const PageFooter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentLocation = GoRouter.of(context).location;
    final tabBar = [
      ["/", LucideIcons.home],
      ["/tasks", LucideIcons.clipboardList],
      ["/quran", LucideIcons.bookOpen],
      ["/prayers", LucideIcons.construction],
      ["/settings", LucideIcons.cog],
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: tabBar
            .map(
              (List item) => TabBarItem(
                location: item[0],
                icon: item[1],
                active: currentLocation == item[0],
              ),
            )
            .toList(),
      ),
    );
  }
}
