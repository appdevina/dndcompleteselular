part of 'controllers.dart';

class MonthlyAddTaskController extends GetxController {
  final GlobalKey key = GlobalKey<FormState>();
  late TextEditingController title;
  late MoneyMaskedTextController valueCon;
  late DateTime selectedMonth, minMonth, maxMonth;
  RxBool check = false.obs;
  RxBool tambahan = false.obs;

  void changeMonth(DateTime val) {
    selectedMonth = val;
    update(['month']);
  }

  void changeTambahan() {
    tambahan.toggle();
    minMonth = tambahan.value
        ? DateTime.now().isAfter(
                DateTime(DateTime.now().year, DateTime.now().month)
                    .add(const Duration(days: 5)))
            ? DateTime.now().add(const Duration(days: 30))
            : DateTime.now().subtract(const Duration(days: 30))
        : DateTime.now().add(const Duration(days: 30));
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

  @override
  void onInit() {
    title = TextEditingController();
    valueCon = MoneyMaskedTextController(
        initialValue: 0,
        precision: 0,
        thousandSeparator: '.',
        decimalSeparator: '');
    minMonth = DateTime.now().add(const Duration(days: 30));
    selectedMonth = minMonth;
    maxMonth = DateTime(2025, 12);
    super.onInit();
  }

  @override
  void onClose() {
    title.dispose();
    valueCon.dispose();
    super.onClose();
  }
}
