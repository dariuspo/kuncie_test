import 'package:flutter/material.dart';
import 'package:kuncie_test/ui/widgets/app_player.dart';

class PersistentScreen extends StatelessWidget {
  final Widget child;

  const PersistentScreen({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: child),
          const AppPlayer(),
        ],
      ),
    );
  }
}
