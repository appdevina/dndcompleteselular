part of 'screens.dart';

class ResultBody extends StatefulWidget {
  const ResultBody({Key? key}) : super(key: key);

  @override
  State<ResultBody> createState() => _ResultBodyState();
}

class _ResultBodyState extends State<ResultBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TabBar(
            unselectedLabelColor: greyColor,
            indicator: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    width: 0.5, color: greyColor, style: BorderStyle.solid),
              ),
            ),
            unselectedLabelStyle:
                blackFontStyle3.copyWith(color: white, fontSize: 12),
            labelColor: white,
            tabs: const [
              Tab(
                text: 'Daily',
              ),
              Tab(
                text: 'Weekly',
              ),
              Tab(
                text: 'Monthly',
              ),
            ],
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          Expanded(
            child: GetBuilder<ResultController>(
              id: 'result',
              builder: (_) => TabBarView(
                physics: const PageScrollPhysics(),
                children: [
                  ResultDaily(),
                  ResultWeekly(),
                  ResultMonthly(),
                ],
                controller: _tabController,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
