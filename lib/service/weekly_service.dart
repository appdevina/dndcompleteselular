part of 'services.dart';

class WeeklyService {
  static Future<ApiReturnValue<List<WeeklyModel>>> getWeekly(
      int year, int week) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      if (week == 3 && year == 2022) {
        return ApiReturnValue(value: mockWeekly, message: "berhasil");
      }
      return ApiReturnValue(value: [], message: "berhasil");
    } catch (e) {
      return ApiReturnValue(value: [], message: "gagal");
    }
  }

  static Future<ApiReturnValue<List<WeeklyModel>>> changeStatus(
    int week,
    int id,
    String type, {
    int? value,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      if (week == 3) {
        for (WeeklyModel week in mockWeekly) {
          if (week.id == id) {
            if (type == "NON") {
              week.statNon = !week.statNon!;
              week.value = 1;
            } else {
              week.statRes = ((value! / week.valPlan!) * 100).toDouble();
              week.value = week.statRes;
            }
          }
        }
      }

      return ApiReturnValue(
          value: mockWeekly, message: "berhasil merubah status");
    } catch (e) {
      return ApiReturnValue(value: [], message: "gagal merubah status");
    }
  }
}
