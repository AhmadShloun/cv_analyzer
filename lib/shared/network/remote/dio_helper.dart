import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://cvsanalyzer.pythonanywhere.com/api',
        receiveDataWhenStatusError: true,
      ),
    );
    (dio!.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }


  static Future<Response> getData({
    @required String? url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio!.options.headers = {
      'Accept': 'application/json',
      'Authorization': token ?? '',
    };
    return await dio!.get(
      url!,
      queryParameters: query,
    );
  }


  static Future<Response> postData({
    required String url, //path /login
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,


  }) async {
    if (kDebugMode) {
      print(data);
    }
    dio!.options.headers = {
      'Content-Type': 'application/json',

    };
    

    return await dio!.post(
      url,
      data: data
    );
  }


  static Future<Response> putData({
    @required String? url, //path /login
    @required Map<String, dynamic>? data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json',
    };
    return await dio!.put(
      url!,
      queryParameters: query,
      data: data,
    );
  }

}
