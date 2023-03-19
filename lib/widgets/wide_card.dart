import 'package:flutter/material.dart';
import 'package:ramadan_taskminder/constants.dart';

class WideCard extends StatelessWidget {
  const WideCard({
    Key? key,
    required this.content,
    this.textAlign = TextAlign.left,
    this.onTap,
  }) : super(key: key);

  final String content;
  final TextAlign? textAlign;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 40;
    final widgetContent = Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 17,
        vertical: 15,
      ),
      child: Text(
        content,
        textAlign: textAlign,
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap:  onTap!,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: primaryColor,
          ),
          child: SizedBox(
            width: width,
            child: widgetContent,
          ),
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: primaryColor,
        ),
        width: width,
        child: widgetContent,
      );
    }
  }
}
