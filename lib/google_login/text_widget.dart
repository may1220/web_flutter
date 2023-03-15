import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  const TextWidget(
      {super.key,
      required this.text,
      this.color = const Color(0xFF898989),
      this.fontSize = 14.0,
      this.fontWeight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}
