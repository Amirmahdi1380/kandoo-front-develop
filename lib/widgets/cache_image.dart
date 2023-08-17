import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CachedImage extends StatelessWidget {
  String? imageUrl;
  double radious;
  CachedImage({
    super.key,
    this.imageUrl,
    this.radious = 0,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radious)),
      child: CachedNetworkImage(
        fit: BoxFit.fill,
        imageUrl: imageUrl ?? '',
        errorWidget: (context, url, error) {
          return Container(
            color: Colors.grey,
          );
        },
        placeholder: (context, url) {
          return SizedBox(
            child: Image.asset("assets/images/placeholder.png"),
          );
        },
      ),
    );
  }
}
