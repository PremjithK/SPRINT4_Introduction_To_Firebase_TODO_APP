import 'package:flutter/material.dart';
import 'package:todo/login/login.dart';
import 'package:todo/sign_up/repo/signup_repo.dart';
import 'package:todo/widgets/widgets.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
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
              Text('Sign Up', style: TextStyle(fontSize: 25)),
              UtilityWidget().heightSpace(40),
              //
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a name";
                  }
                },
                controller: _nameController,
                decoration: InputDecoration(hintText: 'Name'),
              ),
              UtilityWidget().heightSpace(20),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter an email";
                  }
                },
                controller: _emailController,
                decoration: InputDecoration(hintText: 'Email'),
              ),
              UtilityWidget().heightSpace(20),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a phone no.";
                  }
                },
                controller: _phoneController,
                decoration: InputDecoration(hintText: 'Phone No.'),
              ),
              UtilityWidget().heightSpace(20),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter an address";
                  }
                },
                controller: _addressController,
                decoration: InputDecoration(hintText: 'Address'),
              ),
              UtilityWidget().heightSpace(20),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a password";
                  }
                },
                controller: _passwordController,
                decoration: InputDecoration(hintText: 'Password'),
              ),
              UtilityWidget().heightSpace(20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await SignupRepo().createUser(
                        _nameController.text,
                        _emailController.text,
                        _phoneController.text,
                        _addressController.text,
                        _passwordController.text,
                        context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  }
                },
                child: const Text('Sign Up'),
              ),
              UtilityWidget().heightSpace(10),
            ],
          ),
        ),
      ),
    );
  }
}
