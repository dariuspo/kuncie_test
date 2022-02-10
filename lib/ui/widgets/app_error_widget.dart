import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class AppErrorWidget extends StatelessWidget {
  final String errorMessage;
  const AppErrorWidget({Key? key, required this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(LineIcons.exclamationTriangle, color: Colors.red),
        Text(errorMessage)
      ],
    );
  }
}
