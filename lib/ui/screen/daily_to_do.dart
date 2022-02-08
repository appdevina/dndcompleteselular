part of 'screens.dart';

class DailyTodo extends StatelessWidget {
  final controller = Get.put(DailyController());
  DailyTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
        child: Column(
          children: [
            _addDateBar(),
            GetBuilder<DailyController>(
              id: 'daily',
              builder: (_) => Expanded(
                child: controller.loading.value
                    ? Shimmer.fromColors(
                        child: _listToDo(10),
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
          color: white,
        ),
      ),
      elevation: 0,
      centerTitle: true,
      title: Text(
        'Daily To Do List',
        style: blackFontStyle3.copyWith(
          color: white,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () =>
              Get.to(() => AddTaskDaily(), transition: Transition.cupertino),
          icon: const Icon(
            MdiIcons.plus,
            color: white,
          ),
          iconSize: 18,
        ),
        IconButton(
          onPressed: () => controller.changeDate(controller.selectedDate),
          icon: const Icon(
            MdiIcons.refresh,
            color: white,
          ),
          iconSize: 16,
        )
      ],
    );
  }

  _addDateBar() {
    return CalendarTimeline(
      initialDate: DateTime.now(),
      firstDate: DateTime(2022, 1, 1),
      lastDate: DateTime(2030, 12, 31),
      onDateSelected: (date) => controller.changeDate(date!),
      leftMargin: 20,
      monthColor: "F6F2D4".toColor(),
      dayColor: greyColor,
      activeDayColor: Colors.black,
      activeBackgroundDayColor: white,
      dotsColor: const Color(0xFF333A47),
      locale: 'en_ISO',
    );
  }

  _listToDo(int lenght, {List<DailyModel>? daily}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: daily != null && daily.isEmpty
          ? Center(
              child: Text(
                "Tidak ada to do\n ${DateFormat('d MMMM y').format(controller.selectedDate)}",
                style: blackFontStyle2.copyWith(color: white),
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemBuilder: (context, index) => daily != null
                  ? CardDaily(
                      daily: controller.daily![index],
                    )
                  : Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 0.2, color: greyColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                      child: Container(
                        alignment: Alignment.center,
                        height: 60,
                        width: double.infinity,
                        padding: const EdgeInsetsDirectional.only(bottom: 10),
                      ),
                    ),
              itemCount: lenght,
            ),
    );
  }
}
