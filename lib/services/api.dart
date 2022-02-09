import 'dart:io';
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:developer' as developer;
import 'dart:convert';

import 'package:kuncie_test/app/app_logger.dart';
import 'package:kuncie_test/models/error_response.dart';

/// A class to handle DIO API request
class Api {
  static final Api _instance = Api._internal();
  final Dio _dio = Dio();
  Api._internal() {
    logger.i("Initializing API client...");
    _dio.interceptors.add(MyInterceptor());
  }
  static Dio get client => _instance._dio;
}

/// Interceptor to print requests, responses, and errors
class MyInterceptor extends Interceptor {
  //final _repository = UserRepository();
  ///to format data response
  final JsonEncoder _encoder = const JsonEncoder.withIndent(' ');

  _log(String url, [dynamic data]) {
    if (data is Map) {
      String prettyPrint = _encoder.convert(data);
      developer.log(
        url,
        name: "fantasy.api",
        error: prettyPrint,
      );
    }
  }

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.queryParameters.isNotEmpty) {
      final queryParameters = options.queryParameters.map((key, value) {
        if (value is! Iterable) {
          value = value.toString();
        }
        return MapEntry(key, value);
      });
      final uri = Uri(path: options.path, queryParameters: queryParameters);
      options.path = uri.toString();
      options.queryParameters = {};
    }

    if (options.method != 'GET') {
      if (options.data is Map) {
        _log(
          "=> ${options.method} ${options.uri.toString()}",
          options.data,
        );
      }
    } else {
      logger.e(
        "=> ${options.method} ${options.uri.toString()}",
      );
    }
    ///used if API request is using access token
    /*String? accessToken = await _repository.getAccessToken();
    if (accessToken != null) {
      options.headers['Authorization'] = "Bearer $accessToken";
    }*/
    super.onRequest(options, handler);
  }

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) {
    Map result = jsonDecode(response.data);
    if (result.containsKey("results")) {
      response.data = result["results"];
      _log(
        "<= ${response.requestOptions.method} ${response.requestOptions.uri.toString()}",
        response.data,
      );
    }
    super.onResponse(response, handler);
  }

  @override
  onError(DioError err, ErrorInterceptorHandler handler) {
    var error = err.error;
    if (err.response?.data is Map) {
      Map<String, dynamic> data = err.response!.data;
      logger.e(data);
      if (data.containsKey("errors")) {
        Map<String, dynamic> errors = data['errors'];
        throw ErrorResponse.fromJson(errors);
      }
    } else if (error is SocketException) {
      logger.e('SocketException');
      Map<String, dynamic> errors = {
        'message': 'No internet connection'
      };
      throw ErrorResponse.fromJson(errors);
    } else if(error is TypeError){
      logger.e('Type Error');
      Map<String, dynamic> errors = {
        'message': 'Type error $error'
      };
      throw ErrorResponse.fromJson(errors);
    }
    super.onError(error, handler);
  }
}
