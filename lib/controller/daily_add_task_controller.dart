part of 'controllers.dart';

class DailyAddTaskController extends GetxController {
  final TextEditingController task = TextEditingController();
  final GlobalKey key = GlobalKey<FormState>();
  String selectedTime = DateFormat.jm().format(DateTime.now());
  DateTime? selectedDate, lastMonday;
  RxBool tambahan = false.obs;
  DateTime today = DateTime.now();

  void changeDate(DateTime val) {
    selectedDate = val;
    update(['date']);
  }

  void changeTime(String val) {
    selectedTime = val;
    update(['time']);
  }

  void changeTambahan() {
    tambahan.toggle();
    selectedDate = tambahan.value ? DateTime.now() : lastMonday;
    if (!tambahan.value) {
      selectedTime = DateFormat.jm().format(DateTime.now());
    }
    update(['date', 'time']);
  }

  Future<ApiReturnValue<bool>> submit(String task, bool tambahan, DateTime date,
      {String? jam}) async {
    if (tambahan) {
      if (date.add(const Duration(hours: 9, minutes: 59, seconds: 59)).isAfter(
          DateTime(today.year, today.month, today.day)
              .subtract(const Duration(days: 1))
              .add(const Duration(hours: 10)))) {
        if (date.isAfter(DateTime.now())) {
          return ApiReturnValue(
              value: false,
              message:
                  "Tidak bisa menambahkan tambahan todolist setelah hari ini");
        }
        return ApiReturnValue(
          value: true,
          message: "bisa menambahkan tambahan todolist",
        );
      } else {
        return ApiReturnValue(
          value: false,
          message: "tidak bisa menambahkan sudah melebihi jam 10",
        );
      }
    }
    return ApiReturnValue(value: true, message: "Bisa input todo");
  }

  @override
  void onInit() {
    lastMonday = DateTime.now()
        .add(const Duration(days: 7))
        .subtract(Duration(days: DateTime.now().weekday - 1));
    selectedTime = DateFormat.jm().format(DateTime.now());
    selectedDate = lastMonday;
    super.onInit();
  }

  @override
  void onClose() {
    task.dispose();
    super.onClose();
  }
}
