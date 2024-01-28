import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({
    Key? key,
    required this.header,
    required this.title,
    this.priorPathName,
    this.rightAlign,
    this.hintText,
  }) : super(key: key);

  final String header;
  final String title;
  final String? priorPathName;
  final Widget? rightAlign;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    Widget topLevel = priorPathName != null
        ? Transform.translate(
            offset: const Offset(-5, 0),
            child: InkWell(
              onTap: () => GoRouter.of(context).pop(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Icon(LucideIcons.chevronLeft),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(
                    priorPathName!,
                    style: GoogleFonts.numans(),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                ],
              ),
            ),
          )
        : Text(
            header,
            style: GoogleFonts.numans(),
          );

    Widget mainWidget = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            topLevel,
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
