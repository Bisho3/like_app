import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String image;
  final double width;
  final double height;
  final BorderRadiusGeometry? border;

  const CustomNetworkImage({
    Key? key,
    required this.image,
    this.width = double.infinity,
    this.height = 140,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.cover,
        width: width,
        height: height,
        imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: border,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
        progressIndicatorBuilder: (context, url, progress) =>
            CircularProgressIndicator(
              value: progress.progress,
            ),
        errorWidget: (context, url, error) => const Icon(Icons.error));
  }
}
