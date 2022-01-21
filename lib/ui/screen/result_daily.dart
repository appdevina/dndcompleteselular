part of 'screens.dart';

class ResultDaily extends StatelessWidget {
  const ResultDaily({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _piechart(context),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _cardDetail("Total Task", '30', context),
                  _cardDetail("Achievement", '90%', context),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _cardDetail("Actual", '27', context),
                  _cardDetail("Total Point", '36', context),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  _piechart(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width / 1.5,
      child: PieChart(
        PieChartData(
          sections: [
            _pieData(90, "Closed\n90%", Colors.green[400]!, 14),
            _pieData(10, "OPEN\n10%", Colors.red[400]!, 12),
          ],
        ),
      ),
    );
  }

  _pieData(double value, String title, Color color, double fontSize) {
    return PieChartSectionData(
        value: value,
        title: title,
        titlePositionPercentageOffset: -0.8,
        color: color,
        titleStyle: blackFontStyle3.copyWith(color: white, fontSize: fontSize));
  }

  _cardDetail(String title, String value, BuildContext context) {
    return SizedBox(
      height: 90,
      width: MediaQuery.of(context).size.width / 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              color: Colors.grey[500],
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: blackFontStyle3.copyWith(color: white, fontSize: 16),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style:
                  blackFontStyle3.copyWith(color: Colors.white70, fontSize: 22),
            ),
          ),
        ],
      ),
    );
  }
}
