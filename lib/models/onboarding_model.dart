import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/extensions.dart';
import '../providers/theme_provider.dart';

class OnboardingModel extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final double index;

  const OnboardingModel({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 24),

          Image.asset(
            image,
            color: provider.themeMode == ThemeMode.light ? context.primary() : context.onSecondary(),
          ),
          SizedBox(height: 8),
          DotsIndicator(
            dotsCount: 3,
            position: index,
            decorator: DotsDecorator(
              color: Color(0xFFB9B9B9),
              activeColor: context.primary(),
              activeSize: Size(21, 8),
              activeShape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
              ),
            ),
          ),

          SizedBox(height: 16),
          Align(
            alignment: AlignmentGeometry.topLeft,
            child: Text(title, style: context.titleLarge()),
          ),

          SizedBox(height: 8),
          Text(description, style: context.bodyMedium()),
        ],
      ),
    );
  }
}
