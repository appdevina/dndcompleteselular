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
        : DateTime(DateTime.now().year, DateTime.now().month + 1);
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

  Future<ApiReturnValue<bool>> submit({
    required bool isUpdate,
    required bool extraTask,
    required String taskVal,
    required DateTime date,
    required bool isResultVal,
    String? resultValueText,
    int? id,
  }) async =>
      taskVal.isEmpty || taskVal.length < 3
          ? ApiReturnValue(
              value: false,
              message: 'Kolom task harus di isi minimal 3 karakter',
            )
          : isResultVal && (resultValueText == '0' || resultValueText!.isEmpty)
              ? ApiReturnValue(
                  value: false,
                  message: 'Jika result isi kolom nominal result',
                )
              : await MonthlyServices.submit(
                  isUpdate: isUpdate,
                  extraTask: extraTask,
                  task: taskVal,
                  date: date,
                  isResult: isResultVal,
                  resultValue: resultValueText,
                  id: id,
                ).then((value) async {
                  await getMonthlyObjective(selectedMonth)
                      .then((value) => monthlys = value.value!);
                  update(['monthly']);
                  return value;
                });

  @override
  void onInit() async {
    DateTime now = DateTime.now();
    title = monthly == null
        ? TextEditingController()
        : TextEditingController(text: monthly!.task);
    valueCon = MoneyMaskedTextController(
        initialValue: monthly == null
            ? 0
            : monthly!.valPlan == null
                ? 0
                : monthly!.valPlan!.toDouble(),
        precision: 0,
        thousandSeparator: '.',
        decimalSeparator: '');
    minMonth =
        now.isBefore(DateTime(now.year, now.month).add(const Duration(days: 5)))
            ? now
            : DateTime(now.year, now.month + 1);
    selectedMonth = monthly == null ? minMonth : monthly!.monthYear!;
    maxMonth = DateTime(2025, 12);
    isResult = monthly == null
        ? false.obs
        : monthly!.type == 'RESULT'
            ? true.obs
            : false.obs;
    await getMonthlyObjective(selectedMonth)
        .then((value) => monthlys = value.value!);
    update(['monthly']);
    super.onInit();
  }

  @override
  void onClose() {
    title.dispose();
    valueCon.dispose();
    super.onClose();
  }
}
