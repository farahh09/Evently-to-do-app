import 'package:evently/core/firebase_functions.dart';
import 'package:evently/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/custom_elevated_button.dart';
import '../../core/custom_textfield.dart';
import '../../core/extensions.dart';
import '../../providers/theme_provider.dart';

class SignupScreen extends StatefulWidget{
  static const String routeName = 'SignupScreen';
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isObscure = true;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ThemeProvider>(context);
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
                  child: Text("Create your account", style: context.headlineLarge(),)
              ),

              SizedBox(height: 16,),
              CustomTextField(
                controller: nameController,
                hintText: 'Enter your name',
                icon: 'assets/images/user.png',
                obscureText: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your name";
                  }
                  return null;
                },

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
                  if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",).hasMatch(value)) {
                    return "Please enter a valid email";
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
                  if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                  ).hasMatch(value)) {
                    return "Please enter a valid password";
                  }
                  return null;
                },
              ),

              SizedBox(height: 16,),
              CustomTextField(
                hintText: 'Confirm your password',
                icon: 'assets/images/password.png',
                obscureText: isObscure,
                onPressed: (){
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your rePassword";
                  }
                  if (value != passwordController.text) {
                    return "Password not matched";
                  }
                  return null;
                },
              ),

              SizedBox(height: 47,),
              CustomElevatedButton(
                  onPressed: () {
                    if(formKey.currentState!.validate()){
                      FirebaseFunctions.createUser(
                          emailController.text, passwordController.text,
                          nameController.text,
                          onSuccess: () {
                            Navigator.pushReplacementNamed(
                                context, LoginScreen.routeName);
                          },
                          onError: (message) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(
                                  message,
                                  style: context.displayMedium(),
                                )));
                          });
                    }
                  },
                  fillColor: context.primary(),
                  child: Text('Sign up', style: context.displayLarge())
              ),

              SizedBox(height: 24,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?', style: context.labelMedium(),),
                  TextButton(onPressed: (){
                    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                  }, child: Text('Login', style: context.displaySmall().copyWith(color: context.primary(), decoration: TextDecoration.underline, decorationColor: context.primary(),),))
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
                  onPressed: () {},
                  fillColor: provider.themeMode == ThemeMode.light ? context.onSecondary() : context.onPrimary(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 16,
                    children: [
                      Image.asset('assets/images/google.png', width: 24,height: 24,),
                      Text('Sign up with Google', style: context.displayLarge().copyWith(color: context.primary())),
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