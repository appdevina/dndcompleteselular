import 'package:todolist_complete/model/models.dart';

abstract class BaseApiServices {
  Future<ApiReturnValue> get(String url, {Map<String, String>? headers});
  Future<ApiReturnValue> post(
    String url, {
    Map<String, String>? headers,
    Map<String, ApiReturnValue>? body,
  });
  Future<ApiReturnValue> patch(
    String url, {
    Map<String, String>? headers,
    Map<String, ApiReturnValue>? body,
  });
  Future<ApiReturnValue> delete(String url, {Map<String, String>? headers});
}
