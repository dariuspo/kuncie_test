import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
    Uri uri = Uri.parse(imageUrl);
    if (uri.host.contains("googleusercontent.com")) {
      return LayoutBuilder(
        builder: (context, constraints) {
          if (width != null || height != null) {
            constraints = BoxConstraints(
                maxWidth: width ?? double.minPositive,
                maxHeight: height ?? double.minPositive);
          } else {
            final ratio = MediaQuery.of(context).devicePixelRatio;
            constraints = BoxConstraints(
              maxWidth: constraints.maxWidth != double.infinity
                  ? constraints.maxWidth * ratio
                  : constraints.maxWidth,
              maxHeight: constraints.maxHeight != double.infinity
                  ? constraints.maxHeight * ratio
                  : constraints.maxHeight,
            );
          }
          final _constrainHeight = constraints.maxHeight != double.infinity
              ? constraints.maxHeight.toInt()
              : null;
          final _constrainWidth = constraints.maxWidth != double.infinity
              ? constraints.maxWidth.toInt()
              : null;
          String finalUrl =
              '$imageUrl=w$_constrainWidth-h$_constrainHeight-c-pp-l100-rj';
          return _buildImageUsingCachedNetworkImage(context, finalUrl);
        },
      );
    } else {
      return _buildImageUsingCachedNetworkImage(context, imageUrl);
    }
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
      // useScaleCacheManager: false,
    );
  }
}

Widget _buildErrorWidget(context, errorValue, _) {
  return const SizedBox();
}
