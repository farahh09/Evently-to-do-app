import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import 'intro_screen.dart';

class SetupScreen extends StatelessWidget {
  static const String routeName = 'SetupScreen';
  const SetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/evently_logo.png'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 28,
          children: [
            provider.themeMode == ThemeMode.light? Image.asset('assets/images/creative.png') : Image.asset('assets/images/intro_dark.png'),
            Text("onboardingTitle".tr(), style: Theme.of(context).textTheme.titleLarge),
            Text("onboardingSubTitle".tr(), style: Theme.of(context).textTheme.bodyMedium),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("language".tr(), style: Theme.of(context).textTheme.bodySmall),
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: BoxBorder.all(
                        color: Color(0xFF5669FF),
                        width: 2
                      )
                    ),
                    child: Row(
                      spacing: 20,
                      children: [
                        InkWell(
                          onTap: (){
                            context.setLocale(Locale("en", "US"));
                          },
                          child: Container(
                              padding: context.locale == Locale("en", "US") ? null : EdgeInsetsGeometry.all(5),
                              decoration: context.locale == Locale("en", "US")? BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  border: BoxBorder.all(
                                      color: Color(0xFF5669FF),
                                      width: 5
                                  )
                              ) : null,
                              child: Image.asset('assets/images/usa.png', width: 30, height: 30,)),
                        ),
                        InkWell(
                          onTap: (){
                              context.setLocale(Locale("ar", "EG"));
                            },
                          child: Container(
                            padding: context.locale == Locale("ar", "EG") ? null : EdgeInsetsGeometry.all(5),
                             decoration: context.locale == Locale("ar", "EG") ? BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: BoxBorder.all(color: Color(0xFF5669FF), width: 5)
                             ) : null,
                            child: Image.asset('assets/images/eg.png', width: 30, height: 30))),
                      ],
                    ),
                  ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("theme".tr(), style: Theme.of(context).textTheme.bodySmall),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: BoxBorder.all(
                          color: Color(0xFF5669FF),
                          width: 2
                      )
                  ),
                  child: Row(
                    spacing: 20,
                    children: [
                      InkWell(
                        onTap: (){
                          provider.changeTheme(ThemeMode.light);
                        },
                        child: Container(
                          padding: provider.themeMode == ThemeMode.light? null : EdgeInsets.only(left: 5),
                          decoration: provider.themeMode == ThemeMode.light? BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xFF5669FF),
                              border: BoxBorder.all(
                                  color: Color(0xFF5669FF),
                                  width: 2
                              )
                          ) : null,
                            child: Image.asset(
                              'assets/images/sun.png',
                              width: 30,
                              height: 30,
                              color: provider.themeMode == ThemeMode.light? null : Theme.of(context).colorScheme.primary
                            ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          provider.changeTheme(ThemeMode.dark);
                        },
                        child: Container(
                          padding: provider.themeMode == ThemeMode.dark? null : EdgeInsets.only(right: 5),
                          decoration: provider.themeMode == ThemeMode.dark? BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(0xFF5669FF),
                              border: BoxBorder.all(
                                  color: Color(0xFF5669FF),
                                  width: 2
                              )
                          ) : null,
                          child: Image.asset(
                              'assets/images/moon.png',
                              width: 30,
                              height: 30,
                              color: provider.themeMode == ThemeMode.dark? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.primary

                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushReplacementNamed(context, IntroScreen.routeName);
                  },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF5669FF),
                  padding: EdgeInsetsGeometry.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)
                  )
                ),
                child:  Text("Let’s Start", style: Theme.of(context).textTheme.displaySmall),
              ),
            )
          ],
        ),
      ),
    );
  }
}
