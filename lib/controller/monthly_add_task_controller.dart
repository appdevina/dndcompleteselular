part of 'controllers.dart';

class MonthlyAddTaskController extends GetxController {
  final GlobalKey key = GlobalKey<FormState>();
  late TextEditingController title, value;
  late int selectedMonth;
  RxBool check = false.obs;
  List<Map<String, dynamic>> month = [
    {
      'no': 1,
      'bulan': 'JANUARY',
    },
    {
      'no': 2,
      'bulan': 'FEBRUARY',
    },
    {
      'no': 3,
      'bulan': 'MARCH',
    },
    {
      'no': 4,
      'bulan': 'APRIL',
    },
    {
      'no': 5,
      'bulan': 'MAY',
    },
    {
      'no': 6,
      'bulan': 'JUNI',
    },
    {
      'no': 7,
      'bulan': 'JULY',
    },
    {
      'no': 8,
      'bulan': 'AUGUST',
    },
    {
      'no': 9,
      'bulan': 'SEPTEMBER',
    },
    {
      'no': 10,
      'bulan': 'OKTOBER',
    },
    {
      'no': 11,
      'bulan': 'NOVEMBER',
    },
    {
      'no': 12,
      'bulan': 'DECEMBER',
    },
  ];

  void changeMonth(int val) {
    selectedMonth = val;
    update(['month']);
  }

  @override
  void onInit() {
    title = TextEditingController();
    value = TextEditingController();
    super.onInit();
  }
}
