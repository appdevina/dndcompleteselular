part of 'controllers.dart';

class WeeklyAddTaskController extends GetxController {
  final GlobalKey key = GlobalKey<FormState>();
  late TextEditingController title, value;
  late int selectedWeek;
  RxBool check = false.obs;

  List<int> week = [];

  void changeWeek(int val) {
    selectedWeek = val;
  }

  @override
  void onInit() {
    title = TextEditingController();
    value = TextEditingController();
    for (var i = 1; i <= 52; i++) {
      week.add(i);
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
