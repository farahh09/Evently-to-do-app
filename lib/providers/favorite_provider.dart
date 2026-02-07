import 'dart:async';

import 'package:flutter/material.dart';
import '../core/firebase_functions.dart';
import '../models/task_model.dart';

class FavoriteProvider extends ChangeNotifier {
  List<TaskModel> favoriteTasks = [];
  List<TaskModel> filteredTasks = [];
  StreamSubscription? _tasksSubscription;

  void getTasks() {
    _tasksSubscription?.cancel();

    _tasksSubscription = FirebaseFunctions.getFavoriteTasks().listen((event) {
      favoriteTasks = event.docs.map((e) => e.data()).toList();
      filteredTasks = favoriteTasks;
      notifyListeners();
    });
  }

  void searchTasks(String query) {
    if (query.isEmpty) {
      filteredTasks = favoriteTasks;
    } else {
      filteredTasks = favoriteTasks.where(
            (task) => task.title.toLowerCase().contains(query.trim().toLowerCase())
                || task.category.toLowerCase().contains(query.trim().toLowerCase(),),
          )
          .toList();
    }
    notifyListeners();
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
