part of 'controllers.dart';

class MonthlyController extends GetxController {
  DateTime now = DateTime.now();
  int? selectedMonth = DateFormat.M().format(DateTime.now()).toInt();

  List<Map<String, dynamic>> month = [
    {
      'no': 1,
      'bulan': 'JAN',
    },
    {
      'no': 2,
      'bulan': 'FEB',
    },
    {
      'no': 3,
      'bulan': 'MAR',
    },
    {
      'no': 4,
      'bulan': 'APR',
    },
    {
      'no': 5,
      'bulan': 'MAY',
    },
    {
      'no': 6,
      'bulan': 'JUN',
    },
    {
      'no': 7,
      'bulan': 'JUL',
    },
    {
      'no': 8,
      'bulan': 'AUG',
    },
    {
      'no': 9,
      'bulan': 'SEP',
    },
    {
      'no': 10,
      'bulan': 'OKT',
    },
    {
      'no': 11,
      'bulan': 'NOV',
    },
    {
      'no': 12,
      'bulan': 'DEC',
    },
  ];

  void changeMonth(int val) {
    selectedMonth = val;
    update(['month']);
  }
}
