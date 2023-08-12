import 'package:flutter/material.dart';
import 'package:todo/login/login.dart';
import 'package:todo/widgets/widgets.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Sign Up', style: TextStyle(fontSize: 25)),
            UtilityWidget().heightSpace(40),
            //
            TextFormField(
              decoration: InputDecoration(hintText: 'Name'),
            ),
            UtilityWidget().heightSpace(20),
            TextFormField(
              decoration: InputDecoration(hintText: 'Email'),
            ),
            UtilityWidget().heightSpace(20),
            TextFormField(
              decoration: InputDecoration(hintText: 'Phone No.'),
            ),
            UtilityWidget().heightSpace(20),
            TextFormField(
              decoration: InputDecoration(hintText: 'Address'),
            ),
            UtilityWidget().heightSpace(20),
            TextFormField(
              decoration: InputDecoration(hintText: 'Password'),
            ),
            UtilityWidget().heightSpace(20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ));
              },
              child: const Text('Sign Up'),
            ),
            UtilityWidget().heightSpace(10),
          ],
        ),
      ),
    );
  }
}
