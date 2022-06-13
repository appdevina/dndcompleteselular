part of 'controllers.dart';

class CopyWeeklyController extends GetxController {
  late RxString from, to;
  //FROM LIMITATION
  late int minWeekFrom, maxWeekFrom, minYearFrom, maxYearFrom;
  //TO LIMITATION
  late int minWeekTo, maxWeekTo, minYearTo, maxYearTo;
  //VARIABLE FOR DISPLAY
  late RxInt fromWeek, fromYear, toWeek, toYear;
  //LIST DAILY EXISTING
  List<WeeklyModel> weekly = [];

  Future<ApiReturnValue<String>> getDate(int week, int year) async {
    ApiReturnValue<String> result =
        await WeeklyService.getDate(week: week, year: year);
    return result;
  }

  String formatNumber(String s) => NumberFormat.decimalPattern('ID').format(
        int.parse(s),
      );

  Future<ApiReturnValue<List<WeeklyModel>>> getWeekObjective({
    required int year,
    required int week,
  }) async =>
      await WeeklyService.getWeekly(week: week, year: year);

  int numOfWeeks(DateTime now) {
    int numberWeek = int.parse(DateFormat("D").format(now));
    return ((numberWeek - now.weekday + 10) / 7).floor();
  }

  Future<bool> buttonWeek(bool isAdd, bool isFrom) async {
    if (isFrom) {
      if (isAdd) {
        if (fromWeek.value == maxWeekFrom) {
          return false;
        } else {
          fromWeek.value++;
          await getDate(fromWeek.value, fromYear.value)
              .then((value) => from.value = value.value!);
          await getWeekObjective(week: fromWeek.value, year: fromYear.value)
              .then(((value) => weekly = value.value!));
          update(['weekly']);
          return true;
        }
      } else {
        fromWeek.value--;
        await getDate(fromWeek.value, fromYear.value)
            .then((value) => from.value = value.value!);
        await getWeekObjective(week: fromWeek.value, year: fromYear.value)
            .then(((value) => weekly = value.value!));
        update(['weekly']);
        return true;
      }
    } else {
      if (isAdd) {
        if (toWeek.value == maxWeekTo) {
          return false;
        } else {
          toWeek.value++;
          await getDate(toWeek.value, toYear.value)
              .then((value) => to.value = value.value!);
          return true;
        }
      } else {
        if (toWeek.value == minWeekTo) {
          return false;
        } else {
          toWeek.value--;
          await getDate(toWeek.value, toYear.value)
              .then((value) => to.value = value.value!);
          return true;
        }
      }
    }
  }

  Future<bool> buttonYear(bool isAdd, bool isFrom) async {
    if (isFrom) {
      if (isAdd) {
        if (fromYear.value == maxYearFrom) {
          return false;
        } else {
          fromYear.value++;
          await getDate(fromWeek.value, fromYear.value)
              .then((value) => from.value = value.value!);
          await getWeekObjective(week: fromWeek.value, year: fromYear.value)
              .then(((value) => weekly = value.value!));
          update(['weekly']);
          return true;
        }
      } else {
        if (fromYear.value == minYearFrom) {
          return false;
        } else {
          fromYear.value--;
          await getDate(fromWeek.value, fromYear.value)
              .then((value) => from.value = value.value!);
          await getWeekObjective(week: fromWeek.value, year: fromYear.value)
              .then(((value) => weekly = value.value!));
          update(['weekly']);
          return true;
        }
      }
    } else {
      if (isAdd) {
        if (toYear.value == maxYearTo) {
          return false;
        } else {
          toYear.value++;
          minWeekTo = 1;
          await getDate(toWeek.value, toYear.value)
              .then((value) => to.value = value.value!);
          return true;
        }
      } else {
        if (toYear.value == minYearTo) {
          return false;
        } else {
          toYear.value--;
          await getDate(toWeek.value, toYear.value)
              .then((value) => to.value = value.value!);
          return true;
        }
      }
    }
  }

  Future<ApiReturnValue<bool>> copy(
      {required int yearfrom,
      required int weekfrom,
      required int yearto,
      required int weekto}) async {
    if (yearfrom > yearto) {
      return ApiReturnValue(
          value: false, message: '"From Week" harus sebelum "To Week"');
    }
    if (weekly.isEmpty) {
      return ApiReturnValue(
          value: false,
          message: "Tidak bisa duplicate weekly di from week yang kosong");
    }
    ApiReturnValue<bool> result = await WeeklyService.copy(
        fromWeek: weekfrom, fromYear: yearfrom, toWeek: weekto, toYear: yearto);
    return result;
  }

  toDate(DateTime d) => DateTime(d.year, d.month, d.day);

  getMonday(DateTime d) => toDate(d.subtract(Duration(days: d.weekday - 1)));

  int getMinWeek(int areaId, DateTime now) => numOfWeeks(now) == 1
      ? 1
      : areaId == 2 &&
              DateTime.now().isBefore(getMonday(DateTime.now())
                  .add(const Duration(days: 1, hours: 10)))
          ? numOfWeeks(now)
          : DateTime.now().isBefore(
                  getMonday(DateTime.now()).add(const Duration(hours: 17)))
              ? numOfWeeks(now)
              : numOfWeeks(now) + 1;

  int getMaxWeek(int areaId, DateTime now) => areaId == 2 &&
          DateTime.now().isBefore(
              getMonday(DateTime.now()).add(const Duration(days: 1, hours: 10)))
      ? numOfWeeks(now) - 1
      : DateTime.now().isBefore(
              getMonday(DateTime.now()).add(const Duration(hours: 17)))
          ? numOfWeeks(now) - 1
          : numOfWeeks(now);

  @override
  void onInit() async {
    DateTime now = DateTime.now();

    //INITIALIZEN FROM
    minWeekFrom = 1;
    maxWeekFrom = 52;
    minYearFrom = 2022;
    maxYearFrom = 2025;
    //INITIALIZE TO
    minWeekTo = 1;
    maxWeekTo = 52;
    minYearTo = 2022;
    maxYearTo = 2025;

    //DISPLAY NUMBER WEEK AND YEAR
    fromWeek = (numOfWeeks(now) - 1).obs;
    fromYear = (now.year).obs;
    toWeek = numOfWeeks(now).obs;
    toYear = (now.year).obs;
    from = '-'.obs;
    to = '-'.obs;
    await getWeekObjective(week: fromWeek.value, year: fromYear.value)
        .then(((value) => weekly = value.value!));
    await getDate(fromWeek.value, fromYear.value)
        .then((value) => from.value = value.value!);
    await getDate(toWeek.value, toYear.value)
        .then((value) => to.value = value.value!);
    update(['weekly']);
    super.onInit();
  }
}
