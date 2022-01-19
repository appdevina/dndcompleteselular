part of 'controllers.dart';

class MonthlyController extends GetxController {
  late DateTime selectedMonthYear, minMonthYear;
  late MoneyMaskedTextController valueResult;
  late List<MonthlyModel> monthly;
  RxBool isLoading = true.obs;

  void changeMonth(DateTime val) {
    isLoading.toggle();
    update(['monthly']);
    selectedMonthYear = val;
    update(['month']);
    getMonthlyObjective(selectedMonthYear.year, selectedMonthYear.month);
  }

  void getMonthlyObjective(int year, int month) async {
    ApiReturnValue<List<MonthlyModel>> result =
        await MonthlyServices.getMonthly(year, month);
    monthly = result.value!;
    isLoading.toggle();
    update(['monthly']);
  }

  Color getColor(String type, MonthlyModel monthly) {
    if (type == "NON") {
      return monthly.statNon! ? Colors.green[400]! : Colors.green[100]!;
    } else {
      return monthly.statRes == 0.0 ? Colors.green[100]! : Colors.green[400]!;
    }
  }

  String formatNumber(String s) => NumberFormat.decimalPattern('ID').format(
        int.parse(s),
      );

  Future<ApiReturnValue<bool>> changeStatus(int month, int id, String type,
      {String? value}) async {
    await MonthlyServices.changeStatus(month, id, type,
        value: double.parse(value ?? '0'));
    update(['monthly']);
    return ApiReturnValue(value: true, message: "berhasil merubah");
  }

  @override
  void onInit() {
    selectedMonthYear = DateTime.now();
    minMonthYear = DateTime(2022, 1);
    valueResult = MoneyMaskedTextController(
        initialValue: 0,
        precision: 0,
        thousandSeparator: '.',
        decimalSeparator: '');
    getMonthlyObjective(selectedMonthYear.year, selectedMonthYear.month);
    super.onInit();
  }
}
