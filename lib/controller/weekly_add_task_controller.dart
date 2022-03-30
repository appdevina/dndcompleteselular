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

  void changeWeek(int val) {
    selectedWeek = val;
    getWeekObjective(selectedYear, selectedWeek);
  }

  void changeYear(int val) {
    selectedYear = val;
    getWeekObjective(selectedYear, selectedWeek);
  }

  void changeTambahan() {
    tambahan.toggle();
    minWeek = tambahan.value
        ? numOfWeeks(DateTime.now()) == 1
            ? 1
            : userId == 2 &&
                    DateTime.now().isBefore(getMonday(DateTime.now())
                        .add(const Duration(days: 1, hours: 10)))
                ? numOfWeeks(DateTime.now())
                : DateTime.now().isBefore(getMonday(DateTime.now())
                        .add(const Duration(hours: 17)))
                    ? numOfWeeks(DateTime.now())
                    : numOfWeeks(DateTime.now()) + 1
        : numOfWeeks(DateTime.now()) + 1;
    maxWeek = tambahan.value ? numOfWeeks(DateTime.now()) : 52;
    selectedWeek = minWeek;
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
    if (isResultVal && resultValueText == '0') {
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

  getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  getMonday(DateTime d) => getDate(d.subtract(Duration(days: d.weekday - 1)));

  getNextWeek(DateTime d) => getDate(getMonday(d).add(const Duration(days: 7)));

  @override
  void onInit() {
    final homeCon = Get.find<HomePageController>();
    userId = homeCon.user.area!.id;
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
    selectedWeek = weekly == null
        ? userId == 2 &&
                DateTime.now().isBefore(getMonday(DateTime.now())
                    .add(const Duration(days: 1, hours: 10)))
            ? numOfWeeks(DateTime.now())
            : DateTime.now().isBefore(
                    getMonday(DateTime.now()).add(const Duration(hours: 17)))
                ? numOfWeeks(DateTime.now())
                : numOfWeeks(DateTime.now()) + 1
        : weekly!.week!;
    selectedYear = weekly == null ? DateTime.now().year : weekly!.year!;
    week = TextEditingController(text: selectedWeek.toString());
    year = TextEditingController(text: selectedYear.toString());
    minWeek = weekly == null ? selectedWeek : weekly!.week!;
    minyear = weekly == null ? DateTime(2022).year : weekly!.year!;
    isResult = weekly == null
        ? false.obs
        : weekly!.type == 'RESULT'
            ? true.obs
            : false.obs;
    getWeekObjective(selectedYear, selectedWeek);
    super.onInit();
  }

  // @override
  // void onClose() {
  //   task.dispose();
  //   resultValue.dispose();
  //   week.dispose();
  //   year.dispose();
  //   super.onClose();
  // }
}
