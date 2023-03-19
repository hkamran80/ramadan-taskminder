import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ramadan_taskminder/constants.dart';
import 'package:ramadan_taskminder/screens/home.dart';
import 'package:ramadan_taskminder/screens/quran.dart';
import 'package:ramadan_taskminder/screens/tasks.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox("tasks_${DateTime.now().toIso8601String().split("T")[0]}");
  await Hive.openBox("quran");
  runApp(const RamadanTaskminder());
}

final _router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/tasks',
      builder: (context, state) => const TasksScreen(),
    ),
    GoRoute(
      path: '/quran',
      builder: (context, state) => const QuranScreen(),
    ),
  ],
);

class RamadanTaskminder extends StatelessWidget {
  const RamadanTaskminder({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: appName,
      theme: ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backgroundColor,
        useMaterial3: true,
        textTheme: GoogleFonts.mPlus1pTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
