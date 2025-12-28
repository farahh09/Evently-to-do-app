import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/app_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroScreen extends StatelessWidget {
  static const String routeName = 'IntroScreen';
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            Image.asset('assets/images/creative.png'),
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
                        //padding: EdgeInsets.only(right: 5),
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
                      Container(
                        decoration:BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xFF5669FF),
                            border: BoxBorder.all(
                                color: Color(0xFF5669FF),
                                width: 2
                            )
                        ),
                        child: Image.asset('assets/images/sun.png', width: 30, height: 30,)),
                      Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Image.asset('assets/images/moon.png', width: 30, height: 30),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: (){},
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
