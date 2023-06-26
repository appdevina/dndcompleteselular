import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../model/models.dart';
import 'base_api_service.dart';

class ApiService extends BaseApiServices {
  @override
  Future<ApiReturnValue> get(String url, {Map<String, String>? headers}) async {
    dynamic responseJson;
    try {
      final response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 10));
      responseJson = returnReponse(response);
    } on SocketException {
      return ApiReturnValue<dynamic>(
        value: null,
        message: "Error: No internet connection",
      );
    } catch (e) {
      return ApiReturnValue(value: null, message: e.toString());
    }

    return responseJson;
  }

  @override
  Future<ApiReturnValue> delete(String url,
      {Map<String, String>? headers}) async {
    dynamic responseJson;
    try {
      final response = await http
          .delete(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 10));
      responseJson = returnReponse(response);
    } on SocketException {
      return ApiReturnValue<dynamic>(
        value: null,
        message: "Error: No internet connection",
      );
    } catch (e) {
      return ApiReturnValue(value: null, message: e.toString());
    }

    return responseJson;
  }

  @override
  Future<ApiReturnValue> post(String url,
      {Map<String, String>? headers, Map<String, dynamic>? body}) async {
    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url), headers: headers, body: jsonEncode(body))
          .timeout(const Duration(seconds: 10));
      responseJson = returnReponse(response);
    } on SocketException {
      return ApiReturnValue<dynamic>(
        value: null,
        message: "Error: No internet connection",
      );
    } catch (e) {
      return ApiReturnValue(value: null, message: e.toString());
    }

    return responseJson;
  }

  @override
  Future<ApiReturnValue> patch(String url,
      {Map<String, String>? headers, Map<String, dynamic>? body}) async {
    dynamic responseJson;
    try {
      final response = await http
          .patch(Uri.parse(url), headers: headers, body: jsonEncode(body))
          .timeout(const Duration(seconds: 10));
      responseJson = returnReponse(response);
    } on SocketException {
      return ApiReturnValue<dynamic>(
        value: null,
        message: "Error: No internet connection",
      );
    } catch (e) {
      return ApiReturnValue(value: null, message: e.toString());
    }

    return responseJson;
  }

  ApiReturnValue returnReponse(http.Response response) {
    final json = jsonDecode(response.body);
    String? message = json['meta']['message'];
    if (response.statusCode != 200) {
      return ApiReturnValue(value: null, message: message ?? 'Unknown Error');
    }
    return ApiReturnValue(value: json, message: message);
  }
}
