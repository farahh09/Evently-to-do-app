import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import 'extensions.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final String? icon;
  final String? Function(String?)? validator;
  final VoidCallback? onPressed;
  final TextEditingController? controller;
  final int maxLines;
  final String? suffixIconPath;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.obscureText,
    this.icon,
    this.validator,
    this.onPressed,
    this.controller,
    this.maxLines = 1,
    this.suffixIconPath,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      onChanged: onChanged,
      validator: validator,
      maxLines: maxLines,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: context.labelMedium(),
        prefixIcon: icon == null
            ? null
            : Padding(
                padding: const EdgeInsets.only(top: 12, left: 16, bottom: 12),
                child: Image.asset(icon!, width: 24, height: 24),
              ),
        filled: true,
        fillColor: provider.themeMode == ThemeMode.light
            ? context.onSecondary()
            : context.onPrimary(),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: provider.themeMode == ThemeMode.light
                ? Color(0xFFF0F0F0)
                : context.outline(),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: context.primary()),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: context.error()),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: context.error()),
        ),
        suffixIcon: onPressed != null
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Color(0xFF898F9C),
                ),
                onPressed: onPressed,
              )
            : suffixIconPath != null
            ? Padding(
                padding: const EdgeInsets.all(12),
                child: Image.asset(suffixIconPath!, width: 24, height: 24),
              )
            : null,
      ),
    );
  }
}
