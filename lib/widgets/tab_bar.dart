import 'package:flutter/material.dart';

class BuildTabBar extends StatelessWidget {

  final String title;
  const BuildTabBar({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 150,
        child: Tab(text: title),
      ),
    );
  }
}
