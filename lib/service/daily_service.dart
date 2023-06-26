part of 'services.dart';

class DailyService {
  static Future<ApiReturnValue<List<DailyModel>>> getDaily(
    String date,
  ) async {
    final response = await ApiService().get(
      '${ApiUrl.baseUrl}/daily?date=$date',
      headers: await ApiUrl.headerWithToken(),
    );

    if (response.value == null) {
      return ApiReturnValue(value: null, message: response.message);
    }
    List<DailyModel> value = (response.value['data'] as Iterable)
        .map((e) => DailyModel.fromJson(e))
        .toList();

    return ApiReturnValue(value: value, message: 'berhasil');
  }

  static Future<ApiReturnValue<bool>> submit({
    required DailyRequestModel dailyRequestModel,
  }) async {
    final response = await ApiService().post(
      '${ApiUrl.baseUrl}/daily/${dailyRequestModel.id == null ? "" : "edit/${dailyRequestModel.id}"}',
      headers: await ApiUrl.headerWithToken(),
      body: dailyRequestModel.toJson(),
    );

    return ApiReturnValue(
        value: response.value != null, message: response.message);
  }

  static Future<ApiReturnValue<bool>> delete({
    required int id,
  }) async {
    final response = await ApiService().get(
      '${ApiUrl.baseUrl}/daily/delete/$id',
      headers: await ApiUrl.headerWithToken(),
    );

    return ApiReturnValue(
        value: response.value != null, message: response.message);
  }

  static Future<ApiReturnValue<bool>> change({
    required int id,
    int? value,
  }) async {
    final response = await ApiService().post('${ApiUrl.baseUrl}/daily/change',
        headers: await ApiUrl.headerWithToken(),
        body: {
          'id': id,
          'value': value ?? '',
        });

    return ApiReturnValue(
        value: response.value != null, message: response.message);
  }

  static Future<ApiReturnValue<List<List<DailyModel>>>> fetchweek({
    required int week,
    required int year,
  }) async {
    try {
      final response = await ApiService().get(
        '${ApiUrl.baseUrl}/daily/fetchweek?week=$week&year=$year',
        headers: await ApiUrl.headerWithToken(),
      );

      if (response.value == null) {
        return ApiReturnValue(value: null, message: response.message);
      }

      List<List<DailyModel>> value = (response.value['data'] as Iterable)
          .map((e) =>
              (e as Iterable).map((e) => DailyModel.fromJson(e)).toList())
          .toList();
      return ApiReturnValue(value: value, message: response.message);
    } catch (e) {
      return ApiReturnValue(value: [], message: e.toString());
    }
  }

  static Future<ApiReturnValue<bool>> copy({
    required int week,
    required int year,
    required int addweek,
  }) async {
    final response = await ApiService().post('${ApiUrl.baseUrl}/daily/copy',
        headers: await ApiUrl.headerWithToken(),
        body: {
          'week': week,
          'year': year,
          'addweek': addweek,
        });
    return ApiReturnValue(
        value: response.value != null, message: response.message);
  }
}
