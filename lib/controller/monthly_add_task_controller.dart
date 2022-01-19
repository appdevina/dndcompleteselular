part of 'controllers.dart';

class MonthlyAddTaskController extends GetxController {
  final GlobalKey key = GlobalKey<FormState>();
  late TextEditingController title;
  late MoneyMaskedTextController valueCon;
  late DateTime selectedMonth, minMonth;
  RxBool check = false.obs;

  void changeMonth(DateTime val) {
    selectedMonth = val;
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
    super.onInit();
  }
}
