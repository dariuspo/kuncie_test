// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuncie_test/blocs/playing_song/playing_song_cubit.dart';
import 'package:kuncie_test/blocs/playing_song/playing_song_cubit.dart';
import 'package:kuncie_test/ui/widgets/expanded_section.dart';
import 'package:kuncie_test/ui/widgets/player_widget.dart';

class AppPlayer extends StatefulWidget {
  const AppPlayer({Key? key}) : super(key: key);

  @override
  _AppPlayerState createState() => _AppPlayerState();
}

class _AppPlayerState extends State<AppPlayer> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlayingSongCubit, PlayingSongState>(
      listener: (context, state) {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      listenWhen: (prev, curr) {
        if (prev is PlayingSongInitial && curr is PlayingSongIsPlaying) {
          return true;
        }
        return false;
      },
      child: ExpandedSection(
        expand: isExpanded,
        child: GestureDetector(
          onTap: () => setState(() {
            isExpanded = !isExpanded;
          }),
          child: PlayerWidget(),
        ),
      ),
    );
  }
}
