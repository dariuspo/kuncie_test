import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

///Image Widget using cached network image
///Support click action to implement with zoom in function
class AppImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final ImageWidgetBuilder? imageBuilder;
  final PlaceholderWidgetBuilder? placeholder;
  final Function()? onTap;
  final LoadingErrorWidgetBuilder? errorWidget;
  final Alignment? alignment;

  const AppImage({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.imageBuilder,
    this.placeholder,
    this.errorWidget,
    this.onTap,
    this.alignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      if (placeholder != null) {
        return placeholder!(context, imageUrl);
      }
      return Container();
    }
    return _buildImageUsingCachedNetworkImage(context, imageUrl);
  }

  Widget _buildImageUsingCachedNetworkImage(
      BuildContext context, String imageUrl) {
    return onTap != null
        ? GestureDetector(
            onTap: onTap,
            child: cachedNetworkImage(),
          )
        : cachedNetworkImage();
  }

  CachedNetworkImage cachedNetworkImage() {
    return CachedNetworkImage(
      alignment: alignment ?? Alignment.center,
      imageUrl: imageUrl,
      imageBuilder: imageBuilder,
      placeholder: placeholder,
      errorWidget: errorWidget ?? _buildErrorWidget,
      width: width,
      height: height,
      fit: fit,
    );
  }
}

Widget _buildErrorWidget(context, errorValue, _) {
  return const SizedBox();
}
