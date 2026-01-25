import 'package:evently/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/custom_elevated_button.dart';
import '../../core/custom_textfield.dart';
import '../../providers/theme_provider.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static String routeName = 'ForgetPass';
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);
    TextEditingController emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: provider.themeMode == ThemeMode.light ? context.onSecondary() : context.onPrimary(),
              borderRadius: BorderRadius.circular(8),
              border: BoxBorder.all(
                color: provider.themeMode == ThemeMode.light ? Color(0xFFF0F0F0) : context.outline(),
              )
          ),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Icon(Icons.arrow_back_ios, color: provider.themeMode == ThemeMode.light ? context.primary() : context.onSecondary(),),
              ),
          )
        ),
        title: Text('Forget Password', style: context.displayMedium().copyWith(color: context.onSurface()),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(height: 32,),
            Image.asset('assets/images/forget_password.png', color: provider.themeMode == ThemeMode.dark? context.onSurface() : null,),
            CustomTextField(
              controller: emailController,
              hintText: 'Enter your email',
              icon: 'assets/images/email.png',
              obscureText: false,
            ),
            SizedBox(height: 40,),
            CustomElevatedButton(
                onPressed: () {},
                fillColor: context.primary(),
                child: Text('Reset password', style: context.displayLarge())
            ),
          ],
        ),
      ),
    );
  }
}
