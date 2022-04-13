part of 'services.dart';

class WeeklyService {
  static Future<ApiReturnValue<List<WeeklyModel>>> getWeekly(
      {required int week, required int year, http.Client? client}) async {
    try {
      client ??= http.Client();
      String url = baseUrl + 'weekly?week=$week&year=$year';
      Uri uri = Uri.parse(url);
      SharedPreferences pref = await SharedPreferences.getInstance();

      var response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${pref.getString('token')}',
        },
      );

      if (response.statusCode != 200) {
        var data = jsonDecode(response.body);
        String message = data['meta']['message'];
        return ApiReturnValue(value: [], message: message);
      }
      var data = jsonDecode(response.body);
      String message = data['meta']['message'];

      List<WeeklyModel> value = (data['data'] as Iterable)
          .map(((e) => WeeklyModel.fromJson(e)))
          .toList();

      return ApiReturnValue(value: value, message: message);
    } catch (e) {
      return ApiReturnValue(value: [], message: e.toString());
    }
  }

  static Future<ApiReturnValue<bool>> submit({
    required bool isUpdate,
    required bool extraTask,
    required String task,
    required int week,
    required int year,
    required bool isResult,
    String? resultValue,
    int? id,
    http.Client? client,
  }) async {
    try {
      client ??= http.Client();

      String url = baseUrl + (isUpdate ? 'weekly/edit/$id' : 'weekly');
      Uri uri = Uri.parse(url);
      Map<String, dynamic> body = {
        'is_add': extraTask,
        'task': task,
        'week': week,
        'year': year,
        'tipe': isResult ? 'RESULT' : 'NON',
        'value_plan': isResult ? resultValue : null,
        'status_non': isResult ? null : false,
        'status_result': isResult ? false : null,
        'value_actual': isResult ? 0 : null,
      };
      SharedPreferences pref = await SharedPreferences.getInstance();

      var response = await client.post(
        uri,
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${pref.getString('token')}',
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

  static Future<ApiReturnValue<bool>> changeStatus({
    required int id,
    int? value,
    http.Client? client,
  }) async {
    try {
      client ??= http.Client();
      String url = baseUrl + 'weekly/change';
      Uri uri = Uri.parse(url);
      Map<String, dynamic> body = {
        'id': id,
        'value': value,
      };
      SharedPreferences pref = await SharedPreferences.getInstance();

      var response = await client.post(
        uri,
        body: jsonEncode(body),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${pref.getString('token')}',
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

  static Future<ApiReturnValue<bool>> delete(
      {required int id, http.Client? client}) async {
    try {
      client ??= http.Client();
      String url = baseUrl + 'weekly/delete/$id';
      Uri uri = Uri.parse(url);
      SharedPreferences pref = await SharedPreferences.getInstance();

      var response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${pref.getString('token')}',
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

  static Future<ApiReturnValue<String>> getDate(
      {required int week, required int year, http.Client? client}) async {
    try {
      client ??= http.Client();
      String url = baseUrl + 'date?week=$week&year=$year';
      Uri uri = Uri.parse(url);

      var response = await client.get(uri);

      if (response.statusCode != 200) {
        return ApiReturnValue(value: "error");
      }
      var data = jsonDecode(response.body);

      String tanggal =
          "${DateFormat('d MMM').format(DateTime.fromMillisecondsSinceEpoch(data['data']['monday']))} - ${DateFormat('d MMM').format(DateTime.fromMillisecondsSinceEpoch(data['data']['sunday']))}";
      return ApiReturnValue(value: tanggal);
    } catch (e) {
      return ApiReturnValue(value: 'error');
    }
  }

  static Future<ApiReturnValue<bool>> copy(
      {required int fromWeek,
      required int fromYear,
      required int toWeek,
      required int toYear,
      http.Client? client}) async {
    try {
      client ??= http.Client();
      String url = baseUrl + 'weekly/copy';
      Uri uri = Uri.parse(url);
      SharedPreferences pref = await SharedPreferences.getInstance();

      var response = await client.post(
        uri,
        body: jsonEncode({
          'fromweek': fromWeek,
          'fromyear': fromYear,
          'toweek': toWeek,
          'toyear': toYear,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${pref.getString('token')}',
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
}
