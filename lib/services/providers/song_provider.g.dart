// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_provider.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _SongProvider implements SongProvider {
  _SongProvider(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<List<Song>> searchSong(
      {entity = "song",
      media = "music",
      attribute = "artistTerm",
      required term}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'entity': entity,
      r'media': media,
      r'attribute': attribute,
      r'term': term
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(_setStreamType<List<Song>>(
        Options(method: 'GET', headers: _headers, extra: _extra)
            .compose(_dio.options, '',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = _result.data!
        .map((dynamic i) => Song.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
