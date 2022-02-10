import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

///Helper widget to handle loading state
class AppShimmerRectangle extends StatelessWidget {
  final double width, height;

  const AppShimmerRectangle({
    Key? key,
    this.width = 100,
    this.height = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFD0D1E1),
      highlightColor: const Color(0xFF9899B0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
        ),
        width: width,
        height: height,
      ),
    );
  }
}
