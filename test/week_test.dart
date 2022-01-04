import 'package:week_of_year/week_of_year.dart';

void main() {
  final date = DateTime(2021, 12, 21);
  print(date.weekOfYear); // Get the iso week of year
  print(date.ordinalDate); // Get the ordinal date
  print(date.isLeapYear); // Is this a leap year?
}
