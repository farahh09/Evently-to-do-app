import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/app_theme_data.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/screens/intro_screen/intro_screen.dart';
import 'package:evently/screens/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('ar', 'EG')],
      path: 'assets/translations',
      fallbackLocale: Locale('en', 'US'),
      child: ChangeNotifierProvider(
          create: (BuildContext context) => ThemeProvider(),
          child: MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

      theme: AppThemeData.lightTheme,
      darkTheme: AppThemeData.darkTheme,
      themeMode: provider.themeMode,

      initialRoute: IntroScreen.routeName,
      routes: {
        IntroScreen.routeName : (c) => IntroScreen(),
        LoginScreen.routeName : (c) => LoginScreen(),
      },
    );
  }
}

