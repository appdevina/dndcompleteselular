part of 'screens.dart';

class MonthlyToDo extends StatelessWidget {
  final controller = Get.put(MonthlyController());
  MonthlyToDo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: _appBar(),
      body: Column(
        children: [
          _addTaskBar(),
          GetBuilder<MonthlyController>(
            id: 'month',
            builder: (_) => _monthBar(),
          ),
          Expanded(
            child: _listToDo(10),
          ),
        ],
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
          color: Colors.black,
        ),
      ),
      backgroundColor: white,
      elevation: 0,
      centerTitle: true,
      title: Text(
        'Monthly To Do',
        style: blackFontStyle3,
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            MdiIcons.refresh,
            color: Colors.black,
          ),
        )
      ],
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(right: 20, left: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Now ${DateFormat.MMMM().format(controller.now)}",
                style: blackFontStyle1,
              ),
              Text(
                DateFormat.yMMMMd().format(
                  DateTime.now(),
                ),
                style: greyFontStyle.copyWith(fontSize: 16),
              ),
            ],
          ),
          MyButton(
            height: 50,
            width: 120,
            label: "+ Add Task",
            onTap: () => Get.to(
              () => AddTaskMonthly(),
              transition: Transition.cupertino,
            ),
          )
        ],
      ),
    );
  }

  _monthBar() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.only(left: 10),
      height: 100,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: controller.month
            .map(
              (e) => GestureDetector(
                onTap: () => controller.changeMonth(e['no']),
                child: Container(
                  decoration: BoxDecoration(
                    color: e['no'] == controller.selectedMonth
                        ? primaryClr
                        : Colors.grey[200],
                    borderRadius: const BorderRadiusDirectional.all(
                      Radius.circular(10),
                    ),
                  ),
                  margin: const EdgeInsets.only(right: 10),
                  alignment: Alignment.center,
                  width: 75,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        e['bulan'],
                        style: e['no'] == controller.selectedMonth
                            ? blackFontStyle1.copyWith(color: white)
                            : blackFontStyle1,
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
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
