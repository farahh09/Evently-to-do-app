import 'package:evently/core/custom_elevated_button.dart';
import 'package:evently/core/custom_textfield.dart';
import 'package:evently/core/firebase_functions.dart';
import 'package:evently/screens/auth/forget_password_screen.dart';
import 'package:evently/screens/auth/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/extensions.dart';
import '../home/home_screen.dart';
import '/providers/theme_provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'LoginScreen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscure = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/evently_logo.png', width: 142, height: 27, color: context.primary(),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 48,),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Login to your account", style: context.headlineLarge(),)
              ),
              SizedBox(height: 16,),
              CustomTextField(
                controller: emailController,
                hintText: 'Enter your email',
                icon: 'assets/images/email.png',
                obscureText: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your Email";
                  }
                  return null;
                },
              ),
          
              SizedBox(height: 16,),
              CustomTextField(
                controller: passwordController,
                hintText: 'Enter your password',
                icon: 'assets/images/password.png',
                obscureText: isObscure,
                onPressed: (){
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your Password";
                  }
                  return null;
                },
              ),
          
              SizedBox(height: 8,),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(onPressed: (){
                  Navigator.pushNamed(context, ForgetPasswordScreen.routeName);
                },
                    child: Text('Forget Password?', style: context.displaySmall().copyWith(color: context.primary(), decoration: TextDecoration.underline,decorationColor: context.primary(),),)
                ),
              ),
              SizedBox(height: 47,),
              CustomElevatedButton(
                onPressed: () {
                  if(formKey.currentState!.validate()){
                    FirebaseFunctions.login(
                        emailController.text,
                        passwordController.text,
                        onSuccess: (){
                          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
                        },
                        onError: (message) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(
                                message,
                                style: context.displayMedium(),
                              ))
                          );
                        }
                    );
                  }
                },
                fillColor: context.primary(),
                child: Text('Login', style: context.displayLarge())
              ),
          
              SizedBox(height: 48,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account?', style: context.labelMedium(),),
                  TextButton(onPressed: (){
                    Navigator.pushReplacementNamed(context, SignupScreen.routeName);
                  }, child: Text('Signup', style: context.displaySmall().copyWith(color: context.primary(), decoration: TextDecoration.underline, decorationColor: context.primary(),),))
                ],
              ),
          
              SizedBox(height: 32,),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Color(0xFFF0F0F0),
                    ),
                  ),
                  Text('Or', style: context.displayMedium(),),
                  Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Color(0xFFF0F0F0),
                    ),
                  ),
                ],
              ),
          
              SizedBox(height: 32,),
              CustomElevatedButton(
                  onPressed: (){},
                  fillColor: provider.themeMode == ThemeMode.light ? context.onSecondary() : context.onPrimary(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 16,
                    children: [
                      Image.asset('assets/images/google.png', width: 24,height: 24,),
                      Text('Login with Google', style: context.displayLarge().copyWith(color: context.primary())),
                    ],
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
