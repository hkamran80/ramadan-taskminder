import 'package:flutter/material.dart';
import 'package:ramadan_taskminder/constants.dart';

class Statistic extends StatelessWidget {
  const Statistic({
    Key? key,
    required this.statistic,
  }) : super(key: key);

  final String statistic;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: primaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 7, 15, 7),
        child: Text(
          statistic,
        ),
      ),
    );
  }
}
