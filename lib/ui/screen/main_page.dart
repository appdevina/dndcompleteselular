// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

part of 'screens.dart';

class MainPage extends StatelessWidget {
  final controller = Get.put(MainPageController());
  final List<Widget> screen = [
    HomePage(),
    const AchievementPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<MainPageController>(
        id: 'page',
        builder: (_) => SafeArea(
          child: screen.elementAt(controller.index),
        ),
      ),
      bottomNavigationBar: GetBuilder<MainPageController>(
        id: 'page',
        builder: (_) => BottomNavigationBar(
          backgroundColor: Colors.grey[300],
          enableFeedback: true,
          selectedFontSize: 12,
          selectedIconTheme: IconThemeData(color: Colors.blue[400]),
          selectedLabelStyle: blackFontStyle3.copyWith(color: Colors.black),
          unselectedLabelStyle: blackFontStyle3.copyWith(color: Colors.black),
          elevation: 20,
          items: <BottomNavigationBarItem>[
            _bottomNavBarItem(MdiIcons.home, 'Home'),
            _bottomNavBarItem(MdiIcons.calendarMultipleCheck, 'Achievment'),
            // _bottomNavBarItem(MdiIcons.accountCircle, 'Profile'),
          ],
          currentIndex: controller.index,
          selectedItemColor: Colors.blue[400],
          onTap: (int val) {
            controller.changeIndex(val);
          },
        ),
      ),
    );
  }

  BottomNavigationBarItem _bottomNavBarItem(IconData icon, String title) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: title,
      tooltip: title,
    );
  }
}
