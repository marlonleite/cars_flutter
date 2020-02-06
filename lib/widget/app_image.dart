import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppImage extends StatelessWidget {
  String url;
  String defaultUrl;
  double height;
  double width;

  AppImage(
    this.url, {
    this.defaultUrl =
        "https://i.pinimg.com/originals/6c/f4/4c/6cf44cd1cba55c1c54901db8c3311daa.png",
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url ?? defaultUrl,
      height: height,
      width: width,
    );
  }
}
