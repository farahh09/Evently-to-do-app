import 'package:evently/screens/intro_screen/intro_screen.dart';
import 'package:evently/screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: IntroScreen.routeName,
      routes: {
        IntroScreen.routeName : (c) => IntroScreen(),
        LoginScreen.routeName : (c) => LoginScreen(),
      },
    );
  }
}

