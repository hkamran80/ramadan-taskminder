import 'package:jhijri/jHijri.dart';

JHijri jHijriFromIso8601Style(String iso8601) {
  final components = iso8601.split("-");
  if (components.length != 3) {
    print("Invalid ISO-8601 style string — \"$iso8601\"");
    throw Error();
  }

  final numericalComponents = components.map((e) => int.parse(e));

  return JHijri(
    fYear: numericalComponents.elementAt(0),
    fMonth: numericalComponents.elementAt(1),
    fDay: numericalComponents.elementAt(2),
  );
}
