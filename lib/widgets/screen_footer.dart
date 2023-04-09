import 'package:flutter/material.dart';

class ScreenFooter extends StatelessWidget {
  const ScreenFooter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.11,
    );
  }
}
