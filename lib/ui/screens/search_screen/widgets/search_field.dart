import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuncie_test/blocs/search_songs/search_songs_cubit.dart';
import 'package:line_icons/line_icons.dart';

class SearchField extends StatefulWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();

  onSearchSubmitted(String? value) {
    if ((value?.length ?? 0) < 3) return;
    BlocProvider.of<SearchSongsCubit>(context).searchSong(value!);
    context.router.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
      height: 35,
      child: TextField(
        autofocus: true,
        textInputAction: TextInputAction.search,
        onSubmitted: onSearchSubmitted,
        decoration: InputDecoration(
          filled: true,
          prefixIcon: const Icon(
            LineIcons.search,
            size: 13.5,
          ),contentPadding: const EdgeInsets.all(5),
          hintText: "Search songs by artist name",
          prefixIconConstraints: const BoxConstraints(
            minWidth: 38,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          suffixIcon: _onSearchSuffixIcon,
          suffixIconConstraints: const BoxConstraints(minWidth: 23),
        ),

      ),
    );
  }

  Widget get _onSearchSuffixIcon {
    return _focusNode.hasFocus
        ? Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: GestureDetector(
        child: const CircleAvatar(
          backgroundColor: Color(0xFF67687E),
          child: Icon(
            Icons.close,
            size: 12.5,
            color: Color(0xFFD0D1E1),
          ),
        ),
        onTap: () {
          _textEditingController.clear();
        },
      ),
    )
        : const SizedBox.shrink();
  }
}
