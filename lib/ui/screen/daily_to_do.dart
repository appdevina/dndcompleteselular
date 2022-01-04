part of 'screens.dart';

class DailyTodo extends StatelessWidget {
  final controller = Get.put(DailyController());
  DailyTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: _appBar(),
      body: SafeArea(
        child: Column(
          children: [
            _addTaskBar(),
            _addDateBar(),
            GetBuilder<DailyController>(
              id: 'daily',
              builder: (_) => Expanded(
                child: controller.loading.value
                    ? Shimmer.fromColors(
                        child: _listToDo(6),
                        highlightColor: Colors.grey[300]!,
                        baseColor: Colors.grey[100]!,
                      )
                    : _listToDo(
                        controller.daily!.length,
                        daily: controller.daily,
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
          color: Colors.black,
        ),
      ),
      backgroundColor: white,
      elevation: 0,
      centerTitle: true,
      title: Text(
        'Daily Todo',
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
                DateFormat.yMMMMd().format(
                  DateTime.now(),
                ),
                style: blackFontStyle1,
              ),
              Text(
                "Today",
                style: greyFontStyle.copyWith(fontSize: 30),
              ),
            ],
          ),
          MyButton(
            height: 50,
            width: 120,
            label: "+ Add Task",
            onTap: () => Get.to(
              () => AddTaskDaily(),
              transition: Transition.cupertino,
            ),
          )
        ],
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 15),
      child: DatePicker(
        controller.lastMonday.subtract(const Duration(days: 2)),
        height: 100,
        width: 70,
        initialSelectedDate: DateTime.now(),
        selectedTextColor: white,
        selectionColor: primaryClr,
        dateTextStyle: blackFontStyle2.copyWith(
            fontSize: 20, color: Colors.grey, fontWeight: FontWeight.w600),
        dayTextStyle: blackFontStyle2.copyWith(
          fontSize: 12,
          color: Colors.grey,
          fontWeight: FontWeight.w600,
        ),
        onDateChange: (DateTime val) {
          controller.changeDate(val);
        },
        daysCount: 14,
      ),
    );
  }

  _listToDo(int lenght, {List<DailyModel>? daily}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: daily != null && daily.isEmpty
          ? Center(
              child: Text(
                "Tidak ada to do\n ${DateFormat('d MMMM y').format(controller.selectedDate)}",
                style: blackFontStyle2,
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemBuilder: (context, index) => daily != null
                  ? CardDaily(
                      index: index,
                    )
                  : Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 0.2, color: greyColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                      child: Container(
                        alignment: Alignment.center,
                        height: 125,
                        width: double.infinity,
                        padding: const EdgeInsetsDirectional.only(bottom: 10),
                      ),
                    ),
              itemCount: lenght,
            ),
    );
  }
}
