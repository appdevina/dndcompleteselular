part of 'services.dart';

class ResultService {
  static Future<ApiReturnValue?> result(
      {required int week, required int year, http.Client? client}) async {
    try {
      client ??= http.Client();
      String url = baseUrl + 'result/?week=$week&year=$year';
      Uri uri = Uri.parse(url);
      SharedPreferences pref = await SharedPreferences.getInstance();

      var response = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${pref.getString('token')}',
      });

      if (response.statusCode != 200) {
        var data = jsonDecode(response.body);
        String message = data['meta']['message'];
        return ApiReturnValue(value: null, message: message);
      }

      var data = jsonDecode(response.body);
      String message = data['meta']['message'];
      var value = data['data'];
      return ApiReturnValue(value: value, message: message);
    } catch (e) {
      return ApiReturnValue(value: null, message: e.toString());
    }
  }

  static Future<ApiReturnValue?> resultTeam(
      {required int id,
      required int week,
      required int year,
      http.Client? client}) async {
    try {
      client ??= http.Client();
      String url = baseUrl + 'result/$id/?week=$week&year=$year';
      Uri uri = Uri.parse(url);
      SharedPreferences pref = await SharedPreferences.getInstance();

      var response = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${pref.getString('token')}',
      });

      if (response.statusCode != 200) {
        var data = jsonDecode(response.body);
        String message = data['meta']['message'];
        return ApiReturnValue(value: null, message: message);
      }

      var data = jsonDecode(response.body);
      String message = data['meta']['message'];
      var value = data['data'];
      return ApiReturnValue(value: value, message: message);
    } catch (e) {
      return ApiReturnValue(value: null, message: e.toString());
    }
  }
}
