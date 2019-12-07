import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todoey_app_flutter/models/task_data.dart';

class AddTaskScreen extends StatelessWidget {
  final _taskTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String newTaskTitle;

    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Add New Task',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.lightBlueAccent,
                fontSize: 30,
              ),
            ),
            TextField(
              autofocus: true,
              controller: _taskTitleController,
              decoration: InputDecoration(
                hintText: 'e.g Read a Book',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightBlueAccent),
                ),
              ),
              onChanged: (value) {
                newTaskTitle = value;
              },
              onSubmitted: (value) {
                Provider.of<TaskData>(context).addTask(value);
                Navigator.pop(context);
              },
              textAlign: TextAlign.center,
            ),
            FlatButton(
              child: Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.lightBlueAccent,
              onPressed: () {
                Provider.of<TaskData>(context).addTask(newTaskTitle);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
