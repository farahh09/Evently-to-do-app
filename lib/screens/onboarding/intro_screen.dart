import 'package:easy_localization/easy_localization.dart';
import 'package:evently/models/onboarding_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/extensions.dart';
import '../../providers/theme_provider.dart';
import '../auth/login_screen.dart';

class IntroScreen extends StatefulWidget {
  static const String routeName = 'IntroScreen';

  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController pageController = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);
    final List<OnboardingModel> pages = [
      OnboardingModel(
        image: 'assets/images/intro1.png',
        title: 'intro1Title'.tr(),
        description: 'intro1Desc'.tr(),
        index: 0,
      ),
      OnboardingModel(
        image: 'assets/images/intro2.png',
        title: 'intro2Title'.tr(),
        description: 'intro2Desc'.tr(),
        index: 1,
      ),
      OnboardingModel(
        image: 'assets/images/intro3.png',
        title: 'intro3Title'.tr(),
        description: 'intro3Desc'.tr(),
        index: 2,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: (currentIndex > 0)? Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: provider.themeMode == ThemeMode.light ? context.onSecondary() : context.onPrimary(),
            borderRadius: BorderRadius.circular(8),
            border: BoxBorder.all(
              color: provider.themeMode == ThemeMode.light ? Color(0xFFF0F0F0) : context.outline(),
            )
          ),
          child: InkWell(
            onTap: () {
              pageController.animateToPage(currentIndex - 1, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut,);
              },
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon(Icons.arrow_back_ios, color: provider.themeMode == ThemeMode.light ? context.primary() : context.onSecondary(),),
            )),
        ) : null,
        title: Image.asset('assets/images/evently_logo.png', width: 142, height: 27, color: context.primary(),),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ElevatedButton(
              onPressed: (){
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: provider.themeMode == ThemeMode.light ? context.onSecondary() : context.onPrimary(),
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: provider.themeMode == ThemeMode.light? BorderSide.none : BorderSide(
                      color: context.outline(),
                      width: 0.5,
                    ),
                  )
              ),
              child: Text('skip'.tr(), style: context.displaySmall().copyWith(color: provider.themeMode == ThemeMode.light? context.primary() : context.onSecondary()),),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: 3,
              onPageChanged: (index) {
                setState(() => currentIndex = index);
              },
              itemBuilder: (context, i) {
                return pages[i];
              },
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SafeArea(
                child: ElevatedButton(
                  onPressed: (){
                    if (currentIndex < 2) {
                      pageController.animateToPage(
                        currentIndex + 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {

                      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: context.primary(),
                      padding: EdgeInsetsGeometry.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      )
                  ),
                  child: Text(currentIndex == 2? 'getStarted'.tr() : 'next'.tr(), style: context.displayLarge()),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
