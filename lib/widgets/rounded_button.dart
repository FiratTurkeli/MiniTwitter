import 'package:flutter/material.dart';
import 'package:manoo/constant/color.dart';
import 'package:manoo/constant/constants.dart';

class RoundedButton extends StatelessWidget {
  final String btnText;
  final void Function()? onBtnPressed;

  const RoundedButton({ Key? key, required this.btnText, required this.onBtnPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      color: primaryLight,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        onPressed: onBtnPressed,
        minWidth: 320,
        height: 60,
        child: Text(
          btnText,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}