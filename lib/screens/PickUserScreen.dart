import 'package:flutter/material.dart';
import 'package:protoype/constants/assets.dart';
import 'package:protoype/constants/strtings.dart';

class PickUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(AppString.pickRole,
              style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 25.0,
          ),
          Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ImageWithVerticalLabel(
                    assetUrl: ImageAsset.admin,
                    text: AppString.admin,
                    onTap: () => Navigator.of(context).pushNamed(
                      '/roles',
                    ),
                  ),
                  ImageWithVerticalLabel(
                    assetUrl: ImageAsset.costumers,
                    text: AppString.costumers,
                    onTap: () => Navigator.of(context).pushNamed(
                      '/costumers',
                    ),
                  ),
                  ImageWithVerticalLabel(
                    assetUrl: ImageAsset.chef,
                    text: AppString.chef,
                    onTap: () => Navigator.of(context).pushNamed(
                      '/roles',
                    ),
                  ),
                  ImageWithVerticalLabel(
                    assetUrl: ImageAsset.waiter,
                    text: AppString.waiter,
                    onTap: () => Navigator.of(context).pushNamed(
                      '/roles',
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageWithVerticalLabel extends StatelessWidget {
  final String assetUrl;
  final String text;
  final double width;
  final double height;
  final TextStyle textStyle;
  final Function onTap;
  const ImageWithVerticalLabel({
    this.assetUrl,
    this.text,
    this.width,
    this.height,
    this.textStyle,
    this.onTap,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Column(
          children: [
            Image.asset(
              assetUrl,
              height: height ?? 200,
              width: width ?? 200,
            ),
            Text(
              text,
              style: textStyle ??
                  TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}
