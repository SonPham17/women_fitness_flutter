import 'package:flutter/material.dart';

class TextApp extends StatelessWidget {
  final String content;
  final double size;
  final FontWeight fontWeight;
  final Color textColor;
  final TextAlign textAlign;
  final int maxLines;
  final TextOverflow textOverflow;

  TextApp({
    this.textAlign,
    this.content,
    this.size,
    this.textColor,
    this.fontWeight,
    this.maxLines,
    this.textOverflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: TextStyle(
        fontFamily: 'OpenSans',
        fontSize: size,
        color: textColor,
        fontWeight: fontWeight,
      ),
      overflow: textOverflow,
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}
