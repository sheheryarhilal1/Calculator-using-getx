import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'view/calculator_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system, // follow system theme
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: CalculatorView(),
    );
  }
}
