import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:kuncie_test/models/song.dart';
import 'package:meta/meta.dart';

part 'playing_song_state.dart';

class PlayingSongCubit extends Cubit<PlayingSongState> {
  PlayingSongCubit() : super(PlayingSongInitial());

  playSong(Song song, PlayerState playerState){
    emit(PlayingSongIsPlaying(song, playerState));
  }
}
