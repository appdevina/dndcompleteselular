part of 'controllers.dart';

class ResultController extends GetxController {
  List<List<DailyModel>> dailys = [];
  late List<WeeklyModel> weeklies;
  late List<MonthlyModel> monthlies;
  DateTime now = DateTime.now();
  //Variable Daily
  int totalPlanTaskDaily = 0;
  int totalDays = 0;
  int totalExtraTaskDaily = 0;
  int totalActualDaily = 0;
  double achievemntDaily = 0;
  int bobotDaily = 60;
  int totalPointDaily = 0;
  int totalOpenDaily = 0;

  //Variable Weekly
  int planTaskWeekly = 0;
  int actualTaskWeekly = 0;
  int extraTaskWeekly = 0;
  int bobotWeekly = 40;
  double achievementWeekly = 0;
  int totalPointWeekly = 0;
  int totalOpenWeekly = 0;

  //Variable Monthly
  int totalPlanTaskMonthly = 0;
  int totalExtraTaskMonthly = 0;
  int totalActualMonthly = 0;
  double achievemntMonthly = 0;
  int bobotMonthly = 20;
  int totalPointMonthly = 0;
  int totalOpenMonthly = 0;

  RxInt totalKpi = 0.obs;

  RxBool loading = true.obs;

  Future<bool> getAllResult() async {
    weeklies = [];
    monthlies = mockMonthly;

    totalDays = dailys.length;
    //MAPPING DATA DAILY
    for (List<DailyModel> dailyList in dailys) {
      totalPlanTaskDaily += dailyList.where((e) => e.isPlan!).toList().length;
      totalActualDaily +=
          dailyList.where((e) => e.isPlan! && e.status!).toList().length;
      totalExtraTaskDaily +=
          dailyList.where((e) => e.isPlan! && e.status!).toList().length;
      totalOpenDaily +=
          dailyList.where((e) => e.status! && e.isPlan!).toList().length;

      achievemntDaily = ((totalActualDaily + totalExtraTaskDaily) /
                      totalPlanTaskDaily) *
                  100 >
              100
          ? 100
          : ((totalActualDaily + totalExtraTaskDaily) / totalPlanTaskDaily) *
              100;

      totalPointDaily =
          (achievemntDaily / 100 * bobotDaily).toInt() > bobotDaily
              ? bobotDaily
              : (achievemntDaily / 100 * bobotDaily).ceil();
    }

    //MAPPING DATA WEEKLY
    planTaskWeekly =
        weeklies.where((element) => element.isAdd!).toList().length;

    actualTaskWeekly =
        weeklies.where((element) => element.value != 0).toList().length;
    totalOpenWeekly =
        weeklies.where((element) => element.value == 0).toList().length;
    extraTaskWeekly =
        weeklies.where((element) => !element.isAdd!).toList().length;
    for (WeeklyModel task in weeklies) {
      achievementWeekly += task.value!;
    }
    achievementWeekly =
        (achievementWeekly / weeklies.length * 100).floorToDouble();
    // ((actualTaskWeekly.toDouble() + extraTaskWeekly) / planTaskWeekly * 100)
    //     .floorToDouble();
    totalPointWeekly = (achievementWeekly / 100 * bobotWeekly).ceil();

    //MAPPING DATA MONTHLY

    totalPlanTaskMonthly =
        monthlies.where((element) => element.isPlan!).toList().length;
    totalActualMonthly =
        monthlies.where((element) => element.value != 0).toList().length;
    totalOpenMonthly =
        monthlies.where((element) => element.value == 0).toList().length;
    totalExtraTaskMonthly =
        monthlies.where((element) => !element.isPlan!).toList().length;
    for (MonthlyModel task in monthlies) {
      achievemntMonthly += task.value!;
    }
    achievemntMonthly =
        (achievemntMonthly / monthlies.length * 100).floorToDouble();
    totalPointMonthly = (achievemntMonthly / 100 * bobotMonthly).ceil();

    totalKpi.value =
        (((totalPointDaily + totalPointWeekly) * 80 / 100) + totalPointMonthly)
            .ceil();

    return true;
  }

  String formatNumber(String s) => NumberFormat.decimalPattern('ID').format(
        int.parse(s),
      );

  @override
  void onInit() async {
    await getAllResult().then((_) => loading.toggle());
    super.onInit();
  }
}
