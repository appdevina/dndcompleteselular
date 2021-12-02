part of 'controllers.dart';

class WeeklyController extends GetxController {
  PageController pageController = PageController();
  late int selectedIndexOfMonth;

  List<String> week = [];

  int numOfWeeks(DateTime now) {
    int numberWeek = int.parse(DateFormat("D").format(now));
    return ((numberWeek - now.weekday + 10) / 7).floor();
  }

  void changeWeek(int val) {
    selectedIndexOfMonth = val;
    update(['month']);
  }

  @override
  void onInit() {
    for (var i = 1; i <= 52; i++) {
      week.add("$i");
    }
    selectedIndexOfMonth = numOfWeeks(DateTime.now());
    super.onInit();
  }
}
