part of 'controllers.dart';

class WeeklyController extends GetxController {
  PageController pageController = PageController();
  late int selectedWeek, selectedYear, minWeek, minyear;
  DateTime selectedDate = DateTime.now();
  RxBool isLoading = true.obs;
  late List<WeeklyModel> weekly;
  late TextEditingController weekNumber, yearNumber;
  late MoneyMaskedTextController valueResult;
  RxString date = '-'.obs;

  int numOfWeeks(DateTime now) {
    int numberWeek = int.parse(DateFormat("D").format(now));
    return ((numberWeek - now.weekday + 10) / 7).floor();
  }

  void getWeekObjective(int year, int week, {bool? isloading}) async {
    ApiReturnValue<List<WeeklyModel>> result =
        await WeeklyService.getWeekly(week: week, year: year);
    await getDate(week, year);
    weekly = result.value!;
    isloading ?? isLoading.toggle();
    update(['weekly']);
  }

  Future<ApiReturnValue<bool>> delete(int id) async {
    ApiReturnValue<bool> result = await WeeklyService.delete(id: id);
    getWeekObjective(selectedYear, selectedWeek, isloading: true);
    return result;
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

  Future<ApiReturnValue<String>> getDate(int week, int year) async {
    ApiReturnValue<String> result =
        await WeeklyService.getDate(week: week, year: year);
    date.value = result.value!;
    return result;
  }

  void changeWeek(int val) {
    isLoading.toggle();
    update(['weekly']);
    selectedWeek = val;
    update(['week']);
    getWeekObjective(selectedYear, selectedWeek);
  }

  Color getColor(WeeklyModel weekly) {
    if (weekly.type == "NON") {
      return weekly.statNon! ? Colors.green[400]! : Colors.green[100]!;
    } else {
      return weekly.statRes! ? Colors.green[400]! : Colors.green[100]!;
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

  Future<ApiReturnValue<bool>> changeStatus({
    required int id,
    int? value,
  }) async {
    ApiReturnValue<bool> result =
        await WeeklyService.changeStatus(id: id, value: value);
    getWeekObjective(selectedYear, selectedWeek, isloading: true);
    return result;
  }

  @override
  void onInit() async {
    selectedWeek = numOfWeeks(DateTime.now());
    weekNumber = TextEditingController(text: selectedWeek.toString());
    valueResult = MoneyMaskedTextController(
      precision: 0,
      thousandSeparator: '.',
      decimalSeparator: '',
    );
    selectedYear = DateTime.now().year;
    minWeek = 1;
    yearNumber = TextEditingController(text: DateTime.now().year.toString());
    minyear = 2022;
    getWeekObjective(selectedYear, selectedWeek);
    super.onInit();
  }

  @override
  void onClose() {
    weekNumber.dispose();
    yearNumber.dispose();
    super.onClose();
  }
}
