import 'package:flutter/material.dart';
import 'package:manoo/constant/color.dart';
import 'package:manoo/services/auth_methods.dart';
import 'package:manoo/widgets/rounded_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String _email;
  late String _password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryLight,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Log in',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Enter Your email',
              ),
              onChanged: (value) {
                _email = value;
              },
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Enter Your password',
              ),
              onChanged: (value) {
                _password = value;
              },
            ),
            const SizedBox(
              height: 40,
            ),
            RoundedButton(
              btnText: 'LOG IN',
              onBtnPressed: () async {
                await AuthMethods().loginUser(email: _email, password: _password);
                Navigator.of(context).pop(context);
                },
            ),
          ],
        ),
      ),
    );
  }
}