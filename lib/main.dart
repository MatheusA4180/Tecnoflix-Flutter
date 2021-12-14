import 'package:flutter/material.dart';
import 'package:tecnoflix/features/intro/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color.fromARGB(255, 255, 22, 22),
          selectionColor: Color.fromARGB(255, 255, 22, 22),
          selectionHandleColor: Color.fromARGB(255, 255, 22, 22),
        ),
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
