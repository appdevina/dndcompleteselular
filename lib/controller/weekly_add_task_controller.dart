part of 'controllers.dart';

class WeeklyAddTaskController extends GetxController {
  final GlobalKey key = GlobalKey<FormState>();
  late TextEditingController title, value;
  late int selectedWeek, selectedYear;
  RxBool check = false.obs;

  List<int> week = [];
  List<int> year = [];

  void changeWeek(int val) {
    selectedWeek = val;
  }

  void changeYear(int val) {
    selectedYear = val;
  }

  // Future<ApiReturnValue> submit()async{

  // }

  @override
  void onInit() {
    title = TextEditingController();
    value = TextEditingController();
    for (var i = 1; i <= 52; i++) {
      week.add(i);
    }
    for (var i = 2022; i <= 2025; i++) {
      year.add(i);
    }
    super.onInit();
  }

  @override
  void onClose() {
    title.dispose();
    value.dispose();
    super.onClose();
  }
}
