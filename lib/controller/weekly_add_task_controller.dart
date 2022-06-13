part of 'controllers.dart';

class WeeklyAddTaskController extends GetxController {
  final WeeklyModel? weekly;
  WeeklyAddTaskController({this.weekly});
  final GlobalKey key = GlobalKey<FormState>();
  late TextEditingController task, week, year;
  late int selectedWeek, selectedYear, minWeek, minyear;
  late RxBool isResult;
  RxBool tambahan = false.obs;
  late MoneyMaskedTextController resultValue;
  int maxWeek = 52;
  int? userId;
  List<WeeklyModel> weeklys = [];
  RxBool button = true.obs;

  void changeWeek(int val) {
    selectedWeek = val;
    getWeekObjective(selectedYear, selectedWeek);
  }

  String formatNumber(String s) => NumberFormat.decimalPattern('ID').format(
        int.parse(s),
      );

  void changeYear(int val) {
    selectedYear = val;
    getWeekObjective(selectedYear, selectedWeek);
  }

  void changeTambahan() {
    tambahan.toggle();
    week.text = minWeek.toString();
    update(['week']);
  }

  bool buttonWeek(bool isAdd) {
    if (isAdd) {
      if (selectedWeek == maxWeek) {
        null;
        return false;
      } else {
        selectedWeek++;
        week.text = selectedWeek.toString();
        changeWeek(selectedWeek);
        update(['week']);
        return true;
      }
    } else {
      if (week.text.toInt()! < minWeek + 1) {
        null;
        return false;
      } else {
        selectedWeek--;
        week.text = selectedWeek.toString();
        changeWeek(selectedWeek);
        update(['week']);
        return true;
      }
    }
  }

  bool buttonYear(bool isAdd) {
    if (isAdd) {
      selectedYear++;
      year.text = selectedYear.toString();
      changeWeek(selectedYear);
      update(['year']);
      return true;
    } else {
      if (year.text.toInt()! < minyear + 1) {
        null;
        return false;
      } else {
        selectedYear--;
        year.text = selectedYear.toString();
        changeWeek(selectedYear);
        update(['year']);
        return true;
      }
    }
  }

  Future<ApiReturnValue<bool>> submit({
    required bool isUpdate,
    required bool extraTask,
    required String taskVal,
    required int week,
    required int year,
    required bool isResultVal,
    String? resultValueText,
    int? id,
  }) async {
    if (taskVal.isEmpty || taskVal.length < 3) {
      return ApiReturnValue(
          value: false, message: 'Kolom task harus di isi minimal 3 karakter');
    }
    if ((isResultVal && resultValueText == '0') ||
        (isResultVal && resultValueText == null)) {
      return ApiReturnValue(
          value: false, message: 'Jika result isi kolom nominal result');
    }
    ApiReturnValue<bool> result = await WeeklyService.submit(
      isUpdate: isUpdate,
      extraTask: extraTask,
      task: taskVal,
      week: week,
      year: year,
      isResult: isResultVal,
      resultValue: resultValueText,
      id: id,
    );
    if (result.value!) {
      task.clear();
      resultValue.clear();
      tambahan.value = false;
      isResult.value = false;
      update();
    }

    return result;
  }

  int numOfWeeks(DateTime now) {
    int numberWeek = int.parse(DateFormat("D").format(now));
    return ((numberWeek - now.weekday + 10) / 7).floor();
  }

  void getWeekObjective(int year, int week, {bool? isloading}) async {
    ApiReturnValue<List<WeeklyModel>> result =
        await WeeklyService.getWeekly(week: week, year: year);
    weeklys = result.value!;
    update(['weekly']);
  }

  @override
  void onInit() {
    task = weekly == null
        ? TextEditingController()
        : TextEditingController(text: weekly!.task);
    resultValue = MoneyMaskedTextController(
        initialValue: weekly == null
            ? 0
            : weekly!.valPlan == null
                ? 0
                : weekly!.valPlan!.toDouble(),
        precision: 0,
        thousandSeparator: '.',
        decimalSeparator: '');
    selectedWeek = weekly == null ? numOfWeeks(DateTime.now()) : weekly!.week!;
    selectedYear = weekly == null ? DateTime.now().year : weekly!.year!;
    week = TextEditingController(text: selectedWeek.toString());
    year = TextEditingController(text: selectedYear.toString());
    minWeek = weekly == null ? 1 : weekly!.week!;
    minyear = weekly == null ? DateTime(2022).year : weekly!.year!;
    isResult = weekly == null
        ? false.obs
        : weekly!.type == 'RESULT'
            ? true.obs
            : false.obs;
    getWeekObjective(selectedYear, selectedWeek);
    super.onInit();
  }
}
