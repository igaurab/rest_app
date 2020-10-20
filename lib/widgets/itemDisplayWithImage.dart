import 'package:flutter/material.dart';
import 'package:protoype/widgets/roundedImage.dart';

class ItemDisplayWithImage extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String price;
  final TextTheme textTheme;

  const ItemDisplayWithImage({
    Key key,
    this.imageUrl,
    this.name,
    this.price,
    @required this.textTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RoundedImage(
          imageUrl: imageUrl,
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          name,
          style: textTheme.headline3,
        ),
        Text(
          "Price: $price",
          style: textTheme.headline2,
        )
      ],
    );
  }
}
