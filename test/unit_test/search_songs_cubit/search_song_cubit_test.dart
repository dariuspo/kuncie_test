
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kuncie_test/blocs/search_songs/search_songs_cubit.dart';
import 'package:kuncie_test/models/song.dart';
import 'package:kuncie_test/repositories/song_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockSongRepository extends Mock
    implements SongRepository {}
class MockSong extends Mock implements Song {}

void main() {
  group('SearchSongCubit', () {
    late SongRepository songRepository;
    late List<Song> songs;

    setUp(() {
      songRepository = MockSongRepository();
      songs = [MockSong(), MockSong()];
      when(
            () => songRepository.getSongsByArtistName(any()),
      ).thenAnswer((_) async => songs);
    });

    test('initial state is correct', () {
      final searchSongCubit = SearchSongsCubit(songRepository);
      expect(searchSongCubit.state, SearchSongsInitial());
    });

    group('fetchSongs', () {
      blocTest<SearchSongsCubit, SearchSongsState>(
        'emits [loading, loaded] when search success',
        build: () => SearchSongsCubit(songRepository),
        act: (cubit) => cubit.searchSong('maroon'),
        expect: () => <SearchSongsState>[
          SearchSongsLoading(),
          SearchSongsLoaded(searchTerm: "maroon", songs: songs),
        ],
      );
      blocTest<SearchSongsCubit, SearchSongsState>(
        'emits [loading, failure] when getWeather throws',
        setUp: () {
          when(
                () => songRepository.getSongsByArtistName(any()),
          ).thenThrow(Exception('Failed'));
        },
        build: () => SearchSongsCubit(songRepository),
        act: (cubit) => cubit.searchSong('maroon'),
        expect: () => <SearchSongsState>[
          SearchSongsLoading(),
          SearchSongsFailed("Failed to search artist"),
        ],
      );
    });
  });
}