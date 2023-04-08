import 'package:flutter/material.dart';
import 'package:ramadan_taskminder/theme.dart';

class WideCard extends StatelessWidget {
  const WideCard({
    Key? key,
    required this.content,
    this.textAlign = TextAlign.left,
    this.trailing,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  final String content;
  final TextAlign? textAlign;
  final Widget? trailing;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 40;
    final textWidget = Text(
      content,
      textAlign: textAlign,
    );
    final widgetContent = Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 17,
        vertical: 15,
      ),
      child: trailing == null
          ? textWidget
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textWidget,
                trailing!,
              ],
            ),
    );

    if (onTap != null || onLongPress != null) {
      return InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: getPrimaryColor(context),
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
          color: getPrimaryColor(context),
        ),
        width: width,
        child: widgetContent,
      );
    }
  }
}
