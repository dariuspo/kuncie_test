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

/// Interceptor to handle requests, responses, and errors
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

    //print request body if this is POST/PUT/Patch Request
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
    super.onRequest(options, handler);
  }

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) {
    //because the data from apple is String need to decode first
    Map result = jsonDecode(response.data);
    //results here is object key from the response
    if (result.containsKey("results")) {
      response.data = result["results"];
      _log(
        "<= ${response.requestOptions.method} ${response.requestOptions.uri.toString()}",
        response.data,
      );
    }
    super.onResponse(response, handler);
  }

  ///Error response from server need to be converted to [ErrorResponse]
  @override
  onError(DioError err, ErrorInterceptorHandler handler) {
    var error = err.error;
    logger.e("onError: $error data: ${err.response?.data}");
    if(err.response?.data is String){
      Map<String, dynamic> data = jsonDecode(err.response!.data);
      throw ErrorResponse.fromJson(data);
    }
    if (err.response?.data is Map) {
      Map<String, dynamic> data = err.response!.data;
      if (data.containsKey("errors")) {
        Map<String, dynamic> errors = data['errors'];
        throw ErrorResponse.fromJson(errors);
      }
    } else if (error is SocketException) {
      Map<String, dynamic> errors = {
        'message': 'No internet connection'
      };
      throw ErrorResponse.fromJson(errors);
    } else if(error is TypeError){
      Map<String, dynamic> errors = {
        'message': 'Type error $error'
      };
      throw ErrorResponse.fromJson(errors);
    }
    super.onError(error, handler);
  }
}
