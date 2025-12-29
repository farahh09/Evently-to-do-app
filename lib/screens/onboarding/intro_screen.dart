import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';

class IntroScreen extends StatelessWidget {
  static const String routeName = 'IntroScreen';
  IntroScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<ThemeProvider>(context);
    final List<PageViewModel> pages = [
      PageViewModel(
        titleWidget: Align(
          alignment: Alignment.topLeft,
          child: Text('Find Events That Inspire You', style: Theme.of(context).textTheme.titleLarge)
        ),
        bodyWidget: Text('Dive into a world of events crafted to fit your unique interests. Whether you\'re into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        image: Image.asset('assets/images/intro1.png'),
        decoration: PageDecoration(
          imagePadding: EdgeInsets.only(top: 39),
          titlePadding: EdgeInsets.only(top: 39),
          bodyPadding: EdgeInsets.only(top: 39),
        ),

      ),
      PageViewModel(
        titleWidget: Align(
      alignment: Alignment.topLeft,
          child: Text('Effortless Event Planning', style: Theme.of(context).textTheme.titleLarge),),
        bodyWidget: Text('Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        image: Center(
          child: provider.themeMode == ThemeMode.light?
          Image.asset('assets/images/intro2_light.png') : Image.asset('assets/images/intro2_dark.png')
        ),
        decoration: PageDecoration(
          imagePadding: EdgeInsets.only(top: 39),
          titlePadding: EdgeInsets.only(top: 39),
          bodyPadding: EdgeInsets.only(top: 39),
        ),
      ),
      PageViewModel(
        titleWidget: Align(
          alignment: Alignment.topLeft,
          child: Text('Connect with Friends & Share Moments', style: Theme.of(context).textTheme.titleLarge),),
        bodyWidget: Text('Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        image: Center(
          child: provider.themeMode == ThemeMode.light?
          Image.asset('assets/images/intro3_light.png') : Image.asset('assets/images/intro3_dark.png')
        ),
        decoration: PageDecoration(
          imagePadding: EdgeInsets.only(top: 39),
          titlePadding: EdgeInsets.only(top: 39),
          bodyPadding: EdgeInsets.only(top: 39),
        ),
      ),
    ];
    return Scaffold(
      appBar: AppBar(title: Image.asset('assets/images/evently_logo.png'),),
      body: IntroductionScreen(
        pages: pages,
        dotsFlex: 3,
        next: Container(
          width: 37,
          height: 37,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
              border: BoxBorder.all(
                  color: Theme.of(context).colorScheme.primary,
              ),
          ),
          child: Icon(Icons.arrow_forward, size: 22,),
        ),
        showNextButton: true,
        back: Container(
          width: 37,
          height: 37,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: BoxBorder.all(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: Icon(Icons.arrow_back, size: 22,),
        ),
        showBackButton: true,
        dotsDecorator: DotsDecorator(
          activeColor: Theme.of(context).colorScheme.primary,
          activeSize: Size(21, 8),
          activeShape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(36)
          ),
          color: Theme.of(context).colorScheme.onPrimary
        ),
        done: const Text("Done"),
        onDone: () {
        },
      ),
    );
  }

}
