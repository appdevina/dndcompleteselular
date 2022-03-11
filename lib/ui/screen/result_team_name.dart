part of 'screens.dart';

class ResultTeamName extends GetView<ResultController> {
  const ResultTeamName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      'List semua team\nmuncul semua disini',
      textAlign: TextAlign.center,
      style: blackFontStyle1.copyWith(color: white),
    ));
  }
}
