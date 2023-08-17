import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/home_screen/home_screen.dart';
import 'package:todo/sign_up/sign_up_page.dart';
import 'package:todo/widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Log In", style: TextStyle(fontSize: 25)),
              UtilityWidget().heightSpace(40),
              //
              TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter email';
                  }
                },
                decoration: InputDecoration(hintText: 'Email'),
              ),
              UtilityWidget().heightSpace(20),
              TextFormField(
                controller: _passwordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter password';
                  }
                },
                decoration: InputDecoration(hintText: 'Password'),
              ),
              UtilityWidget().heightSpace(20),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      final _auth = FirebaseAuth.instance;
                      final userRef = await _auth.signInWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ));
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Invalid Username And Password')));
                    }
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
      ),
    );
  }
}
