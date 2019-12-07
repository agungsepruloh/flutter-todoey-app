import 'package:flutter/material.dart';
import 'dart:collection';

import 'package:todoey_app_flutter/models/task.dart';
import 'package:todoey_app_flutter/helpers/db_helper.dart';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [];

  // getter for private variable
  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get taskCount {
    return _tasks.length;
  }

  void addTask(Task newTask) {
    final task = Task(
      id: newTask.id,
      name: newTask.name,
      isDone: newTask.isDone,
    );
    _tasks.add(task);
    notifyListeners();

    DBHelper.insert('user_todos', {
      'id': newTask.id,
      'name': newTask.name,
      'is_done': newTask.isDone,
    });
  }

  void updateTask(Task task) {
    task.toggleDone();
    notifyListeners();

    DBHelper.update('user_todos', task.id, task.isDone);
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();

    DBHelper.delete('user_todos', task.id);
  }

  Future<void> fetchAndSetPlace() async {
    final dataList = await DBHelper.getData('user_todos');
    _tasks = dataList
        .map(
          (item) => Task(
            id: item['id'],
            name: item['name'],
            isDone: item['is_done'] == 0 ? false : true,
          ),
        )
        .toList();
    notifyListeners();
  }
}
