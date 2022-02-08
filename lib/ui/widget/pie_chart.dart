part of 'widgets.dart';

class PieCharResult extends StatelessWidget {
  final double closed, open;
  const PieCharResult({Key? key, required this.closed, required this.open})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width / 1.5,
      child: PieChart(
        PieChartData(
          sectionsSpace: 8,
          sections: [
            _pieData(closed, "Closed", Colors.green[500]!, 14),
            _pieData(open, "Open", Colors.red[500]!, 12),
          ],
        ),
      ),
    );
  }

  _pieData(
    double value,
    String title,
    Color color,
    double fontSize,
  ) {
    return PieChartSectionData(
        value: value,
        title: title,
        borderSide: BorderSide(color: greyColor),
        titlePositionPercentageOffset: -0.8,
        color: color,
        titleStyle: blackFontStyle3.copyWith(color: white, fontSize: fontSize));
  }
}
