part of 'controllers.dart';

class WeeklyAddTaskController extends GetxController {
  final GlobalKey key = GlobalKey<FormState>();
  late TextEditingController task, week, year;
  late int selectedWeek, selectedYear, minWeek, minyear;
  RxBool isResult = false.obs;
  RxBool tambahan = false.obs;
  late MoneyMaskedTextController resultValue;
  int maxWeek = 52;

  void changeWeek(int val) {
    selectedWeek = val;
  }

  void changeYear(int val) {
    selectedYear = val;
  }

  void changeTambahan() {
    tambahan.toggle();
    minWeek = tambahan.value
        ? numOfWeeks(DateTime.now()) == 1
            ? 1
            : DateFormat('E').format(DateTime.now()) == "Mon"
                ? numOfWeeks(DateTime.now()) - 1
                : numOfWeeks(DateTime.now())
        : numOfWeeks(DateTime.now());
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
    required bool extraTask,
    required String taskVal,
    required int week,
    required int year,
    required bool isResultVal,
    String? resultValueText,
  }) async {
    ApiReturnValue<bool> result = await WeeklyService.submit(
      extraTask: extraTask,
      task: taskVal,
      week: week,
      year: year,
      isResult: isResultVal,
      resultValue: resultValueText,
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

  @override
  void onInit() {
    task = TextEditingController();
    resultValue = MoneyMaskedTextController(
        initialValue: 0,
        precision: 0,
        thousandSeparator: '.',
        decimalSeparator: '');
    selectedWeek = numOfWeeks(DateTime.now());
    selectedYear = DateTime.now().year;
    week = TextEditingController(text: selectedWeek.toString());
    year = TextEditingController(text: selectedYear.toString());
    minWeek = numOfWeeks(DateTime.now());
    minyear = DateTime(2022).year;
    super.onInit();
  }

  @override
  void onClose() {
    task.dispose();
    resultValue.dispose();
    week.dispose();
    year.dispose();
    super.onClose();
  }
}
