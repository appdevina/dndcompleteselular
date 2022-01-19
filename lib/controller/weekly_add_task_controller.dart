part of 'controllers.dart';

class WeeklyAddTaskController extends GetxController {
  final GlobalKey key = GlobalKey<FormState>();
  late TextEditingController title, week, year;
  late int selectedWeek, selectedYear, minWeek, minyear;
  RxBool check = false.obs;
  late MoneyMaskedTextController valueCon;

  void changeWeek(int val) {
    selectedWeek = val;
  }

  void changeYear(int val) {
    selectedYear = val;
  }

  bool buttonWeek(bool isAdd) {
    if (isAdd) {
      if (selectedWeek == 52) {
        null;
        return false;
      } else {
        selectedWeek++;
        week.text = selectedWeek.toString();
        changeWeek(selectedWeek);
        update(['week']);
        return true;
      }
    } else {
      if (week.text.toInt()! < minWeek + 1) {
        null;
        return false;
      } else {
        selectedWeek--;
        week.text = selectedWeek.toString();
        changeWeek(selectedWeek);
        update(['week']);
        return true;
      }
    }
  }

  bool buttonYear(bool isAdd) {
    if (isAdd) {
      selectedYear++;
      year.text = selectedYear.toString();
      changeWeek(selectedYear);
      update(['year']);
      return true;
    } else {
      if (year.text.toInt()! < minyear + 1) {
        null;
        return false;
      } else {
        selectedYear--;
        year.text = selectedYear.toString();
        changeWeek(selectedYear);
        update(['year']);
        return true;
      }
    }
  }

  int numOfWeeks(DateTime now) {
    int numberWeek = int.parse(DateFormat("D").format(now));
    return ((numberWeek - now.weekday + 10) / 7).floor() + 1;
  }

  @override
  void onInit() {
    title = TextEditingController();
    valueCon = MoneyMaskedTextController(
        initialValue: 0,
        precision: 0,
        thousandSeparator: '.',
        decimalSeparator: '');
    week = TextEditingController(text: numOfWeeks(DateTime.now()).toString());
    year = TextEditingController(text: DateTime.now().year.toString());
    selectedWeek = numOfWeeks(DateTime.now());
    selectedYear = DateTime.now().year;
    minWeek = numOfWeeks(DateTime.now());
    minyear = DateTime.now().year;
    super.onInit();
  }

  @override
  void onClose() {
    title.dispose();
    valueCon.dispose();
    super.onClose();
  }
}
