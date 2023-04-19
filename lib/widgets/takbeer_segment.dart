import 'package:flutter/material.dart';

class TakbeerSegment extends StatelessWidget {
  const TakbeerSegment({
    Key? key,
    required this.arabic,
    required this.transliteration,
    required this.translation,
  }) : super(key: key);

  final String arabic;
  final String transliteration;
  final String translation;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 2 - 10,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(transliteration),
              Text(translation),
            ],
          ),
        ),
        Expanded(
          child: Text(
            arabic,
            style: const TextStyle(fontSize: 28),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
