import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/cache_helper.dart';
import '../../providers/theme_provider.dart';
import 'intro_screen.dart';

class SetupScreen extends StatelessWidget {
  static const String routeName = 'SetupScreen';
  const SetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: context.surface(),
      appBar: AppBar(
        title: Image.asset('assets/images/evently_logo.png', width: 142, height: 27, color: context.primary(),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24,),
            Image.asset('assets/images/creative.png', color: provider.themeMode == ThemeMode.light? context.primary() : context.secondary(),),

            SizedBox(height: 24,),
            Text("onboardingTitle".tr(), style: context.titleLarge()),

            SizedBox(height: 8,),
            Text("onboardingSubTitle".tr(), style: context.bodyMedium()),

            SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("language".tr(), style: context.bodyMedium()),
                Row(
                  spacing: 20,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        context.setLocale(Locale("en", "US"));                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: context.locale == Locale("en", "US") ? context.primary() : null,
                          padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 4),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            side: provider.themeMode == ThemeMode.light? BorderSide.none : BorderSide(
                              color: context.outline(),
                              width: 0.5,
                            ),
                          )
                      ),
                      child: Text("English", style: context.displaySmall().copyWith(color: provider.themeMode == ThemeMode.dark? context.onSurface() : context.locale == Locale("en", "US") ? context.onSecondary() : context.primary())),
                    ),
                    ElevatedButton(
                      onPressed: (){
                        context.setLocale(Locale("ar", "EG"));                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: context.locale == Locale("en", "US") ? context.onPrimary() : context.primary(),
                          padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: provider.themeMode == ThemeMode.dark? BorderSide(
                              color: context.outline(),
                              width: 0.5,
                            ) : BorderSide.none,
                          ),
                      ),
                      child:  Text("Arabic", style: context.displaySmall().copyWith(color: provider.themeMode == ThemeMode.dark? context.onSurface() : context.locale == Locale("en", "US") ? context.primary() : context.onSecondary())),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("theme".tr(), style: context.bodyMedium()),
                Row(
                  spacing: 20,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                        provider.changeTheme(ThemeMode.light);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: provider.themeMode == ThemeMode.light? context.primary() : context.onPrimary(),
                          padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 4),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            side: provider.themeMode == ThemeMode.dark? BorderSide(
                              color: context.outline(),
                              width: 0.5,
                            ) : BorderSide.none,
                          )
                      ),
                      child: Image.asset('assets/images/sun.png', width: 24, height: 24, color: context.onSecondary())),
                    ElevatedButton(
                        onPressed: (){
                          provider.changeTheme(ThemeMode.dark);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: provider.themeMode == ThemeMode.light? context.onSecondary() : context.primary(),
                            padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 4),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              side: provider.themeMode == ThemeMode.dark ? BorderSide(
                                color: context.outline(),
                                width: 0.5,
                              ) : BorderSide.none,
                            )
                        ),
                        child: Image.asset('assets/images/moon.png', width: 24, height: 24, color: provider.themeMode == ThemeMode.light? context.primary() : context.onSurface(),)),
                  ],
                )
              ],
            ),

            SizedBox(height: 24,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () async{
                    await CacheHelper.saveBool(true);
                    Navigator.pushReplacementNamed(context, IntroScreen.routeName);
                  },
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.primary(),
                  padding: EdgeInsetsGeometry.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),

                  )
                ),
                child:  Text("Let’s Start", style: context.displayLarge()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
