import 'package:flutter/material.dart';
import 'package:todo/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Welcome to TodoApp",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            UtilityWidget().heightSpace(40),
            TextFormField(
              decoration: InputDecoration(hintText: 'Task Name'),
            ),
            UtilityWidget().heightSpace(20),
            TextFormField(
              decoration: InputDecoration(hintText: 'Task Description'),
            ),
            UtilityWidget().heightSpace(40),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                "Add Task",
                style: TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
