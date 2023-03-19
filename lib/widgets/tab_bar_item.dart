import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ramadan_taskminder/theme.dart';

class TabBarItem extends StatelessWidget {
  const TabBarItem({
    Key? key,
    required this.location,
    required this.icon,
    required this.active,
  }) : super(key: key);

  final String location;
  final IconData icon;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => GoRouter.of(context).go(location),
      icon: Icon(icon),
      color: active ? getActiveTabColor(context) : getInactiveTabColor(context),
    );
  }
}
