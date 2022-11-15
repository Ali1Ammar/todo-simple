import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/src/screen/home_screen.dart';

import '../main.dart';

class MyMaterialApp extends StatefulWidget {
  const MyMaterialApp({super.key});

  @override
  State<MyMaterialApp> createState() => MyMaterialAppState();
}

class MyMaterialAppState extends State<MyMaterialApp> {
  var light = ThemeMode.light;
  Color color = Colors.orange;

  @override
  initState() {
    loadTheme();
    super.initState();
  }

  loadTheme() {
    final savedTheme = prefs.getInt("theme") ?? 0;
    setState(() {
      light = ThemeMode.values[savedTheme];
    });
  }

  changeTheme() async {
    setState(() {
      if (light == ThemeMode.light) {
        light = ThemeMode.dark;
      } else {
        light = ThemeMode.light;
      }
    });
    await prefs.setInt('theme', light.index);
  }

  changeColor(Color color) {
    setState(() {
      this.color = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: light,
      locale: Locale("en"),
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.rtl, child: child!);
      },
      theme: ThemeData(
        useMaterial3: true,
        checkboxTheme:
            CheckboxThemeData(fillColor: MaterialStateProperty.all(color)),
        colorScheme: ColorScheme.fromSeed(
            seedColor: color,
            brightness: Brightness.light,
            primary: color,
            onPrimary: Colors.white,
            secondary: Color(0xffB01E68),
            onSecondary: Colors.white,
            error: Colors.red,
            onError: Colors.black,
            background: Color.fromARGB(255, 243, 236, 233),
            surface: color,
            onSurface: Colors.white,
            onBackground: Colors.black),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        checkboxTheme:
            CheckboxThemeData(fillColor: MaterialStateProperty.all(color)),
        colorScheme: ColorScheme.fromSeed(
            seedColor: color,
            brightness: Brightness.dark,
            primary: color,
            onPrimary: Colors.white,
            secondary: Color(0xffB01E68),
            onSecondary: Colors.white,
            error: Colors.red,
            onError: Colors.black,
            background: Color.fromARGB(255, 243, 236, 233),
            surface: color,
            onSurface: Colors.white,
            onBackground: Colors.black),
      ),
      home: HomeScreen(),
    );
  }
}
