import 'package:flutter/material.dart';
import 'package:ramadan_taskminder/constants.dart';

class StackedCard extends StatelessWidget {
  const StackedCard({
    Key? key,
    required this.header,
    required this.title,
    this.fullWidth,
  }) : super(key: key);

  final String header;
  final String title;
  final bool? fullWidth;

  @override
  Widget build(BuildContext context) {
    final width = (MediaQuery.of(context).size.width - 50);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: primaryColor,
      ),
      width: fullWidth != null && fullWidth! ? width + 10 : width / 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              header.toUpperCase(),
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
