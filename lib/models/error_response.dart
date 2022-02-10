import 'package:json_annotation/json_annotation.dart';

part 'error_response.g.dart';

///ErrorResponse need to follow server error response
@JsonSerializable()
class ErrorResponse implements Exception {
  String? errorMessage;

  ErrorResponse();

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => _$ErrorResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);

  @override
  String toString() {
    return "errorMessage: $errorMessage";
  }
}