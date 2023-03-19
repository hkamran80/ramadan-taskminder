import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({
    Key? key,
    required this.header,
    required this.title,
    this.rightAlign,
    this.hintText,
  }) : super(key: key);

  final String header;
  final String title;
  final Widget? rightAlign;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    final mainWidget = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              header,
              style: GoogleFonts.numans(),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
          ],
        ),
        if (rightAlign != null) rightAlign as Widget,
      ],
    );

    if (hintText != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          mainWidget,
          Text(hintText!),
        ],
      );
    } else {
      return mainWidget;
    }
  }
}
