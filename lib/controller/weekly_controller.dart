part of 'controllers.dart';

class WeeklyController extends GetxController {
  PageController pageController = PageController();
  late int selectedWeek, selectedYear, minWeek, minyear;
  DateTime selectedDate = DateTime.now();
  RxBool isLoading = true.obs;
  late List<WeeklyModel> weekly;
  late TextEditingController weekNumber, yearNumber;
  late MoneyMaskedTextController valueResult;

  int numOfWeeks(DateTime now) {
    int numberWeek = int.parse(DateFormat("D").format(now));
    return ((numberWeek - now.weekday + 10) / 7).floor();
  }

  void getWeekObjective(int year, int week) async {
    ApiReturnValue<List<WeeklyModel>> result =
        await WeeklyService.getWeekly(year, week);
    weekly = result.value!;
    isLoading.toggle();
    update(['weekly']);
  }

  void changeYear(int val) {
    isLoading.toggle();
    update(['weekly']);
    selectedYear = val;
    update(['week']);
    getWeekObjective(selectedYear, selectedWeek);
  }

  String formatNumber(String s) => NumberFormat.decimalPattern('ID').format(
        int.parse(s),
      );

  void changeWeek(int val) {
    isLoading.toggle();
    update(['weekly']);
    selectedWeek = val;
    update(['week']);
    getWeekObjective(selectedYear, selectedWeek);
  }

  Color getColor(String type, WeeklyModel weekly) {
    if (type == "NON") {
      return weekly.statNon! ? Colors.green[400]! : Colors.green[100]!;
    } else {
      return weekly.statRes == 0.0 ? Colors.green[100]! : Colors.green[400]!;
    }
  }

  bool buttonYear(bool isAdd) {
    if (isAdd) {
      selectedYear++;
      yearNumber.text = selectedYear.toString();
      changeYear(selectedYear);
      update(['week']);
      return true;
    } else {
      if (yearNumber.text.toInt()! < minyear + 1) {
        null;
        return false;
      } else {
        selectedYear--;
        yearNumber.text = selectedYear.toString();
        changeYear(selectedYear);
        update(['week']);
        return true;
      }
    }
  }

  bool buttonWeek(bool isAdd) {
    if (isAdd) {
      if (selectedWeek == 52) {
        return false;
      } else {
        selectedWeek++;
        weekNumber.text = selectedWeek.toString();
        changeWeek(selectedWeek);

        update(['week']);
        return true;
      }
    } else {
      if (selectedWeek == 1) {
        return false;
      } else {
        selectedWeek--;
        weekNumber.text = selectedWeek.toString();
        changeWeek(selectedWeek);
        update(['week']);
        return true;
      }
    }
  }

  Future<ApiReturnValue<bool>> changeStatus(int week, int id, String type,
      {int? value}) async {
    ApiReturnValue<List<WeeklyModel>> result =
        await WeeklyService.changeStatus(week, id, type, value: value);

    update(['weekly']);
    return ApiReturnValue(value: true, message: "berhasil merubah");
  }

  @override
  void onInit() {
    selectedWeek = numOfWeeks(DateTime.now());
    weekNumber = TextEditingController(text: selectedWeek.toString());
    valueResult = MoneyMaskedTextController(
        initialValue: 0,
        precision: 0,
        thousandSeparator: '.',
        decimalSeparator: '');
    selectedYear = DateTime.now().year;
    minWeek = 1;
    yearNumber = TextEditingController(text: DateTime.now().year.toString());
    minyear = 2022;
    getWeekObjective(selectedYear, selectedWeek);
    super.onInit();
  }
}
