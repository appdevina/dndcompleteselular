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
  final homePageController = Get.find<HomePageController>();
  RxBool isLoading = true.obs;
  late List<UserModel> users;
  List<UserModel> tempUsers = [];
  List<UserModel> selectedPerson = [];
  List<UserModel> selectedSendPerson = [];

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
    week.text = numOfWeeks(DateTime.now()).toString();
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

  Future<ApiReturnValue<bool>> submit() async {
    if (task.text.isEmpty || task.text.length < 3) {
      return ApiReturnValue(
          value: false, message: 'Kolom task harus di isi minimal 3 karakter');
    }
    if ((isResult.value && resultValue.text == '0') ||
        (isResult.value && resultValue.text.isEmpty)) {
      return ApiReturnValue(
          value: false, message: 'Jika result isi kolom nominal result');
    }
    final weekly = WeeklyRequestModel(
      task: task.text,
      week: int.tryParse(week.text),
      year: selectedYear,
      type: isResult.value ? 'RESULT' : 'NON',
      valPlan: int.tryParse(resultValue.text.replaceAll('.', '')),
      isAdd: tambahan.value,
      tag: selectedPerson,
      send: selectedSendPerson,
      isUpdate: this.weekly == null ? false : true,
      id: this.weekly?.id,
    );

    final response = await WeeklyService.submit(weeklyRequestModel: weekly);
    if (!response.value!) {
      return ApiReturnValue(value: false, message: response.message);
    }

    task.clear();
    resultValue.text = '0';
    tambahan.value = false;
    isResult.value = false;
    selectedPerson.clear();
    selectedSendPerson.clear();
    tempUsers = users.where((element) => element.weeklyNon!).toList();
    update(['tag', 'pic']);

    return ApiReturnValue(value: true, message: response.message);
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

  Future<ApiReturnValue<List<UserModel>>> tag() async {
    ApiReturnValue<List<UserModel>> result = await UserServices.tag();

    return result;
  }

  void weeklyResult() {
    isResult.toggle();
    if (isResult.value) {
      tempUsers = users.where((element) => element.weeklyResult!).toList();
    } else {
      tempUsers = users.where((element) => element.weeklyNon!).toList();
    }
    update(['tag', 'pic']);
  }

  @override
  void onInit() async {
    task = weekly == null
        ? TextEditingController()
        : TextEditingController(text: weekly!.task);
    try {
      resultValue = MoneyMaskedTextController(
          initialValue: weekly == null
              ? 0
              : weekly!.valPlan == null
                  ? 0
                  : weekly!.valPlan!.toDouble(),
          precision: 0,
          thousandSeparator: '.',
          decimalSeparator: '');
    } catch (e) {
      print(e);
    }
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
    await tag().then((value) {
      users = value.value!;
      tempUsers = users.where((element) => element.weeklyNon!).toList();
      isLoading.toggle();
      update(['tag', 'pic']);
    });

    getWeekObjective(selectedYear, selectedWeek);
    super.onInit();
  }
}
