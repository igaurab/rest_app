import 'package:flutter/material.dart';

class CardWithCenterText extends StatelessWidget {
  final LinearGradient gradient;
  final String text;
  final Function onTap;
  final double fontSize;
  final FontWeight fontWeight;

  const CardWithCenterText({
    this.fontSize,
    this.fontWeight,
    this.onTap,
    this.gradient,
    this.text,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 200,
        width: 250,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0), gradient: gradient),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: gradient == null ? Colors.black : Colors.white,
                fontSize: fontSize ?? 32.0,
                fontWeight: fontWeight ?? FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
