import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ramadan_taskminder/theme.dart';
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
      ["/prayers", LucideIcons.alignVerticalJustifyEnd],
      ["/settings", LucideIcons.cog],
    ];

    return Center(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            color: isDark(context)
                ? const Color.fromRGBO(0, 0, 0, 0.5)
                : const Color.fromRGBO(255, 255, 255, 0.5),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(35, 5, 35, 25),
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
            ),
          ),
        ),
      ),
    );
  }
}
