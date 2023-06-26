part of 'services.dart';

class WeeklyService {
  static Future<ApiReturnValue<List<WeeklyModel>>> getWeekly({
    required int week,
    required int year,
  }) async {
    final response = await ApiService().get(
      '${ApiUrl.baseUrl}/weekly?week=$week&year=$year',
      headers: await ApiUrl.headerWithToken(),
    );

    if (response.value == null) {
      return ApiReturnValue(value: null, message: response.message);
    }

    List<WeeklyModel> value = (response.value['data'] as Iterable)
        .map(((e) => WeeklyModel.fromJson(e)))
        .toList();

    return ApiReturnValue(value: value, message: response.message);
  }

  static Future<ApiReturnValue<bool>> submit({
    required WeeklyRequestModel weeklyRequestModel,
  }) async {
    final response = await ApiService().post(
      '${ApiUrl.baseUrl}/weekly/${weeklyRequestModel.id == null ? "" : "edit/${weeklyRequestModel.id}"}',
      headers: await ApiUrl.headerWithToken(),
      body: weeklyRequestModel.toJson(),
    );

    return ApiReturnValue(
        value: response.value != null, message: response.message);
  }

  static Future<ApiReturnValue<bool>> changeStatus({
    required int id,
    int? value,
  }) async {
    final response = await ApiService().post('${ApiUrl.baseUrl}/weekly/change',
        headers: await ApiUrl.headerWithToken(),
        body: {
          'id': id,
          'value': value,
        });

    return ApiReturnValue(
        value: response.value != null, message: response.message);
  }

  static Future<ApiReturnValue<bool>> delete({
    required int id,
  }) async {
    final response = await ApiService().get(
      '${ApiUrl.baseUrl}/weekly/delete/$id',
      headers: await ApiUrl.headerWithToken(),
    );

    return ApiReturnValue(
        value: response.value != null, message: response.message);
  }

  static Future<ApiReturnValue<String>> getDate({
    required int week,
    required int year,
  }) async {
    try {
      final response = await ApiService().get(
        '${ApiUrl.baseUrl}/date?week=$week&year=$year',
        headers: await ApiUrl.headerWithToken(),
      );

      if (response.value == null) {
        return ApiReturnValue(value: null, message: response.message);
      }

      String tanggal =
          "${DateFormat('d MMM').format(DateTime.fromMillisecondsSinceEpoch(response.value['data']['monday']))} - ${DateFormat('d MMM').format(DateTime.fromMillisecondsSinceEpoch(response.value['data']['sunday']))}";
      return ApiReturnValue(value: tanggal);
    } catch (e) {
      return ApiReturnValue(value: 'error');
    }
  }

  static Future<ApiReturnValue<bool>> copy({
    required int fromWeek,
    required int fromYear,
    required int toWeek,
    required int toYear,
  }) async {
    final response = await ApiService().post('${ApiUrl.baseUrl}/weekly/copy',
        headers: await ApiUrl.headerWithToken(),
        body: {
          'fromweek': fromWeek,
          'fromyear': fromYear,
          'toweek': toWeek,
          'toyear': toYear,
        });

    return ApiReturnValue(
        value: response.value != null, message: response.message);
  }
}
