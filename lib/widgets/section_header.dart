import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ramadan_taskminder/theme.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    Key? key,
    required this.title,
    this.subtitle,
    this.buttonText,
    this.onClick,
  }) : super(key: key);

  final String title;
  final String? subtitle;
  final String? buttonText;
  final GestureTapCallback? onClick;

  @override
  Widget build(BuildContext context) {
    final titleWidget = Text(
      title,
      style: GoogleFonts.numans(
        fontSize: 24,
      ),
    );

    final mainHeader = subtitle != null
        ? Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleWidget,
              Text(
                subtitle!,
                style: const TextStyle(
                  letterSpacing: 0,
                ),
              )
            ],
          )
        : null;

    final headerWidget =
        (subtitle != null ? mainHeader : titleWidget) as Widget;

    if (buttonText != null && onClick != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          headerWidget,
          TextButton(
            onPressed: onClick!,
            child: Text(
              buttonText!.toUpperCase(),
              style: TextStyle(
                color: getButtonTextColor(context),
              ),
            ),
          )
        ],
      );
    } else {
      return headerWidget;
    }
  }
}
