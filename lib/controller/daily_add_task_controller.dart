part of 'controllers.dart';

class DailyAddTaskController extends GetxController {
  final DailyModel? daily;

  DailyAddTaskController({
    this.daily,
  });

  String selectedTime = DateFormat.jm().format(DateTime.now());
  DateTime? selectedDate, lastMonday;
  RxBool tambahan = false.obs;
  late DateTime today = DateTime.now();
  late List<UserModel> users;
  List<Object?> selectedPerson = [];
  late TextEditingController taskText;
  RxBool isLoading = true.obs;

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
    update(['date', 'time', 'tag']);
  }

  Future<ApiReturnValue<bool>> submit({
    required String task,
    required DateTime date,
    required bool isAdd,
    String? time,
    int? id,
    required List<Object?> tags,
  }) async {
    if (task.length < 3 || task.isEmpty) {
      return ApiReturnValue(
        value: false,
        message: "Kolom task harus di isi minimal 3 karakter",
      );
    }

    ApiReturnValue<bool> result = await DailyService.submit(
      task: task,
      date: date,
      isAdd: isAdd,
      time: time,
      id: id,
      tag: tags,
    ).then((value) {
      if (value.value!) {
        taskText.clear();
        selectedPerson.clear();
        update(['date', 'time', 'tag']);
        if (isAdd) {
          changeTambahan();
        }
      }
      return value;
    });

    return result;
  }

  Future<ApiReturnValue<List<UserModel>>> tag() async {
    ApiReturnValue<List<UserModel>> result = await UserServices.tag();

    return result;
  }

  getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  getMonday(DateTime d) => getDate(d.subtract(Duration(days: d.weekday - 1)));

  getNextWeek(DateTime d) => getDate(getMonday(d).add(const Duration(days: 7)));

  @override
  void onInit() async {
    taskText = daily == null
        ? TextEditingController()
        : TextEditingController(text: daily!.task);
    final con = Get.find<HomePageController>();
    lastMonday = con.user.area!.id == 2 &&
            DateTime.now().isBefore(getMonday(DateTime.now())
                .add(const Duration(days: 1, hours: 10)))
        ? getMonday(DateTime.now())
        : DateTime.now().isBefore(
                getMonday(DateTime.now()).add(const Duration(hours: 17)))
            ? getMonday(DateTime.now())
            : getNextWeek(DateTime.now());
    selectedTime =
        daily == null ? DateFormat.jm().format(DateTime.now()) : daily!.time!;
    selectedDate = daily == null ? lastMonday : daily!.date;

    await tag().then((value) {
      users = value.value!;
      isLoading.toggle();
      update(['tag']);
    });
    super.onInit();
  }

  @override
  void onClose() {
    taskText.dispose();
    super.onClose();
  }
}
