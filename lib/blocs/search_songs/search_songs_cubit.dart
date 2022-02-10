import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:kuncie_test/models/error_response.dart';
import 'package:kuncie_test/models/song.dart';
import 'package:kuncie_test/repositories/song_repository.dart';
import 'package:meta/meta.dart';

part 'search_songs_state.dart';

class SearchSongsCubit extends Cubit<SearchSongsState> {
  SearchSongsCubit(this.songRepository) : super(SearchSongsInitial());
  final SongRepository songRepository;

  ///search term need properly encoded required by apple
  ///https://affiliate.itunes.apple.com/resources/documentation/itunes-store-web-service-search-api
  ///triggered from submit from [SearchField]
  searchSong(String searchTerm) async {
    try {
      emit(SearchSongsLoading());
      final songs = await songRepository.getSongsByArtistName(Uri.encodeComponent(searchTerm));
      emit(SearchSongsLoaded(searchTerm: searchTerm, songs: songs));
    } on DioError catch (e) {
      if (e.error is ErrorResponse) {
        emit(SearchSongsFailed(e.error.errorMessage));
      } else {
        emit(SearchSongsFailed("Failed to search artist"));
      }
    } catch (e) {
      emit(SearchSongsFailed("Failed to search artist"));
    }
  }
}
