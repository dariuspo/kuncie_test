import 'package:audioplayers/audioplayers.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuncie_test/app/app_router.dart';
import 'package:kuncie_test/blocs/audio_player/audio_player_bloc.dart';
import 'package:kuncie_test/blocs/search_songs/search_songs_cubit.dart';
import 'package:kuncie_test/repositories/song_repository.dart';
import 'package:kuncie_test/ui/screens/presistent_screen/persistent_screen.dart';
import 'package:kuncie_test/ui/themes/dark.dart';
import 'package:kuncie_test/ui/themes/light.dart';

class App extends StatelessWidget {
  final _appRouter = AppRouter();

  App({
    Key? key,
    required this.songRepository,
  }) : super(key: key);

  final SongRepository songRepository;

  @override
  Widget build(BuildContext context) {
    //repository inherited and injected to bloc for easier unit test
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: songRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AudioPlayerBloc>(
            create: (context) => AudioPlayerBloc(AudioPlayer(mode: PlayerMode.MEDIA_PLAYER)),
          ),
          BlocProvider<SearchSongsCubit>(
            create: (context) => SearchSongsCubit(songRepository),
          ),
        ],
        child: MaterialApp.router(
          routerDelegate: AutoRouterDelegate(_appRouter),
          routeInformationParser: _appRouter.defaultRouteParser(),
          builder: (context, child) => PersistentScreen(
            child: child ?? const SizedBox.shrink(),
          ),
          title: "Kuncie's Test",
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.system,
        ),
      ),
    );
  }
}
