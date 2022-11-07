import 'package:blog/model/user.dart';
import 'package:blog/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailCtrl =
      TextEditingController(text: "user1@demo.com");
  TextEditingController _passwordCtrl = TextEditingController(text: "123456");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(children: [
        TextField(
          controller: _emailCtrl,
        ),
        TextField(
          controller: _passwordCtrl,
        ),
        ElevatedButton(
            onPressed: () {
              UserModel user = UserModel(
                email: _emailCtrl.text,
                password: _passwordCtrl.text,
              );
              AuthService().login(context, user);
            },
            child: Text("Login")),
        TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/register');
          },
          child: Text("Create an account"),
        )
      ]),
    );
  }
}
