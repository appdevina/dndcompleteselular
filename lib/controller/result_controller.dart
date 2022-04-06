part of 'controllers.dart';

class ResultController extends GetxController {
  List<List<DailyModel>> dailys = [];
  List<WeeklyModel> weeklies = [];
  List<MonthlyModel> monthlies = [];
  DateTime now = DateTime.now();
  List<UserModel> team = [];

  //VARIABLE ONTIME
  double totalPointOnTime = 0;
  int bobotOntime = 20;

  //Variable Daily
  int totalPlanTaskDaily = 0;
  int totalDaysData = 0;
  int totalExtraTaskDaily = 0;
  int totalActualDaily = 0;
  double achievemntDaily = 0;
  int bobotDaily = 40;
  double totalPointDaily = 0;
  int totalOpenDaily = 0;

  //Variable Weekly
  int planTaskWeekly = 0;
  int actualTaskWeekly = 0;
  int extraTaskWeekly = 0;
  int bobotWeekly = 40;
  double achievementWeekly = 0;
  double totalPointWeekly = 0;
  int totalOpenWeekly = 0;

  //Variable Monthly
  int totalPlanTaskMonthly = 0;
  int totalExtraTaskMonthly = 0;
  int totalActualMonthly = 0;
  double achievemntMonthly = 0;
  int bobotMonthly = 20;
  double totalPointMonthly = 0;
  int totalOpenMonthly = 0;

  RxDouble totalKpi = 0.0.obs;
  RxInt week = 1.obs;
  RxBool loading = true.obs;

  void changeWeek({required bool isAdd}) async {
    isAdd
        ? week.value != 52
            ? week.value++
            : null
        : week.value != 1
            ? week.value--
            : null;
    await getAllResult(week: week.value, year: now.year);
  }

  Future<bool> getAllResult({required int week, required int year}) async {
    dailys.clear();
    weeklies.clear();
    monthlies.clear();
    if (weeklies.isEmpty || dailys.isEmpty) {
      //Variable Daily
      dailys = [];
      totalPointOnTime = 0;
      totalPlanTaskDaily = 0;
      totalDaysData = 0;
      totalExtraTaskDaily = 0;
      totalActualDaily = 0;
      achievemntDaily = 0;
      totalPointDaily = 0;
      totalOpenDaily = 0;

      //Variable Weekly
      weeklies = [];
      planTaskWeekly = 0;
      actualTaskWeekly = 0;
      extraTaskWeekly = 0;
      achievementWeekly = 0;
      totalPointWeekly = 0;
      totalOpenWeekly = 0;

      if (monthlies.isEmpty) {
        //Variable Monthly
        monthlies = [];
        totalPlanTaskMonthly = 0;
        totalExtraTaskMonthly = 0;
        totalActualMonthly = 0;
        achievemntMonthly = 0;
        totalPointMonthly = 0;
        totalOpenMonthly = 0;
        totalKpi.value = 0;
      }
    }
    ApiReturnValue? value = await ResultService.result(week: week, year: year);

    if (value != null) {
      for (var item in value.value['daily']) {
        dailys.add(
            (item as Iterable).map((e) => DailyModel.fromJson(e)).toList());
      }
      weeklies = (value.value['weekly'] as Iterable)
          .map((e) => WeeklyModel.fromJson(e))
          .toList();
      if ((value.value['monthly'] as List).toList().isNotEmpty) {
        monthlies = (value.value['monthly'] as Iterable)
            .map((e) => MonthlyModel.fromJson(e))
            .toList();
      }
    }

    if (dailys.isNotEmpty) {
      totalDaysData = dailys.length;
      //MAPPING DATA DAILY
      if (totalDaysData.isGreaterThan(0)) {
        for (List<DailyModel> dailyList in dailys) {
          totalPlanTaskDaily +=
              dailyList.where((e) => e.isPlan!).toList().length;
          totalActualDaily +=
              dailyList.where((e) => e.isPlan! && e.status!).toList().length;
          totalExtraTaskDaily +=
              dailyList.where((e) => !e.isPlan! && e.status!).toList().length;
          totalOpenDaily +=
              dailyList.where((e) => !e.status! && e.isPlan!).toList().length;
          var listPoint = dailyList.map((e) => e.ontime).toList();
          for (var point in listPoint) {
            totalPointOnTime += point!;
          }
        }
        achievemntDaily = (totalDaysData / 6) *
                    ((totalActualDaily + totalExtraTaskDaily) /
                        totalPlanTaskDaily) *
                    100 >
                100
            ? 100
            : (totalDaysData / 6) *
                ((totalActualDaily + totalExtraTaskDaily) /
                    totalPlanTaskDaily) *
                100;
        var pointontime = (totalDaysData / 6) *
            (totalPointOnTime / (totalPlanTaskDaily + totalExtraTaskDaily)) *
            bobotOntime;
        print(totalPlanTaskDaily);
        print(totalActualDaily);
        print(pointontime);
        totalPointDaily = (achievemntDaily / 100 * bobotDaily) > bobotDaily
            ? bobotDaily.toDouble()
            : ((achievemntDaily / 100 * bobotDaily));
        totalPointDaily += pointontime;
      }
    }

    if (weeklies.isNotEmpty) {
//MAPPING DATA WEEKLY
      planTaskWeekly =
          weeklies.where((element) => !element.isAdd!).toList().length;

      actualTaskWeekly =
          weeklies.where((element) => element.value != 0.0).toList().length;
      totalOpenWeekly =
          weeklies.where((element) => element.value == 0.0).toList().length;
      extraTaskWeekly =
          weeklies.where((element) => element.isAdd!).toList().length;
      for (WeeklyModel task in weeklies) {
        achievementWeekly += task.value!;
      }
      achievementWeekly = (achievementWeekly / weeklies.length * 100);
      totalPointWeekly = (achievementWeekly / 100 * bobotWeekly);
    }

    if (monthlies.isNotEmpty) {
      //MAPPING DATA MONTHLY
      if (monthlies.isNotEmpty) {
        totalPlanTaskMonthly =
            monthlies.where((element) => !element.isAdd!).toList().length;
        totalActualMonthly =
            monthlies.where((element) => element.value != 0.0).toList().length;
        totalOpenMonthly =
            monthlies.where((element) => element.value == 0.0).toList().length;
        totalExtraTaskMonthly =
            monthlies.where((element) => element.isAdd!).toList().length;
        for (MonthlyModel task in monthlies) {
          achievemntMonthly += task.value!;
        }
        achievemntMonthly = (achievemntMonthly / monthlies.length * 100);
        totalPointMonthly = (achievemntMonthly / 100 * bobotMonthly);
      }
    }
    totalKpi.value = monthlies.isNotEmpty
        ? (((totalPointDaily + totalPointWeekly) * 80 / 100) +
            totalPointMonthly)
        : (totalPointDaily + totalPointWeekly);

    update(['result']);
    return true;
  }

  String formatNumber(String s) => NumberFormat.decimalPattern('ID').format(
        int.parse(s),
      );

  int numOfWeeks(DateTime now) {
    int numberWeek = int.parse(DateFormat("D").format(now));
    return ((numberWeek - now.weekday + 10) / 7).floor();
  }

  Future getTeam() async =>
      await UserServices.getTeam().then((value) => team = value.value!);

  @override
  void onInit() async {
    await getAllResult(year: now.year, week: numOfWeeks(now))
        .then((_) => loading.toggle());
    week.value = numOfWeeks(now);
    await getTeam().then((value) {
      update(['team']);
    });
    super.onInit();
  }
}
