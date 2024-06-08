import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BaseCacheImage extends StatelessWidget {
  const BaseCacheImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit,
    this.errorWidget,
  });

  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: url,
      fit: BoxFit.cover,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            colorFilter: const ColorFilter.mode(
              Color.fromARGB(0, 244, 67, 54),
              BlendMode.colorBurn,
            ),
          ),
        ),
      ),
      placeholder: (context, url) =>  Container(),
      errorWidget: (context, url, error) =>
          errorWidget ??
          Image.asset(
            'assets/images/avatar_default_2.png',
            fit: fit ?? BoxFit.cover,
          ),
    );
  }
}
