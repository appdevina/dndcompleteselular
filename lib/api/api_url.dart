import 'package:shared_preferences/shared_preferences.dart';

class ApiUrl {
  static const String baseUrl = "http://dnd.completeselular.com/api/";

  static Map<String, String> defaultHeader = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };

  static Future<Map<String, String>> headerWithToken() async {
    final pref = await SharedPreferences.getInstance();

    var header = defaultHeader;

    header.addAll({'Authorization': 'Bearer ${pref.getString('token') ?? ''}'});

    return header;
  }
}
