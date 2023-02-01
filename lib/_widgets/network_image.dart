import 'package:flutter/material.dart';

class NetWorkImage extends StatelessWidget {
  const NetWorkImage(
      {super.key, required this.url, this.height, this.width, this.boxFit});
  final String url;
  final double? height;
  final double? width;
  final BoxFit? boxFit;
  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      width: width,
      height: height,
      fit: boxFit,
      errorBuilder: ((context, error, stackTrace) {
        return Container(
          color: Colors.grey[300],
          width: width,
          height: height,
        );
      }),
    );
  }
}
