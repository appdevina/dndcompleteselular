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
    getMonthlyObjective(selectedMonthYear);
  }

  void getMonthlyObjective(DateTime month, {bool? isloading}) async {
    ApiReturnValue<List<MonthlyModel>> result =
        await MonthlyServices.getMonthly(month);
    monthly = result.value!;
    isloading ?? isLoading.toggle();
    update(['monthly']);
  }

  Color getColor(MonthlyModel monthly) {
    if (monthly.type == "NON") {
      return monthly.statNon! ? Colors.green[400]! : Colors.green[100]!;
    } else {
      return monthly.statRes! ? Colors.green[400]! : Colors.green[100]!;
    }
  }

  String formatNumber(String s) => NumberFormat.decimalPattern('ID').format(
        int.parse(s),
      );

  Future<ApiReturnValue<bool>> delete(int id) async {
    ApiReturnValue<bool> result = await MonthlyServices.delete(id: id);
    getMonthlyObjective(selectedMonthYear, isloading: true);
    return result;
  }

  Future<ApiReturnValue<bool>> changeStatus(
      {required int id, int? value}) async {
    ApiReturnValue<bool> result =
        await MonthlyServices.changeStatus(id: id, value: value);
    getMonthlyObjective(selectedMonthYear, isloading: true);
    update(['monthly']);
    return result;
  }

  @override
  void onInit() {
    selectedMonthYear = DateTime.now();
    minMonthYear = DateTime(2022, 1);
    valueResult = MoneyMaskedTextController(
        precision: 0, thousandSeparator: '.', decimalSeparator: '');
    getMonthlyObjective(selectedMonthYear);
    super.onInit();
  }
}
