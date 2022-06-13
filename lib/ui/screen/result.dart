part of 'screens.dart';

class Result extends StatefulWidget {
  const Result({Key? key}) : super(key: key);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  final controller = Get.put(ResultController());
  int _selectedIndex = 0;
  List<Widget> view = [const ResultBody(), const ResultTeamName()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
            "Point Week ${controller.week.value} : ${NumberFormat("###.#", "en_US").format(controller.totalKpi.value)}",
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
      body: view[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Individu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Teams',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (int index) => _onItemTapped(index),
        selectedIconTheme: const IconThemeData(size: 14, color: white),
        unselectedIconTheme: const IconThemeData(size: 20, color: Colors.grey),
        selectedLabelStyle: blackFontStyle3.copyWith(color: white),
        fixedColor: white,
        showUnselectedLabels: false,
        selectedFontSize: 12,
        backgroundColor: "22577E".toColor(),
      ),
    );
  }
}
