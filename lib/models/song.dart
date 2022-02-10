import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'song.g.dart';

///Itunes API Data model
///https://affiliate.itunes.apple.com/resources/documentation/itunes-store-web-service-search-api
@JsonSerializable()
class Song extends Equatable {
  final String? artistName;
  final String? collectionName;
  final String? trackName;
  final String? artworkUrl100;
  final String? previewUrl;
  final int? trackTimeMillis;
  final int? trackId;

  const Song({
    this.artistName,
    this.collectionName,
    this.trackName,
    this.artworkUrl100,
    this.previewUrl,
    this.trackTimeMillis,
    this.trackId,
  });

  factory Song.fromJson(Map<String, dynamic> json) => _$SongFromJson(json);

  Map<String, dynamic> toJson() => _$SongToJson(this);

  @override
  String toString() {
    return "Song: $trackName id: $trackId";
  }

  @override
  List<Object?> get props => [trackName, trackId];
}
