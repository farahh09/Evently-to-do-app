import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import 'extensions.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color fillColor;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.child, required this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: fillColor,
          padding: EdgeInsetsGeometry.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          side: provider.themeMode == ThemeMode.light? BorderSide.none : BorderSide(
            color: context.outline(),
            width: 0.5,
          ),
        ),
        child: child,
      ),
    );
  }
}
