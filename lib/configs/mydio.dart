// import 'dart:html';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:dio/src/response.dart' as dioResponse;
import 'package:get/get.dart';
import 'package:willmod3/configs/myapp.dart';

class MyDio {
  static const int REQ_GET = 1;
  static const int REQ_POST = 2;
  static const int REQ_PUT = 3;
  static const int REQ_DELETE = 4;
  static const int REQ_POST_NO_AUTH = 5;

  dio.Dio? _dio;

  Future<void> _initialize() async {
    if (_dio == null) {
      _dio = dio.Dio();
      var myApp = Get.put(MyApp());

      var url = await myApp.getApiUrl();

      _dio!.options
        ..baseUrl = url
        ..connectTimeout = 15000
        ..receiveTimeout = 15000
        ..validateStatus = (int? status) {
          return status != null && status > 0;
        };
    }
  }

  dio.Dio? getDio() {
    return _dio;
  }

  void successLogin(token) {
    if (_dio == null) {
      _initialize();
    }

    _dio!.options.headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
  }

  Future<dioResponse.Response> request(int reqType, String path,
      {Object? body,
      Map<String, dynamic>? mapQuery,
      dio.Options? options,
      Map<String, dynamic>? formBody}) async {
    MyApp myApp = Get.put(MyApp());
    if (reqType != REQ_POST_NO_AUTH && myApp.appUser == null) _logout();

    if (_dio == null) await _initialize();

    _dio!.options.headers[HttpHeaders.contentTypeHeader] = 'application/json';

    var newBody = body;
    if (formBody != null) {
      newBody = dio.FormData.fromMap(formBody);
      _dio!.options.headers[HttpHeaders.contentTypeHeader] =
          'multipart/form-data';
    }

    late var response;
    switch (reqType) {
      case REQ_GET:
        {
          response = await _dio!
              .get(path, queryParameters: mapQuery, options: options);
        }
        break;
      case REQ_POST:
        {
          response = await _dio!.post(path,
              data: newBody, queryParameters: mapQuery, options: options);
        }
        break;
      case REQ_POST_NO_AUTH:
        {
          response = await _dio!.post(path,
              data: newBody, queryParameters: mapQuery, options: options);
        }
        break;
      case REQ_PUT:
        {
          response = await _dio!.put(path,
              data: newBody, queryParameters: mapQuery, options: options);
        }
        break;
      case REQ_DELETE:
        {
          response = await _dio!.delete(path,
              data: newBody, queryParameters: mapQuery, options: options);
        }
        break;
    }

    if (reqType != REQ_POST_NO_AUTH && response.statusCode == 401) _logout();

    return response;
  }

  void _logout() {
    if (_dio == null) {
      _initialize();
    }
    _dio!.options.headers.remove(HttpHeaders.authorizationHeader);

    MyApp myApp = Get.put(MyApp());
    myApp.appUser = null;
  }
}
