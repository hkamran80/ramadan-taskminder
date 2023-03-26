import 'package:flutter/material.dart';
import 'package:ramadan_taskminder/theme.dart';

class StackedCard extends StatelessWidget {
  const StackedCard({
    Key? key,
    required this.header,
    required this.title,
    this.fullWidth,
    this.onLongPress,
  }) : super(key: key);

  final String header;
  final String title;
  final bool? fullWidth;
  final GestureTapCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final baseWidth = (MediaQuery.of(context).size.width - 50);
    final width =
        fullWidth != null && fullWidth! ? baseWidth + 10 : baseWidth / 2;

    final widgetContent = Padding(
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
    );

    if (onLongPress != null) {
      return InkWell(
        onLongPress: onLongPress!,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
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
          borderRadius: BorderRadius.circular(15),
          color: getPrimaryColor(context),
        ),
        width: width,
        child: widgetContent,
      );
    }
  }
}
