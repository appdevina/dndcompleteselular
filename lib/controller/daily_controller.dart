part of 'controllers.dart';

class DailyController extends GetxController {
  List<DailyModel>? daily;
  DateTime selectedDate = DateTime.now();
  DateTime now = DateTime.now();
  RxBool loading = true.obs;

  void changeDate(DateTime val) {
    update(['daily']);
    loading.toggle();
    selectedDate = val;
    getDaily(val);
  }

  void getDaily(DateTime time, {bool? isloading}) async {
    await DailyService.getDaily(DateFormat('y-MM-dd').format(time))
        .then((value) => daily = value.value);
    isloading ?? loading.toggle();
    update(['daily']);
  }

  Future<ApiReturnValue<bool>> changeStatus(int id) async {
    HomePageController home = Get.find();
    ApiReturnValue<bool> result = await DailyService.change(id: id);
    getDaily(selectedDate, isloading: true);
    home.updateBack();
    update(['daily']);
    return result;
  }

  Future<ApiReturnValue<bool>> delete({required int id}) async {
    ApiReturnValue<bool> result =
        await DailyService.delete(id: id).then((_) => _);
    getDaily(selectedDate, isloading: true);
    update(['daily']);
    return result;
  }

  Color getColor(DailyModel daily) {
    return daily.status! ? Colors.green[400]! : Colors.green[100]!;
  }

  getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  getMonday(DateTime d) => getDate(d.subtract(Duration(days: d.weekday - 1)));

  getNextWeek(DateTime d) => getDate(getMonday(d).add(const Duration(days: 7)));

  @override
  void onInit() {
    getDaily(selectedDate);
    super.onInit();
  }
}
