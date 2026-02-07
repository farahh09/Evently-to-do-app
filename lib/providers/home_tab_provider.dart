import 'dart:async';
import 'package:evently/core/firebase_functions.dart';
import 'package:evently/models/task_model.dart';
import 'package:flutter/material.dart';

class HomeTabProvider extends ChangeNotifier {
  final List<String> categories = [
    "all",
    "sport",
    "birthday",
    "book_club",
    "exhibition",
    "meeting",
  ];
  int selectedCategoryIndex = 0;
  List<TaskModel> tasks = [];
  StreamSubscription? _tasksSubscription;

  void changeCategory(int index) {
    selectedCategoryIndex = index;
    getTasksStream();
    notifyListeners();
  }

  void getTasksStream() {
    _tasksSubscription?.cancel();

    _tasksSubscription =
        FirebaseFunctions.getTasksStream(
          category: selectedCategoryIndex == 0
              ? null
              : categories[selectedCategoryIndex],
        ).listen((event) {
          tasks = event.docs.map((e) => e.data()).toList();
          notifyListeners();
        });
  }

  Future<void> updateTask(TaskModel task) async {
    await FirebaseFunctions.updateTask(task);
  }

  @override
  void dispose() {
    _tasksSubscription?.cancel();
    super.dispose();
  }
}
