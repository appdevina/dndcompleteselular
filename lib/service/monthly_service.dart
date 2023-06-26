part of 'services.dart';

class MonthlyServices {
  static Future<ApiReturnValue<List<MonthlyModel>>> getMonthly(
    DateTime month,
  ) async {
    final response = await ApiService().get(
      '${ApiUrl.baseUrl}/monthly/?date=${DateFormat("y-MM-dd").format(month)}',
      headers: await ApiUrl.headerWithToken(),
    );

    if (response.value == null) {
      return ApiReturnValue(value: null, message: response.message);
    }

    List<MonthlyModel> value = (response.value['data'] as Iterable)
        .map((e) => MonthlyModel.fromJson(e))
        .toList();

    return ApiReturnValue(value: value, message: response.message);
  }

  static Future<ApiReturnValue<bool>> changeStatus({
    required int id,
    int? value,
  }) async {
    final response = await ApiService().post('${ApiUrl.baseUrl}/monthly/change',
        headers: await ApiUrl.headerWithToken(),
        body: {
          'id': id,
          'value': value,
        });

    return ApiReturnValue(
        value: response.value != null, message: response.message);
  }

  static Future<ApiReturnValue<bool>> submit({
    required MonthlyRequestModel monthlyRequestModel,
  }) async {
    final response = await ApiService().post(
      '${ApiUrl.baseUrl}/monthly/${monthlyRequestModel.id == null ? "" : "edit/${monthlyRequestModel.id}"}',
      headers: await ApiUrl.headerWithToken(),
      body: monthlyRequestModel.toJson(),
    );

    return ApiReturnValue(
        value: response.value != null, message: response.message);
  }

  static Future<ApiReturnValue<bool>> delete({
    required int id,
  }) async {
    final response = await ApiService().get(
      '${ApiUrl.baseUrl}/monthly/delete/$id',
      headers: await ApiUrl.headerWithToken(),
    );

    return ApiReturnValue(
        value: response.value != null, message: response.message);
  }

  static Future<ApiReturnValue<bool>> copy({
    required DateTime from,
    required DateTime to,
  }) async {
    final response = await ApiService().post('${ApiUrl.baseUrl}/monthly/copy',
        headers: await ApiUrl.headerWithToken(),
        body: {
          'frommonth': DateFormat('y-MM-dd').format(from),
          'tomonth': DateFormat('y-MM-dd').format(to),
        });

    return ApiReturnValue(
        value: response.value != null, message: response.message);
  }
}
