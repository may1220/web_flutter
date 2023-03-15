import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;
  final String text;
  final String icon;
  const ButtonWidget(
      {super.key,
      this.backgroundColor = const Color.fromARGB(255, 234, 238, 248),
      this.textColor = const Color(0xFF567DF4),
      required this.text,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: backgroundColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(color: textColor, fontSize: 16),
          ),
          SizedBox(
            width: 5,
          ),
          Image.asset(icon),
        ],
      ),
    );
  }
}
