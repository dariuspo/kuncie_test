import 'package:flutter/material.dart';
import 'package:kuncie_test/ui/screens/search_screen/widgets/search_field.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          BackButton(),
          Expanded(
            child: SearchField(),
          ),
        ],
      ),
    );
  }
}
