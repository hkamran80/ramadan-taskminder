import 'package:hijri/hijri_calendar.dart';
import 'package:jhijri/jHijri.dart';

extension Date on DateTime {
  String getYMD() => toIso8601String().split("T")[0];
}

extension Hijri on HijriCalendar {
  String toIso8601Style() => "$hYear-$hMonth-$hDay";
}

extension JHijriDateTime on JHijri {
  String hijriMonth() {
    switch (month) {
      case 1:
        return "Muharram";
      case 2:
        return "Safar";
      case 3:
        return "Rabi' Al-Awwal";
      case 4:
        return "Rabi' Al-Thani";
      case 5:
        return "Jumada Al-Awwal";
      case 6:
        return "Jumada Al-Thani";
      case 7:
        return "Rajab";
      case 8:
        return "Sha'aban";
      case 9:
        return "Ramadan";
      case 10:
        return "Shawwal";
      case 11:
        return "Dhu Al-Qi'dah";
      case 12:
        return "Dhu Al-Hijjah";
      default:
        return "";
    }
  }
}
