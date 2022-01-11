part of 'screens.dart';

class WeeklyToDo extends StatelessWidget {
  final controller = Get.put(WeeklyController());
  WeeklyToDo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
        child: Column(
          children: [
            GetBuilder<WeeklyController>(
              id: 'month',
              builder: (_) => _addWeek(context),
            ),
            Expanded(
              child: _listToDo(20),
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
        'Weekly ToDo',
        style: blackFontStyle3.copyWith(color: white),
      ),
      actions: [
        IconButton(
          onPressed: () =>
              Get.to(() => AddTaskWeekly(), transition: Transition.cupertino),
          icon: const Icon(
            MdiIcons.plus,
            color: white,
          ),
          iconSize: 18,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            MdiIcons.refresh,
            color: white,
          ),
          iconSize: 18,
        )
      ],
    );
  }

  _addWeek(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width - 20,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                "95D1CC".toColor(),
                "F6F2D4".toColor(),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
            borderRadius: BorderRadiusDirectional.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "WEEK",
              style: blackFontStyle3.copyWith(letterSpacing: 2),
            ),
            NumberPicker(
                itemWidth: 60,
                minValue: 1,
                axis: Axis.horizontal,
                maxValue: 52,
                itemCount: 5,
                selectedTextStyle:
                    blackFontStyle1.copyWith(color: Colors.blue[400]),
                decoration: BoxDecoration(
                    border: Border.all(color: greyColor),
                    borderRadius: BorderRadiusDirectional.circular(10)),
                value: controller.selectedWeek,
                textStyle: blackFontStyle3.copyWith(color: greyColor),
                onChanged: (int value) => controller.changeWeek(value)),
          ],
        ));
  }

  _listToDo(int lenght) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
        itemBuilder: (context, index) => GestureDetector(
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            borderOnForeground: false,
            shadowColor: white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            elevation: 10,
            color: primaryClr,
            child: ListTile(
              title: Text(
                "TODO YANG KE ${index.toString()}",
                overflow: TextOverflow.ellipsis,
                style: blackFontStyle2.copyWith(color: white, fontSize: 18),
              ),
              subtitle: Text(
                "ini untuk jam : ${index.toString()} AM/PM",
                style: blackFontStyle2.copyWith(color: white),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        itemCount: lenght,
        padding: const EdgeInsetsDirectional.only(bottom: 10),
      ),
    );
  }
}
