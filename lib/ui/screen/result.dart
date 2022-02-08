part of 'screens.dart';

class Result extends StatefulWidget {
  Result({Key? key}) : super(key: key);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final controller = Get.put(ResultController());

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            CupertinoIcons.back,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        title: Obx(
          () => Text(
            "Point KPI : ${controller.totalKpi}",
            style: blackFontStyle3.copyWith(color: white),
          ),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 5),
            width: 130,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(MdiIcons.minusCircle),
                  iconSize: 18,
                ),
                Text(
                  "52",
                  style: blackFontStyle1.copyWith(color: white),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(MdiIcons.plusCircle),
                  iconSize: 18,
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
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
              child: TabBarView(
                physics: const PageScrollPhysics(),
                children: const [
                  ResultDaily(),
                  ResultWeekly(),
                  ResultMonthly(),
                ],
                controller: _tabController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
