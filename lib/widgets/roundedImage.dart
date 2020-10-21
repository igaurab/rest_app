import 'package:flutter/material.dart';

class RoundedImage extends StatelessWidget {
  final imageUrl;
  final width;
  final height;
  final dynamic borderRadius;
  final onlyBorder;
  const RoundedImage({
    this.onlyBorder = false,
    this.imageUrl,
    this.width,
    this.height,
    this.borderRadius,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: onlyBorder
          ? BorderRadius.only(
              topLeft: Radius.circular(borderRadius[0]),
              topRight: Radius.circular(borderRadius[1]),
              bottomLeft: Radius.circular(borderRadius[2]),
              bottomRight: Radius.circular(borderRadius[3]))
          : BorderRadius.circular(borderRadius),
      child: Image.asset(
        this.imageUrl,
        height: height ?? 160,
        width: width ?? 250,
        fit: BoxFit.cover,
      ),
    );
  }
}
