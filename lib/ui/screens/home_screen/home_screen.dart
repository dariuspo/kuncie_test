import 'package:flutter/material.dart';
import 'package:kuncie_test/ui/screens/home_screen/widgets/song_results.dart';
import 'package:kuncie_test/ui/themes/color_scheme.dart';
import 'package:kuncie_test/ui/widgets/search_widget.dart';

///Using [NestedScrollView] and [SliverAppBar]
///to have more view when widget is scrolled and immediately show again
///if scroll up using floating:true
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            pinned: false,
            floating: true,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: kPrimaryGradient,
              ),
              child: SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SearchWidget(),
                    ],
                  ),
                ),
              ),
            ),
            snap: true,
            elevation: 3.0,
          ),
        ];
      },
      body: const SongResults(),
    );
  }
}
