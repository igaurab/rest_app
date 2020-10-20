import 'package:flutter/material.dart';

class IconWithText extends StatelessWidget {
  final Text text;
  final Icon icon;
  final Function onTap;
  const IconWithText({
    this.text,
    this.icon,
    this.onTap,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          icon,
          SizedBox(
            width: 7,
          ),
          text,
        ],
      ),
    );
  }
}
