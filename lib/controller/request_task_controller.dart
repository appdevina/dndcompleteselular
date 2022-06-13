part of 'controllers.dart';

class RequestTaskController extends GetxController {
  late DateTime day, month;
  List<DailyModel> daily = [];
  List<WeeklyModel> weekly = [];
  List<MonthlyModel> monthly = [];
  List<DailyModel> dailyChange = [];
  List<WeeklyModel> weeklyChange = [];
  List<MonthlyModel> monthlyChange = [];
  List<RequestModel> requests = [];
  late UserModel user;
  late int week;
  String? selectedTodo;
  List<Object?> selectedTask = [];
  int maxWeek = 52;
  int minWeek = 1;
  RxBool isShowExt = false.obs;
  RxBool isShowRep = false.obs;

  int numOfWeeks(DateTime now) {
    int numberWeek = int.parse(DateFormat("D").format(now));
    return ((numberWeek - now.weekday + 10) / 7).floor();
  }

  void getHistory() async {
    await RequestService.fetch().then((value) => requests = value.value!);
    update([
      'result',
    ]);
  }

  String getDateRequest({required RequestModel requestModel}) {
    late String result;
    switch (requestModel.jenisToDo) {
      case 'Daily':
        result = DateFormat('dd MMMM y')
            .format(requestModel.dailyExisting![0].date!);
        break;
      case 'Weekly':
        result = requestModel.weeklyExisting![0].week!.toString();
        break;
      default:
        result = DateFormat('MMMM y')
            .format(requestModel.monthlyExisting![0].monthYear!);
    }

    return result;
  }

  Future<bool> addTaskChange(
      {DailyModel? dailyModel,
      WeeklyModel? weeklyModel,
      MonthlyModel? monthlyModel}) async {
    if (dailyModel != null) {
      dailyChange.add(dailyModel);
    }

    if (weeklyModel != null) {
      weeklyChange.add(weeklyModel);
    }

    if (monthlyModel != null) {
      monthlyChange.add(monthlyModel);
    }
    update(['tag']);
    return true;
  }

  bool buttonWeek(bool isAdd) {
    if (isAdd) {
      if (week == maxWeek) {
        null;
        return false;
      } else {
        week++;
        selectedTask.clear();
        weeklyChange.clear();
        getWeekly(DateTime.now().year, week);
        update(['spec']);
        return true;
      }
    } else {
      if (week == minWeek) {
        null;
        return false;
      } else {
        week--;
        selectedTask.clear();
        weeklyChange.clear();
        getWeekly(DateTime.now().year, week);
        update(['spec']);
        return true;
      }
    }
  }

  String formatNumber(String s) => NumberFormat.decimalPattern('ID').format(
        int.parse(s),
      );

  void changeTodo(String value) {
    selectedTask.clear();
    selectedTodo = value;
    if (value == 'Daily') {
      getDaily(day);
    } else if (value == 'Weekly') {
      getWeekly(month.year, week);
    } else if (value == 'Monthly') {
      getMonthly(month);
    }
    update(['spec']);
  }

  void getDaily(DateTime time) async {
    await DailyService.getDaily(DateFormat('y-MM-dd').format(time)).then(
        (value) => daily =
            value.value!.where((e) => !e.isUpdate! && e.isPlan!).toList());
    update(['tag']);
  }

  void getWeekly(int year, int week) async {
    await WeeklyService.getWeekly(week: week, year: year).then((value) =>
        weekly = value.value!.where((e) => !e.isUpdate! && !e.isAdd!).toList());
    update(['tag']);
  }

  void getMonthly(DateTime month) async {
    await MonthlyServices.getMonthly(month).then((value) => monthly =
        value.value!.where((e) => !e.isUpdate! && !e.isAdd!).toList());
    update(['tag']);
  }

  void changeDay(DateTime value) {
    day = value;
    selectedTask.clear();
    dailyChange.clear();
    getDaily(value);
    update(['spec']);
  }

  void changeMonth(DateTime val) {
    month = val;
    selectedTask.clear();
    monthlyChange.clear();
    getMonthly(val);
    update(['spec']);
  }

  Future<ApiReturnValue<bool>> cancel({required int id}) async =>
      await RequestService.cancel(id: id).then(((value) => value));

  Future<ApiReturnValue<bool>> submit({
    required String? type,
    required List<Object?> existingTaskId,
    List<DailyModel>? dailyReplace,
    List<WeeklyModel>? weeklyReplace,
    List<MonthlyModel>? monthlyReplace,
  }) async {
    switch (type) {
      case 'Daily':
        if (dailyReplace!.isEmpty || existingTaskId.isEmpty) {
          return ApiReturnValue(
              value: false,
              message: 'Task existing dan Task replace harus di isi');
        }
        break;
      case 'Weekly':
        if (weeklyReplace!.isEmpty ||
            existingTaskId.isEmpty ||
            weeklyReplace.length != existingTaskId.length) {
          return ApiReturnValue(
              value: false,
              message: 'Task existing dan Task replace harus sesuai jumlahnya');
        }
        break;
      default:
        if (monthlyReplace!.isEmpty ||
            existingTaskId.isEmpty ||
            monthlyReplace.length != existingTaskId.length) {
          return ApiReturnValue(
              value: false,
              message: 'Task existing dan Task replace harus sesuai jumlahnya');
        }
    }

    ApiReturnValue<bool> result = await RequestService.submit(
        type: type,
        exsitingTaskId: existingTaskId,
        dailyReplace: dailyReplace,
        weeklyReplace: weeklyReplace,
        monthlyReplace: monthlyReplace);

    return result;
  }

  @override
  void onInit() {
    final con = Get.find<HomePageController>();
    user = con.user;
    day = DateTime.now();
    month = DateTime(day.year, day.month);
    week = numOfWeeks(day);
    minWeek = week;
    getHistory();
    super.onInit();
  }
}
