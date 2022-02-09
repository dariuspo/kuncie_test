import 'package:bloc/bloc.dart';
import 'package:kuncie_test/app/app_logger.dart';
import 'package:kuncie_test/models/song.dart';
import 'package:kuncie_test/repositories/song_repository.dart';
import 'package:meta/meta.dart';

part 'search_songs_state.dart';

class SearchSongsCubit extends Cubit<SearchSongsState> {
  SearchSongsCubit(this.songRepository) : super(SearchSongsInitial());
  final SongRepository songRepository;

  searchSong(String searchTerm) async {
    try {
      emit(SearchSongsLoading());
      final songs = await songRepository.getSongsByArtistName(Uri.encodeComponent(searchTerm));
      emit(SearchSongsLoaded(searchTerm: searchTerm, songs: songs));
    } catch (e, st) {
      logger.e(st);
      emit(SearchSongsFailed("Failed to fetch songs"));
    }
  }
}
