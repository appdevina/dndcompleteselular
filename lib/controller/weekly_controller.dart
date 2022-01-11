part of 'controllers.dart';

class WeeklyController extends GetxController {
  PageController pageController = PageController();
  late int selectedWeek;
  late DateTime lastMonday;
  int? weeks;
  DateTime selectedDate = DateTime.now();

  List<String> week = [];

  int numOfWeeks(DateTime now) {
    int numberWeek = int.parse(DateFormat("D").format(now));
    return ((numberWeek - now.weekday + 10) / 7).floor();
  }

  void changeDate(DateTime time) {
    selectedDate = time;
    update(['month']);
  }

  void changeWeek(int val) {
    selectedWeek = val;
    print(selectedWeek);
    update(['month']);
  }

  @override
  void onInit() {
    for (var i = 1; i <= 52; i++) {
      week.add("$i");
    }
    selectedWeek = numOfWeeks(DateTime.now());
    weeks = selectedWeek;
    super.onInit();
  }
}
