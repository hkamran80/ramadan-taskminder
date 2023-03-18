import 'package:flutter/material.dart';
import 'package:ramadan_taskminder/constants.dart';

class StackedCard extends StatelessWidget {
  const StackedCard({
    Key? key,
    required this.header,
    required this.title,
  }) : super(key: key);

  final String header;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: primaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 12, 75, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              header,
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
