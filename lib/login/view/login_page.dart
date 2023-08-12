import 'package:flutter/material.dart';
import 'package:todo/home_screen/home_screen.dart';
import 'package:todo/sign_up/sign_up_page.dart';
// import 'package:todo/login/login.dart';
import 'package:todo/widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Log In", style: TextStyle(fontSize: 25)),
            UtilityWidget().heightSpace(40),
            //
            TextFormField(
              decoration: InputDecoration(hintText: 'Username'),
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
                        builder: (context) => HomeScreen(),
                      ));
                },
                child: Text("Login")),
            UtilityWidget().heightSpace(10),
            Text("Or"), UtilityWidget().heightSpace(10),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUpPage(),
                      ));
                },
                child: Text("Sign Up"))
          ],
        ),
      ),
    );
  }
}
