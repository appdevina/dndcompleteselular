part of 'services.dart';

class DailyService {
  static Future<ApiReturnValue<List<DailyModel>>> getDaily(String date,
      {http.Client? client}) async {
    await Future.delayed(const Duration(milliseconds: 1500));

    if (date == '29-11-2021') {
      return ApiReturnValue(value: mockDaily);
    } else {
      return ApiReturnValue(value: []);
    }
    // try {
    //   client ??= http.Client();

    //   String uri = 'daily';
    //   Uri url = Uri.parse(uri);
    //   SharedPreferences pref = await SharedPreferences.getInstance();

    //   var response = await client.get(url, headers: {
    //     'Content-Type': 'application/json',
    //     'Authorization': 'Bearer ${pref.getString('token')}'
    //   });

    //   if (response.statusCode != 200) {
    //     var data = jsonDecode(response.body);
    //     String message = data['meta']['message'];
    //     return ApiReturnValue(value: [], message: message);
    //   }

    //   var data = jsonDecode(response.body);

    //   List<DailyModel> value = (data['data'] as Iterable)
    //       .map((e) => DailyModel.fromJson(e))
    //       .toList();

    //   return ApiReturnValue(value: value, message: 'berhasil');
    // } catch (e) {
    //   return ApiReturnValue(value: [], message: 'ada masalah pada server');
    // }
  }
}
