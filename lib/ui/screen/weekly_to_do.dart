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
              id: 'week',
              builder: (_) => _addWeek(context),
            ),
            Expanded(
              child: GetBuilder<WeeklyController>(
                id: 'weekly',
                builder: (_) => controller.isLoading.value
                    ? Shimmer.fromColors(
                        child: _listToDo(10),
                        highlightColor: Colors.grey[300]!,
                        baseColor: Colors.grey[100]!,
                      )
                    : _listToDo(controller.weekly.length,
                        weekly: controller.weekly),
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
        'Weekly Objective',
        style: blackFontStyle3.copyWith(color: white),
      ),
      actions: [
        IconButton(
          onPressed: () =>
              Get.to(() => CopyWeekly(), transition: Transition.cupertino),
          icon: const Icon(
            MdiIcons.contentCopy,
            color: white,
          ),
          iconSize: 16,
        ),
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
          onPressed: () => controller.changeWeek(controller.selectedWeek),
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
      color: "22577E".toColor(),
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: [
          Column(
            children: [
              _week(context),
              _year(context),
            ],
          ),
          Expanded(
            child: SizedBox(
              child: Obx(
                () => Text(
                  controller.date.value,
                  textAlign: TextAlign.center,
                  style: blackFontStyle1.copyWith(
                      letterSpacing: 2, color: "b6defa".toColor()),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _listToDo(int lenght, {List<WeeklyModel>? weekly}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: weekly != null && weekly.isEmpty
          ? Center(
              child: Text(
                "Tidak ada to do\n week ${controller.selectedWeek} tahun ${controller.selectedYear}",
                style: blackFontStyle2.copyWith(color: white),
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemBuilder: (context, index) => weekly != null
                  ? CardWeekly(
                      index: index,
                      weekly: controller.weekly[index],
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

  _week(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 50,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () => controller.buttonWeek(false)
                          ? null
                          : snackbar(context, false,
                              "Tidak bisa kurang dari week ${controller.minWeek}"),
                      icon: const Icon(
                        MdiIcons.minusCircle,
                        color: white,
                      )),
                  Container(
                    decoration: BoxDecoration(
                        // border: Border.all(width: 1, color: white),
                        borderRadius: BorderRadius.circular(10)),
                    width: 50,
                    height: 50,
                    padding: EdgeInsets.only(
                        left: controller.weekNumber.text.length > 1 ? 10 : 16,
                        bottom: 3),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onSubmitted: (val) {
                        if (val.isNotEmpty) {
                          if (val.toInt()! < 1) {
                            snackbar(
                                context, false, "Tidak bisa kurang dari 1");
                            controller.selectedWeek = 1;
                            controller.weekNumber.text = "1";
                            controller.changeWeek(controller.selectedWeek);
                          } else if (val.toInt()! > 52) {
                            snackbar(
                                context, false, "Tidak bisa lebih dari 52");
                            controller.selectedWeek = 52;
                            controller.weekNumber.text = "52";
                            controller.changeWeek(controller.selectedWeek);
                          } else {
                            controller.changeWeek(val.toInt()!);
                          }
                        }
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      controller: controller.weekNumber,
                      style:
                          blackFontStyle1.copyWith(color: white, fontSize: 30),
                    ),
                  ),
                  IconButton(
                      onPressed: () => controller.buttonWeek(true),
                      icon: const Icon(
                        MdiIcons.plusCircle,
                        color: white,
                      )),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  _year(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 50,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () => controller.buttonYear(false)
                          ? null
                          : snackbar(context, false,
                              "Tidak bisa kurang dari tahun ${controller.minyear}"),
                      icon: const Icon(
                        MdiIcons.minusCircle,
                        color: white,
                      )),
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    width: 50,
                    height: 50,
                    padding: const EdgeInsets.only(left: 8, bottom: 3),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      onSubmitted: (val) {
                        if (val.isNotEmpty) {
                          if (val.toInt()! < controller.minyear) {
                            snackbar(context, false,
                                "Tidak bisa kurang dari tahun ${controller.minyear}");
                            controller.selectedYear = 2022;
                            controller.yearNumber.text = "2022";
                            controller.changeWeek(controller.selectedYear);
                          } else {
                            controller.changeWeek(val.toInt()!);
                          }
                        }
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      controller: controller.yearNumber,
                      style:
                          blackFontStyle1.copyWith(color: white, fontSize: 15),
                    ),
                  ),
                  IconButton(
                      onPressed: () => controller.buttonYear(true),
                      icon: const Icon(
                        MdiIcons.plusCircle,
                        color: white,
                      )),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
