import 'package:flutter/material.dart';

const primaryLightColor = Color(0xFFA9C5B8);
const primaryDarkColor = Color(0xFF4B5A53);

const backgroundColor = Color(0xFFF5F4ED);

const buttonTextLightColor = Color(0xFF383838);
const buttonTextDarkColor = Color.fromARGB(255, 206, 206, 206);

const activeTabLightColor = Color(0xFF000000);
const inactiveTabLightColor = Color.fromRGBO(0, 0, 0, .25);

const activeTabDarkColor = Color(0xFFFFFFFF);
const inactiveTabDarkColor = Color.fromRGBO(255, 255, 255, .45);

const destructiveActionColor = Color(0xFFEF4444);

bool isDark(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark;

Color getPrimaryColor(BuildContext context) =>
    isDark(context) ? primaryDarkColor : primaryLightColor;

Color getBackgroundColor(BuildContext context) =>
    isDark(context) ? Colors.black : backgroundColor;

Color getButtonTextColor(BuildContext context) =>
    isDark(context) ? buttonTextDarkColor : buttonTextLightColor;

Color getActiveTabColor(BuildContext context) =>
    isDark(context) ? activeTabDarkColor : activeTabLightColor;

Color getInactiveTabColor(BuildContext context) =>
    isDark(context) ? inactiveTabDarkColor : inactiveTabLightColor;
