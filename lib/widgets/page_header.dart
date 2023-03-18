import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({
    Key? key,
    required this.header,
    required this.title,
    this.rightAlign,
  }) : super(key: key);

  final String header;
  final String title;
  final Widget? rightAlign;

  @override
  Widget build(BuildContext context) {
    return Row(
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
  }
}
