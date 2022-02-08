part of 'services.dart';

class DailyService {
  static Future<ApiReturnValue<List<DailyModel>>> getDaily(String date,
      {http.Client? client}) async {
    try {
      client ??= http.Client();

      String uri = baseUrl + 'daily?date=$date';
      Uri url = Uri.parse(uri);

      var response = await client.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': token
      });

      if (response.statusCode != 200) {
        var data = jsonDecode(response.body);
        String message = data['meta']['message'];
        return ApiReturnValue(value: [], message: message);
      }

      var data = jsonDecode(response.body);

      List<DailyModel> value = (data['data'] as Iterable)
          .map((e) => DailyModel.fromJson(e))
          .toList();

      return ApiReturnValue(value: value, message: 'berhasil');
    } catch (e) {
      return ApiReturnValue(value: [], message: 'ada masalah pada server');
    }
  }

  static Future<ApiReturnValue<bool>> submit({
    required String task,
    required DateTime date,
    required bool isAdd,
    String? time,
    int? id,
    String? tag,
    http.Client? client,
  }) async {
    try {
      client ??= http.Client();
      String url = baseUrl + 'daily${id == null ? "" : "/edit/$id"}';
      Uri uri = Uri.parse(url);

      Map<String, dynamic> body = {
        'task': task.toUpperCase(),
        'time': isAdd ? null : time,
        'date': DateFormat('y-MM-dd').format(date),
        'isplan': !isAdd,
        'tag': isAdd ? null : tag,
      };

      var response = await client.post(
        uri,
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
      );

      if (response.statusCode != 200) {
        var data = jsonDecode(response.body);
        String message = data['meta']['message'];
        return ApiReturnValue(value: false, message: message);
      }
      var data = jsonDecode(response.body);
      String message = data['meta']['message'];
      return ApiReturnValue(value: true, message: message);
    } catch (e) {
      return ApiReturnValue(value: false, message: e.toString());
    }
  }

  static Future<ApiReturnValue<bool>> delete({
    required int id,
    http.Client? client,
  }) async {
    try {
      client ??= http.Client();
      String url = baseUrl + 'daily/delete/$id';
      Uri uri = Uri.parse(url);

      var response = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      });

      if (response.statusCode != 200) {
        var data = jsonDecode(response.body);
        String message = data['meta']['message'];
        return ApiReturnValue(value: false, message: message);
      }

      var data = jsonDecode(response.body);
      String message = data['meta']['message'];
      return ApiReturnValue(value: true, message: message);
    } catch (e) {
      return ApiReturnValue(value: false, message: e.toString());
    }
  }

  static Future<ApiReturnValue<bool>> change(
      {required int id, http.Client? client}) async {
    try {
      client ??= http.Client();
      String url = baseUrl + 'daily/change/$id';
      Uri uri = Uri.parse(url);

      var response = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      });

      if (response.statusCode != 200) {
        var data = jsonDecode(response.body);
        String message = data['meta']['message'];
        return ApiReturnValue(value: false, message: message);
      }

      var data = jsonDecode(response.body);
      String message = data['meta']['message'];
      return ApiReturnValue(value: true, message: message);
    } catch (e) {
      return ApiReturnValue(value: false, message: e.toString());
    }
  }
}
