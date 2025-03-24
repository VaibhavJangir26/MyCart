import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({super.key,
  required this.text,
  this.fontSize,
  this.fontWeight,
  this.textAlign,
  this.color,
  this.textOverFlow,
  this.maxLine,
  this.textDecoration,
  });

  final String text;
  final double? fontSize;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final Color? color;
  final TextOverflow? textOverFlow;
  final int? maxLine;
  final TextDecoration? textDecoration;


  @override
  Widget build(BuildContext context) {
    return Text(text,
    textAlign: textAlign,
    overflow: textOverFlow,
    maxLines: maxLine,
    style: TextStyle(
      fontWeight: fontWeight,
      fontSize: fontSize,
      color: color,
      decoration: textDecoration
    ),
    );
  }
}
