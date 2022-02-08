part of 'services.dart';

class MonthlyServices {
  static Future<ApiReturnValue<List<MonthlyModel>>> getMonthly(
      int year, int month) async {
    await Future.delayed(const Duration(seconds: 1));

    if (year == 2022 && month == 1) {
      return ApiReturnValue(value: mockMonthly, message: 'Berhasil');
    }
    return ApiReturnValue(value: [], message: "gagal");
  }

  static Future<ApiReturnValue<List<MonthlyModel>>> changeStatus(
      int month, int id, String type,
      {int? value}) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      if (month == 1) {
        for (MonthlyModel month in mockMonthly) {
          if (month.id == id) {
            if (type == "NON") {
              month.statNon = !month.statNon!;
              month.value = 1;
            } else {
              month.valAct = value!;
              month.statRes = (value / month.valPlan!).toDouble();
              month.value = month.statRes;
            }
          }
        }
      }

      return ApiReturnValue(
          value: mockMonthly, message: "berhasil merubah status");
    } catch (e) {
      return ApiReturnValue(value: [], message: "gagal merubah status");
    }
  }
}
