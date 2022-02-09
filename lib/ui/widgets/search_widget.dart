import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kuncie_test/app/app_router.dart';
import 'package:line_icons/line_icons.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    Key? key,
  }) : super(key: key);

  _goToSearch(BuildContext context) {
    context.router.push(const SearchRoute());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _goToSearch(context),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 12),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(40),
        ),
        height: 35,
        child: Wrap(
          spacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            const Icon(
              LineIcons.search,
              size: 20,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 1.0),
              child: Text(
                'Search songs by artist name',
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
