import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/app_theme_data.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/screens/auth/forget_password_screen.dart';
import 'package:evently/screens/auth/signup_screen.dart';
import 'package:evently/screens/auth/login_screen.dart';
import 'package:evently/screens/home/home_screen.dart';
import 'package:evently/screens/onboarding/intro_screen.dart';
import 'package:evently/screens/onboarding/setup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/cache_helper.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('ar', 'EG')],
      path: 'assets/translations',
      fallbackLocale: Locale('en', 'US'),
      child: ChangeNotifierProvider(
        create: (BuildContext context) => ThemeProvider(),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

      theme: AppThemeData.lightTheme,
      darkTheme: AppThemeData.darkTheme,
      themeMode: provider.themeMode,

      initialRoute: CacheHelper.getBool('introduction') == true
          ? LoginScreen.routeName
          : SetupScreen.routeName,
      //initialRoute: SetupScreen.routeName,
      routes: {
        SetupScreen.routeName: (c) => SetupScreen(),
        IntroScreen.routeName: (c) => IntroScreen(),
        LoginScreen.routeName: (c) => LoginScreen(),
        SignupScreen.routeName: (c) => SignupScreen(),
        ForgetPasswordScreen.routeName: (c) => ForgetPasswordScreen(),
        HomeScreen.routeName: (c) => HomeScreen(),
      },
    );
  }
}
