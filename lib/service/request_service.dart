part of 'services.dart';

class RequestService {
  static Future<ApiReturnValue<List<RequestModel>>> fetch() async {
    final response = await ApiService().get(
      '${ApiUrl.baseUrl}/request',
      headers: await ApiUrl.headerWithToken(),
    );

    if (response.value == null) {
      return ApiReturnValue(value: null, message: response.message);
    }

    List<RequestModel> value = (response.value['data'] as Iterable)
        .map((e) => RequestModel.fromJson(e))
        .toList();
    return ApiReturnValue(value: value, message: "berhasil");
  }

  static Future<ApiReturnValue<bool>> submit({
    required String? type,
    required List<Object?> exsitingTaskId,
    List<DailyModel>? dailyReplace,
    List<WeeklyModel>? weeklyReplace,
    List<MonthlyModel>? monthlyReplace,
  }) async {
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

    final response = await ApiService().post(
      '${ApiUrl.baseUrl}/request',
      headers: await ApiUrl.headerWithToken(),
      body: jsonDecode(body),
    );

    return ApiReturnValue(
        value: response.value != null, message: response.message);
  }

  static Future<ApiReturnValue<List<RequestModel>>> getRequest() async {
    final response = await ApiService().get(
      '${ApiUrl.baseUrl}/request/approve',
      headers: await ApiUrl.headerWithToken(),
    );

    if (response.value == null) {
      return ApiReturnValue(value: null, message: response.message);
    }

    List<RequestModel> value = (response.value['data'] as Iterable)
        .map((e) => RequestModel.fromJson(e))
        .toList();
    return ApiReturnValue(value: value, message: "berhasil");
  }

  static Future<ApiReturnValue<bool>> approve({
    required int id,
  }) async {
    final response = await ApiService().post(
      '${ApiUrl.baseUrl}/request/approve',
      headers: await ApiUrl.headerWithToken(),
      body: {
        'id': id,
      },
    );

    return ApiReturnValue(
        value: response.value != null, message: response.message);
  }

  static Future<ApiReturnValue<bool>> reject({
    required int id,
  }) async {
    final response = await ApiService().post(
      '${ApiUrl.baseUrl}/request/reject',
      headers: await ApiUrl.headerWithToken(),
      body: {
        'id': id,
      },
    );

    return ApiReturnValue(
        value: response.value != null, message: response.message);
  }

  static Future<ApiReturnValue<bool>> cancel({
    required int id,
  }) async {
    final response = await ApiService().post(
      '${ApiUrl.baseUrl}/request/cancel',
      headers: await ApiUrl.headerWithToken(),
      body: {
        'id': id,
      },
    );

    return ApiReturnValue(
        value: response.value != null, message: response.message);
  }
}
