import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/extensions.dart';
import 'package:evently/core/firebase_functions.dart';
import 'package:evently/providers/home_provider.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => HomeProvider()..getUser(),
      builder: (context, child) {
        var homeProvider = Provider.of<HomeProvider>(context);
        return SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 16),
                  child: Container(
                    height: 104,
                    width: 104,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset('assets/images/route.png'))
                  ),
                ),
                SizedBox(height: 16,),
                Center(
                  child: homeProvider.user != null
                      ? Text(homeProvider.user!.name, style: context.titleLarge(),)
                      : null,
                ),
                SizedBox(height: 4,),
                Center(
                  child: homeProvider.user != null
                      ? Text(homeProvider.user!.email, style: context.labelMedium(),)
                      : null,
                ),
                SizedBox(height: 32,),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  margin: EdgeInsets.all(8),
                  height: 48,
                  decoration: BoxDecoration(
                    color: context.onPrimary(),
                    borderRadius: BorderRadiusGeometry.circular(16),
                    border: Border.all(color: context.outline()),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'darkMode'.tr(),
                        style: context.displayMedium().copyWith(
                          color: context.onSurface(),
                        ),
                      ),
                      FlutterSwitch(
                          width: 40,
                          height: 22,
                          toggleSize: 18,
                          padding: 2,
                          borderRadius: 12,
                          activeColor: context.primary(),
                          value: isDark,
                          onToggle: (value) {
                            setState(() {
                              isDark = !isDark;
                            });
                            isDark == true
                                ? themeProvider.changeTheme(ThemeMode.dark)
                                : themeProvider.changeTheme(ThemeMode.light);
                          }
                      )
                    ],
                  ),
                ),
            
                SizedBox(height: 16,),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  margin: EdgeInsets.all(8),
                  height: 48,
                  decoration: BoxDecoration(
                    color: context.onPrimary(),
                    borderRadius: BorderRadiusGeometry.circular(16),
                    border: Border.all(color: context.outline()),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("language".tr(), style: context.displayMedium().copyWith(
                        color: context.onSurface(),
                      ),),
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
                                  side: themeProvider.themeMode == ThemeMode.light? BorderSide.none : BorderSide(
                                    color: context.outline(),
                                    width: 0.5,
                                  ),
                                )
                            ),
                            child: Text("english".tr(), style: context.displaySmall().copyWith(color: themeProvider.themeMode == ThemeMode.dark? context.onSurface() : context.locale == Locale("en", "US") ? context.onSecondary() : context.primary())),
                          ),
                          ElevatedButton(
                            onPressed: (){
                              context.setLocale(Locale("ar", "EG"));                      },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: context.locale == Locale("en", "US") ? context.onPrimary() : context.primary(),
                              padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: themeProvider.themeMode == ThemeMode.dark? BorderSide(
                                  color: context.outline(),
                                  width: 0.5,
                                ) : BorderSide.none,
                              ),
                            ),
                            child:  Text("arabic".tr(), style: context.displaySmall().copyWith(color: themeProvider.themeMode == ThemeMode.dark? context.onSurface() : context.locale == Locale("en", "US") ? context.primary() : context.onSecondary())),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            
                SizedBox(height: 16,),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  margin: EdgeInsets.all(8),
                  height: 48,
                  decoration: BoxDecoration(
                    color: context.onPrimary(),
                    borderRadius: BorderRadiusGeometry.circular(16),
                    border: Border.all(color: context.outline()),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'logout'.tr(),
                        style: context.displayMedium().copyWith(
                          color: context.onSurface(),
                        ),
                      ),
                      InkWell(
                          onTap: (){
                            FirebaseFunctions.signOut();
                            Navigator.pushNamedAndRemoveUntil(
                              context, LoginScreen.routeName, (route) => false,);
                          },
                          child: Image.asset(
                            'assets/images/logout.png', color: context.error(),
                            width: 24,
                            height: 24,)
                      )
                    ],
                  ),
                ),
              ],
            ),
        );
      }

    );

  }
}
