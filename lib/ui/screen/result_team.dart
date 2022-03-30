part of 'screens.dart';

class ResultTeamBody extends StatefulWidget {
  final UserModel user;
  const ResultTeamBody({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  State<ResultTeamBody> createState() => _ResultTeamBody();
}

class _ResultTeamBody extends State<ResultTeamBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ResultTeamController controller;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    controller = Get.put(ResultTeamController(user: widget.user));
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
            "Point KPI : ${NumberFormat("###.#", "en_US").format(controller.totalKpi.value)}",
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
                  onPressed: () => controller.changeWeek(isAdd: false),
                  icon: const Icon(MdiIcons.minusCircle),
                  iconSize: 18,
                ),
                Obx(
                  () => Text(
                    controller.week.toString(),
                    style: blackFontStyle1.copyWith(color: white),
                  ),
                ),
                IconButton(
                  onPressed: () => controller.changeWeek(isAdd: true),
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
              child: GetBuilder<ResultTeamController>(
                id: 'result',
                builder: (_) => TabBarView(
                  physics: const PageScrollPhysics(),
                  children: [
                    ResultTeamDaily(),
                    ResultTeamWeekly(),
                    ResultTeamMonthly(),
                  ],
                  controller: _tabController,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
