import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampark/Config/PagePath.dart';
import 'package:sampark/Config/Themes.dart';
import 'package:sampark/Pages/SplacePage/SplacePage.dart';
import 'package:sampark/Pages/Welcome/WelcomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Sampark',
      theme: lightTheme,
      getPages: pagePath,
      darkTheme: darkTheme,
      themeMode: ThemeMode.dark,
      home: WelcomePage(),
    );
  }
}
