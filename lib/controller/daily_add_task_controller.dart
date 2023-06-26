part of 'controllers.dart';

class DailyAddTaskController extends GetxController {
  final DailyModel? daily;
  final homePageController = Get.find<HomePageController>();

  DailyAddTaskController({
    this.daily,
  });

  String selectedTime = DateFormat.jm().format(DateTime.now());
  DateTime? selectedDate;
  RxBool tambahan = false.obs;
  late DateTime today = DateTime.now();
  late List<UserModel> users;
  late TextEditingController taskText, valuePlan;
  RxBool isLoading = true.obs;
  List<DailyModel> dailys = [];
  RxBool button = true.obs;
  RxBool isResult = false.obs;
  List<UserModel> tempUsers = [];
  List<UserModel> selectedPerson = [];
  List<UserModel> selectedSendPerson = [];

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

  void dailyResult() {
    isResult.toggle();
    if (isResult.value) {
      tempUsers = users.where((element) => element.dailyResult!).toList();
    } else {
      tempUsers = users;
    }
    update(['tag', 'pic']);
  }

  Future<ApiReturnValue<bool>> submit() async {
    if (taskText.text.length < 3 || taskText.text.isEmpty) {
      return ApiReturnValue(
        value: false,
        message: "Kolom task harus di isi minimal 3 karakter",
      );
    }

    final daily = DailyRequestModel(
      task: taskText.text,
      date: selectedDate ?? DateTime.now(),
      isPlan: !tambahan.value,
      tag: selectedPerson,
      send: selectedSendPerson,
      tipe: isResult.value ? 'RESULT' : 'NON',
      id: this.daily?.id,
      time: tambahan.value ? null : selectedTime,
      valuePlan: int.tryParse(valuePlan.text),
    );

    final response = await DailyService.submit(dailyRequestModel: daily);

    if (!response.value!) {
      return ApiReturnValue(value: false, message: response.message);
    }

    tambahan.value = false;
    taskText.clear();
    selectedDate = selectedDate ?? DateTime.now();
    selectedTime = selectedTime;
    isResult.value = false;
    valuePlan.clear();
    selectedPerson.clear();
    selectedSendPerson.clear();
    tempUsers = users;

    update(['tag', 'pic']);

    return ApiReturnValue(value: true, message: response.message);
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

    //INISIALISASI RESULT VALUE_PLAN
    valuePlan = daily == null
        ? TextEditingController()
        : TextEditingController(text: daily!.valuePlan.toString());

    selectedTime = daily == null
        ? DateFormat.jm().format(DateTime.now())
        : (daily!.time == null
            ? DateFormat.jm().format(DateTime.now())
            : daily!.time!);
    selectedDate = daily == null ? getDate(DateTime.now()) : daily!.date;

    //INISIALISASI IS RESULT
    isResult = daily == null
        ? false.obs
        : daily!.tipe == 'RESULT'
            ? true.obs
            : false.obs;

    await tag().then((value) {
      users = value.value!;
      tempUsers = users;
      isLoading.toggle();
      update(['tag', 'pic']);
    });

    getDaily(selectedDate!);
    super.onInit();
  }

  @override
  void onClose() async {
    await homePageController.getUser();
    taskText.dispose();
    super.onClose();
  }
}
