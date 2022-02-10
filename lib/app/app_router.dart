import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kuncie_test/ui/screens/home_screen/home_screen.dart';
import 'package:kuncie_test/ui/screens/search_screen/search_screen.dart';

part 'app_router.gr.dart';

///Support flutter navigator 2.0 named route and auto generate if
///parameter is required
// @CupertinoAutoRouter
// @AdaptiveAutoRouter
// @CustomAutoRouter
@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomeScreen, initial: true),
    AutoRoute(page: SearchScreen),
  ],
)
class AppRouter extends _$AppRouter {}
