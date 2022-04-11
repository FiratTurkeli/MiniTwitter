import 'package:flutter/material.dart';
import 'package:manoo/constant/color.dart';
import 'package:manoo/constant/constants.dart';
import 'package:manoo/services/auth_methods.dart';
import 'package:manoo/widgets/rounded_button.dart';


class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late String _email;
  late String _password;
  late String _name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryLight,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Registration',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Name',
                ),
                onChanged: (value) {
                  _name = value;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Email',
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
                  hintText: 'Password',
                ),
                onChanged: (value) {
                  _password = value;
                },
              ),
              const SizedBox(
                height: 40,
              ),
              RoundedButton(
                btnText: 'Create account',
                onBtnPressed: () async {
                  await AuthMethods().signUpUser(email: _email, password: _password, username: _name);
                  Navigator.of(context).pop(context);
                    },
              ),
            ],
          ),
        ),
      ),
    );
  }
}