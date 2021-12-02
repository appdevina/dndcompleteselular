part of 'services.dart';

class UserServices {
  static Future<ApiReturnValue<bool>> check(String token,
      {http.Client? client}) async {
    try {
      client ??= http.Client();

      String url = baseUrl + 'user';
      Uri uri = Uri.parse(url);

      var response = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode != 200) {
        var data = jsonDecode(response.body);
        String message = data['meta']['message'];
        return ApiReturnValue(value: false, message: message);
      }

      return ApiReturnValue(value: true);
    } catch (e) {
      return ApiReturnValue(value: false, message: e.toString());
    }
  }

  static Future<ApiReturnValue<UserModel>> signIn(
      String username, String password,
      {http.Client? client}) async {
    try {
      client ??= http.Client();

      String url = baseUrl + 'user/login';
      Uri uri = Uri.parse(url);
      var response = await client.post(
        uri,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(
          <String, String>{
            'username': username,
            'password': password,
          },
        ),
      );

      if (response.statusCode != 200) {
        var data = jsonDecode(response.body);
        String message = data['meta']['message'];
        return ApiReturnValue(message: message);
      }
      var data = jsonDecode(response.body);

      UserModel value = UserModel.fromJson(data['data']['user']);

      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString(
        'username',
        username,
      );
      pref.setString(
        'token',
        data['data']['access_token'].toString(),
      );

      return ApiReturnValue(value: value);
    } catch (e) {
      return ApiReturnValue(message: e.toString());
    }
  }

  static Future<ApiReturnValue<UserModel>> getDetailUser() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    return ApiReturnValue(value: mockUser);
  }
}
