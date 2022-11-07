import 'package:blog/model/user.dart';
import 'package:blog/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _nameCtrl = TextEditingController();
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Column(children: [
        TextField(
          controller: _nameCtrl,
        ),
        TextField(
          controller: _emailCtrl,
        ),
        TextField(
          controller: _passwordCtrl,
        ),
        ElevatedButton(
            onPressed: () {
              UserModel user = UserModel(
                name: _nameCtrl.text,
                email: _emailCtrl.text,
                password: _passwordCtrl.text,
              );
              AuthService().register(user);
            },
            child: Text("Register")),
        TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
          child: Text("Back to Login"),
        )
      ]),
    );
  }
}
