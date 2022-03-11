part of 'services.dart';

class UserServices {
  static Future<ApiReturnValue<bool>> check({http.Client? client}) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      if (pref.getString('token') == null) {
        return ApiReturnValue(value: false, message: 'Silahkan login');
      }
      client ??= http.Client();

      String url = baseUrl + 'user';
      Uri uri = Uri.parse(url);

      var response = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${pref.getString('token')}'
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

  static Future<ApiReturnValue<bool>> signIn(String username, String password,
      {http.Client? client}) async {
    try {
      client ??= http.Client();

      String url = baseUrl + 'user/login';
      Uri uri = Uri.parse(url);
      final status = await OneSignal.shared.getDeviceState();
      final String? osUserID = status?.userId;
      if (osUserID == null) {
        return ApiReturnValue(
            value: false, message: 'Close aplikasi lalu buka kembali');
      }
      var response = await client.post(
        uri,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(
          <String, String>{
            'username': username,
            'password': password,
            'id_notif': osUserID,
          },
        ),
      );

      if (response.statusCode != 200) {
        var data = jsonDecode(response.body);
        String message = data['meta']['message'];
        return ApiReturnValue(value: false, message: message);
      }

      var data = jsonDecode(response.body);

      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString(
        'token',
        data['data']['access_token'].toString(),
      );
      String message = data['meta']['message'];

      return ApiReturnValue(value: true, message: message);
    } catch (e) {
      return ApiReturnValue(value: false, message: e.toString());
    }
  }

  static Future<ApiReturnValue<UserModel>> getDetailUser(
      {http.Client? client}) async {
    try {
      client ??= http.Client();

      String url = baseUrl + 'user';
      Uri uri = Uri.parse(url);
      SharedPreferences pref = await SharedPreferences.getInstance();

      var response = await client.get(uri, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${pref.getString('token')}'
      });

      if (response.statusCode != 200) {
        var data = jsonDecode(response.body);
        String message = data['meta']['message'];
        return ApiReturnValue(value: const UserModel(), message: message);
      }

      var data = jsonDecode(response.body);
      String message = data['meta']['message'];
      UserModel value = UserModel.fromJson(data['data']);

      return ApiReturnValue(value: value, message: message);
    } catch (e) {
      return ApiReturnValue(value: const UserModel(), message: e.toString());
    }
  }

  static Future<ApiReturnValue<List<UserModel>>> tag(
      {http.Client? client}) async {
    try {
      client ??= http.Client();
      String url = baseUrl + 'user/tag';
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
      String message = data['meta']['message'];
      List<UserModel> value =
          (data['data'] as Iterable).map((e) => UserModel.fromJson(e)).toList();
      return ApiReturnValue(value: value, message: message);
    } catch (e) {
      return ApiReturnValue(value: [], message: e.toString());
    }
  }

  static Future<ApiReturnValue<bool>> logout({http.Client? client}) async {
    try {
      client ??= http.Client();

      String url = baseUrl + 'user/logout';
      Uri uri = Uri.parse(url);
      SharedPreferences pref = await SharedPreferences.getInstance();

      var response = await client.post(uri, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${pref.getString('token')}'
      });

      if (response.statusCode != 200) {
        var data = jsonDecode(response.body);
        String message = data['meta']['message'];
        return ApiReturnValue(value: false, message: message);
      }

      var data = jsonDecode(response.body);
      String message = data['meta']['message'];
      await pref.clear();
      return ApiReturnValue(value: true, message: message);
    } catch (e) {
      return ApiReturnValue(value: false, message: e.toString());
    }
  }

  static Future<ApiReturnValue<bool>> profilepicture(
    File pictureFile, {
    http.MultipartRequest? client,
  }) async {
    try {
      String url = baseUrl + 'user/changepicture';
      Uri uri = Uri.parse(url);
      SharedPreferences pref = await SharedPreferences.getInstance();
      var multiPartFile =
          await http.MultipartFile.fromPath('image', pictureFile.path);
      client ??= http.MultipartRequest("POST", uri)
        ..headers["Content-Type"] = "application/json"
        ..headers["Authorization"] = "Bearer ${pref.getString('token')}"
        ..files.add(multiPartFile);

      var response = await client.send();

      if (response.statusCode != 200) {
        return ApiReturnValue(value: false, message: 'Gagal upload');
      }

      return ApiReturnValue(value: true, message: 'berhasil upload');
    } catch (e) {
      return ApiReturnValue(value: false, message: e.toString());
    }
  }
}
