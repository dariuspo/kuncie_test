import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:kuncie_test/app/app_logger.dart';
import 'package:kuncie_test/models/song.dart';
import 'package:kuncie_test/ui/screens/home_screen/widgets/song_results.dart';
import 'package:kuncie_test/ui/widgets/player_widget.dart';
import 'package:meta/meta.dart';

part 'audio_player_event.dart';

part 'audio_player_state.dart';

class AudioPlayerBloc extends Bloc<AudioPlayerEvent, AudioPlayerState> {
  final AudioPlayer audioPlayer;

  ///listen to player when duration of the song is changed
  late StreamSubscription _durationSubscription;

  ///listen to player when position time played is changed
  late StreamSubscription _positionSubscription;

  ///listen to player when song is completed
  late StreamSubscription _playerCompleteSubscription;

  ///listen to player when error occurred
  late StreamSubscription _playerErrorSubscription;

  AudioPlayerBloc(this.audioPlayer) : super(const AudioPlayerState()) {
    on<PlayNewSong>(onPlayNewSong);
    on<ResumeSong>(onResumeSong);
    on<PauseSong>(onPauseSong);
    on<StopSong>(onStopSong);
    on<CompleteSong>(onCompleteSong);
    on<SeekTime>(onSeekTime);
    on<DurationChanged>(onDurationChanged);
    on<PositionChanged>(onPositionChanged);
    _initAudioPlayer();
  }

  ///Triggered when pressed another song from [SongResults]
  /// next, or prev from [PlayerWidget]
  void onPlayNewSong(PlayNewSong event, Emitter<AudioPlayerState> emit) async {
    //when current song playing is same with the event do nothing
    if (state.playerState == PlayerState.PLAYING && event.song == state.song) {
      return;
    }
    try {
      final result = await audioPlayer.play(
        event.song.previewUrl ?? "",
        position: Duration.zero,
      );
      if (result == 1) {
        emit(state.copyWith(
          song: event.song,
          playerState: PlayerState.PLAYING,
        ));
      }
    } catch (e) {
      logger.e(e);
      emit(
        state.copyWith(
          song: event.song,
          playerState: PlayerState.STOPPED,
          haveError: true,
        ),
      );
    }
  }

  ///Triggered when press play from [PlayerWidget]
  void onResumeSong(ResumeSong event, Emitter<AudioPlayerState> emit) async {
    try {
      final result = await audioPlayer.play(
        state.song?.previewUrl ?? "",
        position: state.playerState == PlayerState.COMPLETED
            ? Duration.zero
            : state.position,
      );
      if (result == 1) {
        emit(state.copyWith(playerState: PlayerState.PLAYING));
      }
    } catch (e) {
      emit(
        state.copyWith(
          playerState: PlayerState.STOPPED,
          haveError: true,
        ),
      );
    }
  }

  ///Triggered when press pause from [PlayerWidget]
  void onPauseSong(PauseSong event, Emitter<AudioPlayerState> emit) async {
    final result = await audioPlayer.pause();
    if (result == 1) {
      emit(state.copyWith(playerState: PlayerState.PAUSED));
    }
  }

  ///Triggered when press stop from [PlayerWidget]
  void onStopSong(StopSong event, Emitter<AudioPlayerState> emit) async {
    final result = await audioPlayer.stop();
    if (result == 1) {
      emit(state.copyWith(
        playerState: PlayerState.STOPPED,
        position: Duration.zero,
      ));
    }
  }

  ///Triggered when stream of [AudioPlayer] have complete status
  void onCompleteSong(
    CompleteSong event,
    Emitter<AudioPlayerState> emit,
  ) async {
    emit(state.copyWith(
      playerState: PlayerState.COMPLETED,
    ));
  }

  ///Triggered by changing slider in [PlayerWidget]
  void onSeekTime(SeekTime event, Emitter<AudioPlayerState> emit) async {
    audioPlayer.seek(event.time);
  }

  ///Triggered when duration of [AudioPlayer] have changed
  void onDurationChanged(
    DurationChanged event,
    Emitter<AudioPlayerState> emit,
  ) async {
    emit(state.copyWith(
      duration: event.duration,
    ));
  }

  ///Triggered when position of time in [AudioPlayer] have changed
  void onPositionChanged(
    PositionChanged event,
    Emitter<AudioPlayerState> emit,
  ) async {
    emit(state.copyWith(
      position: event.position,
    ));
  }

  void _initAudioPlayer() {
    _durationSubscription = audioPlayer.onDurationChanged.listen(
      (duration) => add(DurationChanged(duration)),
    );
    _positionSubscription = audioPlayer.onAudioPositionChanged.listen(
      (position) => add(PositionChanged(position)),
    );
    _playerCompleteSubscription = audioPlayer.onPlayerCompletion.listen(
      (_) => add(CompleteSong()),
    );
    _playerErrorSubscription = audioPlayer.onPlayerError.listen(
      (msg) {
        logger.e("Error player $msg");
        add(StopSong());
      },
    );
  }

  @override
  Future<void> close() {
    _durationSubscription.cancel();
    _positionSubscription.cancel();
    _playerCompleteSubscription.cancel();
    _playerErrorSubscription.cancel();
    return super.close();
  }
}
