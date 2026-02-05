import 'package:evently/core/firebase_functions.dart';
import 'package:evently/models/user_model.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier{
  int selectedIndex = 0;
  UserModel? user;

  void changeIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
   Future<void> getUser() async{
    user = await FirebaseFunctions.readUser();
    notifyListeners();
  }
}