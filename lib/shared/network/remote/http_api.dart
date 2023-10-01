import 'dart:convert';
import 'dart:io';

import 'package:cv_analyzer/shared/network/end_points.dart';
import 'package:http/http.dart' as http;

import 'package:http/http.dart';

class HttpApi {
  static Future<Response> postData({
    required var url,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {

    final http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    return response;
  }

  static Future<Response> getData({
    required var url,
    required var token,
  }) async {
    final http.Response response = await http.get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: '$baseToken $token',
        // HttpHeaders.contentTypeHeader: 'application/json',
      }
    );
    return response;
  }


  static Future<Response> deleteJob({
    required var url,
    required var token,
    Map<String, dynamic>? body,
  }) async {
    final http.Response response = await http.delete(
        url,
        headers: {
          HttpHeaders.authorizationHeader: '$baseToken $token',
        },
        body:body,
    );
    return response;
  }

}
