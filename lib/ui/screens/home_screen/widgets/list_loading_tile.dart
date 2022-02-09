import 'package:flutter/material.dart';
import 'package:kuncie_test/ui/widgets/app_shimmer_rectangle.dart';
import 'package:shimmer/shimmer.dart';

class ListLoadingTile extends StatelessWidget {
  const ListLoadingTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: List.generate(
        12,
        (index) => const ListTile(
          leading: AppShimmerRectangle(
            height: 50,
            width: 50,
          ),
          title: AppShimmerRectangle(),
          subtitle: AppShimmerRectangle(),
          isThreeLine: true,
        ),
      ).toList(),
    );
  }
}
