import 'package:easy_localization/easy_localization.dart';
import 'package:evently/screens/intro_screen/intro_screen.dart';
import 'package:evently/screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('ar', 'EG')],
      path: 'assets/translations',
      fallbackLocale: Locale('en', 'US'),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: IntroScreen.routeName,
      routes: {
        IntroScreen.routeName : (c) => IntroScreen(),
        LoginScreen.routeName : (c) => LoginScreen(),
      },
    );
  }
}

