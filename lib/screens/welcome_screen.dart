import 'package:flutter/material.dart';
import 'package:manoo/screens/login_screen.dart';
import 'package:manoo/screens/register_screen.dart';
import 'package:manoo/widgets/rounded_button.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: const [
                   SizedBox(
                    width: 200,
                  ),
                   Text(
                    'See what’s happening in the world right now',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                children: [
                  RoundedButton(
                      btnText: 'LOG IN',
                      onBtnPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                  RoundedButton(
                      btnText: 'Create account',
                      onBtnPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegistrationScreen()));
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}