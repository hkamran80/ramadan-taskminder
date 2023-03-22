import 'package:flutter/material.dart';

const primaryLightColor = Color(0xFFA9C5B8);
const primaryDarkColor = Color(0xFF4B5A53);

const backgroundColor = Color(0xFFF5F4ED);

const buttonTextLightColor = Color(0xFF383838);
const buttonTextDarkColor = Color.fromARGB(255, 206, 206, 206);

const activeTabLightColor = Color(0xFF000000);
const inactiveTabLightColor = Color.fromRGBO(0, 0, 0, .25);

const activeTabDarkColor = Color(0xFFFFFFFF);
const inactiveTabDarkColor = Color.fromRGBO(255, 255, 255, .25);

Color getPrimaryColor(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark
        ? primaryDarkColor
        : primaryLightColor;

Color getBackgroundColor(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark
        ? Colors.black
        : backgroundColor;

Color getButtonTextColor(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark
        ? buttonTextDarkColor
        : buttonTextLightColor;

Color getActiveTabColor(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark
        ? activeTabDarkColor
        : activeTabLightColor;

Color getInactiveTabColor(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark
        ? inactiveTabDarkColor
        : inactiveTabLightColor;