import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ramadan_taskminder/constants.dart';
import 'package:ramadan_taskminder/theme.dart';
import 'package:ramadan_taskminder/screens/home.dart';
import 'package:ramadan_taskminder/screens/quran.dart';
import 'package:ramadan_taskminder/screens/tasks.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox("tasks");
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
        primaryColor: getPrimaryColor(context),
        scaffoldBackgroundColor: backgroundColor,
        useMaterial3: true,
        textTheme: GoogleFonts.mPlus1pTextTheme(),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(
          primary: Colors.black,
          onPrimary: Colors.black,
          secondary: primaryDarkColor,
        ),
        cardTheme: const CardTheme(
          color: Colors.black87,
        ),
        iconTheme: const IconThemeData(
          color: primaryDarkColor,
        ),
        textTheme: GoogleFonts.nunitoSansTextTheme(
          const TextTheme(
            subtitle1: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
            subtitle2: TextStyle(
              color: Colors.white70,
              fontSize: 18.0,
            ),
          ),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: primaryDarkColor,
          selectionColor: primaryDarkColor,
          selectionHandleColor: primaryDarkColor,
        ),
        toggleableActiveColor: primaryDarkColor,
        primaryColor: Colors.white,
      ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
