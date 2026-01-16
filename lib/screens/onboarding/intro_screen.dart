import 'package:evently/model/onboarding_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/extensions.dart';
import '../../providers/theme_provider.dart';
import '../login_screen/login_screen.dart';

class IntroScreen extends StatefulWidget {
  static const String routeName = 'IntroScreen';

  IntroScreen({super.key});

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
        title: 'Find Events That Inspire You',
        description:
            'Dive into a world of events crafted to fit '
            'your unique interests. Whether you\'re into live music,'
            ' art workshops, professional networking, or simply discovering'
            ' new experiences, we have something for everyone. Our curated '
            'recommendations will help you explore, connect, and make the most'
            ' of every opportunity around you.',
        index: 0,
      ),
      OnboardingModel(
        image: 'assets/images/intro2.png',
        title: 'Effortless Event Planning',
        description: 'Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.',
        index: 1,
      ),
      OnboardingModel(
        image: 'assets/images/intro3.png',
        title: 'Connect with Friends & Share Moments',
        description: 'Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.',
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
              color: provider.themeMode == ThemeMode.light ? Color(0xFFF0F0F0) : context.containerBorder(),
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
                      color: context.containerBorder(),
                      width: 0.5,
                    ),
                  )
              ),
              child: Text('Skip', style: context.displaySmall().copyWith(color: provider.themeMode == ThemeMode.light? context.primary() : context.onSecondary()),),
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
                     }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: context.primary(),
                      padding: EdgeInsetsGeometry.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),

                      )
                  ),
                  child:  Text(currentIndex == 2? 'Get Started' : 'Next' , style: context.displayLarge()),
                ),
              ),
            ),
          )
        ],
      ),

    );
  }
}
