import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CacheImage extends StatelessWidget {
  final String keys;
  final String url;
  final BoxFit? fit;
  const CacheImage({super.key, required this.keys, required this.url, this.fit = BoxFit.contain});

  @override
  Widget build(BuildContext context) {

    return CachedNetworkImage(
        filterQuality: FilterQuality.high,
        imageUrl: url,
        placeholder: (context, url) => Image.asset('assets/images/logo_back.png', fit: BoxFit.cover),
        errorWidget: (context, url, error) {
          debugPrint('Xatolik: $url');
          return Image.asset('assets/images/logo_back.png', fit: BoxFit.cover);
        },
        fit: fit
    );
  }
}