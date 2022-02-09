import 'package:flutter/material.dart';
import 'package:kuncie_test/ui/screens/home_screen/widgets/current_query.dart';
import 'package:kuncie_test/ui/screens/home_screen/widgets/song_results.dart';
import 'package:kuncie_test/ui/themes/color_scheme.dart';
import 'package:kuncie_test/ui/widgets/search_widget.dart';

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
                gradient: LinearGradient(colors: [
                  kPrimaryColor,
                  kSecondaryColor,
                ], stops: [
                  0.5,
                  0.9
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
              ),
              child: SafeArea(
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SearchWidget(),
                    CurrentQuery(),
                  ],
                )),
              ),
            ),
            snap: true,
            elevation: 3.0,
            toolbarHeight: 75,
          ),
        ];
      },
      body: const SongResults(),
    );
  }
}
