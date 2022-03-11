part of 'screens.dart';

class Request extends StatefulWidget {
  const Request({Key? key}) : super(key: key);

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final controller = Get.put(RequestTaskController());

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
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
                  text: 'Request',
                ),
                Tab(
                  text: 'History',
                ),
              ],
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
            Expanded(
              child: GetBuilder<RequestTaskController>(
                id: 'result',
                builder: (_) => TabBarView(
                  physics: const PageScrollPhysics(),
                  children: const [
                    RequestTask(),
                    RequestHistory(),
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

  _appBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          CupertinoIcons.back,
          color: white,
        ),
      ),
      elevation: 0,
      centerTitle: true,
      title: Text(
        'Change Task',
        style: blackFontStyle3.copyWith(color: white),
      ),
    );
  }
}
