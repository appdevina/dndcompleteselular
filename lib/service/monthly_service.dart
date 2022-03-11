part of 'services.dart';

class MonthlyServices {
  static Future<ApiReturnValue<List<MonthlyModel>>> getMonthly(DateTime month,
      {http.Client? client}) async {
    try {
      client ??= http.Client();
      String url =
          baseUrl + 'monthly/?date=${DateFormat("y-MM-dd").format(month)}';
      Uri uri = Uri.parse(url);
      SharedPreferences pref = await SharedPreferences.getInstance();

      var response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
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

      List<MonthlyModel> value = (data['data'] as Iterable)
          .map((e) => MonthlyModel.fromJson(e))
          .toList();

      return ApiReturnValue(value: value, message: message);
    } catch (e) {
      return ApiReturnValue(value: [], message: e.toString());
    }
  }

  static Future<ApiReturnValue<bool>> changeStatus({
    required int id,
    int? value,
    http.Client? client,
  }) async {
    try {
      client ??= http.Client();
      String url = baseUrl + 'monthly/change';
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
          'Authorization': "Bearer ${pref.getString('token')}",
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

  static Future<ApiReturnValue<bool>> submit({
    required bool isUpdate,
    required bool extraTask,
    required String task,
    required DateTime date,
    required bool isResult,
    String? resultValue,
    int? id,
    http.Client? client,
  }) async {
    try {
      client ??= http.Client();

      String url = baseUrl + (isUpdate ? 'monthly/edit/$id' : 'monthly');
      Uri uri = Uri.parse(url);
      Map<String, dynamic> body = {
        'is_add': extraTask,
        'task': task,
        'date': DateFormat('y-MM-dd').format(date),
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

  static Future<ApiReturnValue<bool>> delete(
      {required int id, http.Client? client}) async {
    try {
      client ??= http.Client();
      String url = baseUrl + 'monthly/delete/$id';
      Uri uri = Uri.parse(url);
      SharedPreferences pref = await SharedPreferences.getInstance();

      var response = await client.get(
        uri,
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
