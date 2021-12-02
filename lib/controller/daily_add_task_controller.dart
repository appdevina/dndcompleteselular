part of 'controllers.dart';

class DailyAddTaskController extends GetxController {
  final TextEditingController title = TextEditingController();
  final GlobalKey key = GlobalKey<FormState>();
  String selectedTime = DateFormat.jm().format(DateTime.now());
  DateTime? selectedDate, lastMonday;

  void changeDate(DateTime val) {
    selectedDate = val;
    update(['date']);
  }

  void changeTime(String val) {
    selectedTime = val;
    update(['time']);
  }

  @override
  void onInit() {
    lastMonday = DateTime.now()
        .add(const Duration(days: 7))
        .subtract(Duration(days: DateTime.now().weekday - 1));
    super.onInit();
  }

  @override
  void onClose() {
    title.dispose();
    super.onClose();
  }
}
