part of 'services.dart';

class RequestService {
  static Future<ApiReturnValue<List<RequestModel>>> fetch(
      {http.Client? client}) async {
    try {
      client ??= http.Client();
      String url = baseUrl + 'request';
      Uri uri = Uri.parse(url);
      SharedPreferences pref = await SharedPreferences.getInstance();

      var response = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${pref.getString('token')}',
      });

      if (response.statusCode != 200) {
        var data = jsonDecode(response.body);
        String message = data['meta']['message'];
        return ApiReturnValue(value: [], message: message);
      }
      var data = jsonDecode(response.body);
      List<RequestModel> value = (data['data'] as Iterable)
          .map((e) => RequestModel.fromJson(e))
          .toList();
      return ApiReturnValue(value: value, message: "berhasil");
    } catch (e) {
      return ApiReturnValue(value: [], message: e.toString());
    }
  }

  static Future<ApiReturnValue<bool>> submit({
    required String? type,
    required List<Object?> exsitingTaskId,
    List<DailyModel>? dailyReplace,
    List<WeeklyModel>? weeklyReplace,
    List<MonthlyModel>? monthlyReplace,
    http.Client? client,
  }) async {
    try {
      client ??= http.Client();
      String url = baseUrl + 'request';
      Uri uri = Uri.parse(url);
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? body;
      List taskId = exsitingTaskId.map((e) => e).toList();
      switch (type) {
        case 'Daily':
          List<Map<String, dynamic>> dReplace =
              dailyReplace!.map((e) => e.toJson()).toList();

          body = jsonEncode(
            {
              'type': type,
              'dailye': taskId,
              'dailyr': dReplace,
            },
          );

          break;
        case 'Weekly':
          List<Map<String, dynamic>> wReplace =
              weeklyReplace!.map((e) => e.toJson()).toList();
          body = jsonEncode(
            {
              'type': type,
              'weeklye': taskId,
              'weeklyr': wReplace,
            },
          );
          break;
        default:
          List<Map<String, dynamic>> mReplace =
              monthlyReplace!.map((e) => e.toJson()).toList();
          body = jsonEncode(
            {
              'type': type,
              'monthlye': taskId,
              'monthlyr': mReplace,
            },
          );
      }

      var response = await client.post(uri,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${pref.getString('token')}',
          },
          body: body);

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

  static Future<ApiReturnValue<List<RequestModel>>> getRequest(
      {http.Client? client}) async {
    try {
      client ??= http.Client();
      String url = baseUrl + 'request/approve';
      Uri uri = Uri.parse(url);
      SharedPreferences pref = await SharedPreferences.getInstance();

      var response = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${pref.getString('token')}',
      });

      if (response.statusCode != 200) {
        var data = jsonDecode(response.body);
        String message = data['meta']['message'];
        return ApiReturnValue(value: [], message: message);
      }
      var data = jsonDecode(response.body);
      List<RequestModel> value = (data['data'] as Iterable)
          .map((e) => RequestModel.fromJson(e))
          .toList();
      return ApiReturnValue(value: value, message: "berhasil");
    } catch (e) {
      return ApiReturnValue(value: [], message: e.toString());
    }
  }

  static Future<ApiReturnValue<bool>> approve(
      {required int id, http.Client? client}) async {
    try {
      client ??= http.Client();
      String url = baseUrl + 'request/approve';
      Uri uri = Uri.parse(url);
      SharedPreferences pref = await SharedPreferences.getInstance();

      var response = await client.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${pref.getString('token')}',
        },
        body: jsonEncode(
          {
            'id': id,
          },
        ),
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

  static Future<ApiReturnValue<bool>> reject(
      {required int id, http.Client? client}) async {
    try {
      client ??= http.Client();
      String url = baseUrl + 'request/reject';
      Uri uri = Uri.parse(url);
      SharedPreferences pref = await SharedPreferences.getInstance();

      var response = await client.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${pref.getString('token')}',
        },
        body: jsonEncode(
          {
            'id': id,
          },
        ),
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

  static Future<ApiReturnValue<bool>> cancel(
      {required int id, http.Client? client}) async {
    try {
      client ??= http.Client();
      String url = baseUrl + 'request/cancel';
      Uri uri = Uri.parse(url);
      SharedPreferences pref = await SharedPreferences.getInstance();

      var response = await client.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${pref.getString('token')}',
        },
        body: jsonEncode(
          {
            'id': id,
          },
        ),
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
}
