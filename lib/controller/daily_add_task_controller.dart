part of 'controllers.dart';

class DailyAddTaskController extends GetxController {
  final DailyModel? daily;

  DailyAddTaskController({
    this.daily,
  });

  String selectedTime = DateFormat.jm().format(DateTime.now());
  DateTime? selectedDate;
  RxBool tambahan = false.obs;
  late DateTime today = DateTime.now();
  late List<UserModel> users;
  List<Object?> selectedPerson = [];
  late TextEditingController taskText;
  RxBool isLoading = true.obs;
  List<DailyModel> dailys = [];
  RxBool button = true.obs;

  void changeDate(DateTime val) {
    selectedDate = val;
    getDaily(selectedDate!);
    update(['date', 'daily']);
  }

  void changeTime(String val) {
    selectedTime = val;
    update(['time']);
  }

  void changeTambahan() {
    tambahan.toggle();
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

  void getDaily(DateTime time, {bool? isloading}) async {
    await DailyService.getDaily(DateFormat('y-MM-dd').format(time))
        .then((value) => dailys = value.value!);
    update(['daily']);
  }

  getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  @override
  void onInit() async {
    taskText = daily == null
        ? TextEditingController()
        : TextEditingController(text: daily!.task);
    selectedTime =
        daily == null ? DateFormat.jm().format(DateTime.now()) : daily!.time!;
    selectedDate = daily == null ? getDate(DateTime.now()) : daily!.date;

    await tag().then((value) {
      users = value.value!;
      isLoading.toggle();
      update(['tag']);
    });

    getDaily(selectedDate!);
    super.onInit();
  }

  @override
  void onClose() {
    taskText.dispose();
    super.onClose();
  }
}
