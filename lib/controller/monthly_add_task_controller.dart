part of 'controllers.dart';

class MonthlyAddTaskController extends GetxController {
  final MonthlyModel? monthly;
  MonthlyAddTaskController({this.monthly});
  final GlobalKey key = GlobalKey<FormState>();
  late TextEditingController title;
  late MoneyMaskedTextController valueCon;
  late DateTime selectedMonth, minMonth, maxMonth;
  RxBool isResult = false.obs;
  RxBool tambahan = false.obs;
  RxBool button = true.obs;
  List<MonthlyModel> monthlys = [];
  final homePageController = Get.find<HomePageController>();
  RxBool isLoading = true.obs;
  late List<UserModel> users;
  List<UserModel> tempUsers = [];
  List<UserModel> selectedPerson = [];
  List<UserModel> selectedSendPerson = [];

  void changeMonth(DateTime val) {
    selectedMonth = val;
    update(['month']);
  }

  String formatNumber(String s) => NumberFormat.decimalPattern('ID').format(
        int.parse(s),
      );

  void changeTambahan() {
    tambahan.toggle();
    minMonth = tambahan.value &&
            DateTime.now().isBefore(
                DateTime(DateTime.now().year, DateTime.now().month)
                    .add(const Duration(days: 5)))
        ? DateTime(DateTime.now().year, DateTime.now().month)
        : DateTime(DateTime.now().year, DateTime.now().month - 1);
    maxMonth = tambahan.value
        ? DateTime.now().isAfter(
                DateTime(DateTime.now().year, DateTime.now().month)
                    .add(const Duration(days: 5)))
            ? DateTime.now()
            : minMonth.add(const Duration(days: 30))
        : DateTime(2025, 12);
    selectedMonth = minMonth;
    update(['month']);
  }

  Future<ApiReturnValue<List<MonthlyModel>>> getMonthlyObjective(
          DateTime month) async =>
      await MonthlyServices.getMonthly(month);

  Future<ApiReturnValue<bool>> submit() async {
    if (title.text.isEmpty || title.text.length < 3) {
      ApiReturnValue(
        value: false,
        message: 'Kolom task harus di isi minimal 3 karakter',
      );
    }
    if (isResult.value && (valueCon.text == '0' || valueCon.text.isEmpty)) {
      ApiReturnValue(
        value: false,
        message: 'Jika result isi kolom nominal result',
      );
    }

    final monthly = MonthlyRequestModel(
      task: title.text,
      monthYear: selectedMonth,
      type: isResult.value ? 'RESULT' : 'NON',
      valPlan: int.tryParse(valueCon.text.replaceAll('.', '')),
      isAdd: tambahan.value,
      isUpdate: false,
      id: this.monthly?.id,
      tag: selectedPerson,
      send: selectedSendPerson,
    );

    final response = await MonthlyServices.submit(monthlyRequestModel: monthly);

    if (!response.value!) {
      return ApiReturnValue(value: false, message: response.message);
    }

    title.clear();
    valueCon.text = '0';
    tambahan.value = false;
    isResult.value = false;
    selectedPerson.clear();
    selectedSendPerson.clear();
    tempUsers = users.where((element) => element.monthlyNon!).toList();
    update(['tag', 'pic']);
    await getMonthlyObjective(selectedMonth)
        .then((value) => monthlys = value.value!);
    update(['monthly']);

    return ApiReturnValue(value: true, message: response.message);
  }

  Future<ApiReturnValue<List<UserModel>>> tag() async {
    ApiReturnValue<List<UserModel>> result = await UserServices.tag();

    return result;
  }

  void monthlyResult() {
    isResult.toggle();
    if (isResult.value) {
      tempUsers = users.where((element) => element.monthlyResult!).toList();
    } else {
      tempUsers = users.where((element) => element.monthlyNon!).toList();
    }
    update(['tag', 'pic']);
  }

  @override
  void onInit() async {
    super.onInit();
    DateTime now = DateTime.now();
    title = monthly == null
        ? TextEditingController()
        : TextEditingController(text: monthly!.task);
    valueCon = MoneyMaskedTextController(
        initialValue: monthly == null
            ? 0.0
            : monthly!.valPlan == null
                ? 0.0
                : monthly!.valPlan!.toDouble(),
        precision: 0,
        thousandSeparator: '.',
        decimalSeparator: '');
    minMonth = DateTime(2022, 4);
    selectedMonth =
        monthly == null ? DateTime(now.year, now.month) : monthly!.monthYear!;
    maxMonth = DateTime(2025, 12);
    isResult = monthly == null
        ? false.obs
        : monthly!.type == 'RESULT'
            ? true.obs
            : false.obs;

    await tag().then((value) {
      users = value.value!;
      tempUsers = users.where((element) => element.monthlyNon!).toList();
      isLoading.toggle();
      update(['tag', 'pic']);
    });

    await getMonthlyObjective(selectedMonth)
        .then((value) => monthlys = value.value!);
    update(['monthly']);
  }

  @override
  void onClose() {
    title.dispose();
    valueCon.dispose();
    super.onClose();
  }
}
