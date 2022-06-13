part of 'controllers.dart';

class CopyMonthlyController extends GetxController {
  late DateTime monthFrom,
      minMonthFrom,
      maxMonthFrom,
      monthTo,
      minMonthTo,
      maxMonthTo;
  RxString monthfrom = '-'.obs;
  RxString monthto = '-'.obs;

  List<MonthlyModel> monthlys = [];

  Future<ApiReturnValue<List<MonthlyModel>>> getMonthlyObjective(
          DateTime month) async =>
      await MonthlyServices.getMonthly(month);

  String formatNumber(String s) => NumberFormat.decimalPattern('ID').format(
        int.parse(s),
      );

  void changeMonth({required bool isFrom, required DateTime val}) async {
    if (isFrom) {
      monthFrom = val;
      await getMonthlyObjective(monthFrom)
          .then((value) => monthlys = value.value!);
      monthfrom.value = DateFormat('MMMM y').format(monthFrom);
      update(['monthly']);
    } else {
      monthTo = val;
      monthto.value = DateFormat('MMMM y').format(monthTo);
    }
  }

  Future<ApiReturnValue<bool>> copy(
          {required DateTime from, required DateTime to}) async =>
      from.isAfter(to)
          ? ApiReturnValue(
              value: false, message: '"From Month" harus sebelum "To Month"')
          : await MonthlyServices.copy(from: from, to: to);

  @override
  void onInit() async {
    DateTime now = DateTime.now().subtract(const Duration(days: 30));
    maxMonthFrom = DateTime(2025, 12);
    monthFrom = DateTime(now.year, now.month);
    minMonthFrom = DateTime(2022, 4);
    minMonthTo = DateTime(2022, 4);
    monthTo = DateTime(DateTime.now().year, DateTime.now().month);
    maxMonthTo = DateTime(2025);
    await getMonthlyObjective(monthFrom)
        .then((value) => monthlys = value.value!);
    monthfrom.value = DateFormat('MMMM y').format(monthFrom);
    monthto.value = DateFormat('MMMM y').format(monthTo);
    update(['monthly']);
    super.onInit();
  }
}
