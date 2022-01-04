part of 'controllers.dart';

class DailyController extends GetxController {
  List<DailyModel>? daily;
  DateTime selectedDate = DateTime.now();
  late DateTime lastMonday;
  DateTime now = DateTime.now();
  RxBool loading = true.obs;

  void changeDate(DateTime val) {
    update(['daily']);
    loading.toggle();
    selectedDate = val;
    getDaily(val);
  }

  void getDaily(DateTime time) async {
    await DailyService.getDaily(DateFormat('dd-MM-y').format(time))
        .then((value) => daily = value.value);
    loading.toggle();
    update(['daily']);
  }

  @override
  void onInit() {
    lastMonday =
        DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
    getDaily(selectedDate);
    super.onInit();
  }
}