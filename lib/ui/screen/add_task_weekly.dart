part of 'screens.dart';

class AddTaskWeekly extends StatelessWidget {
  final controller = Get.put(WeeklyAddTaskController());
  AddTaskWeekly({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar(),
      body: Form(
        key: controller.key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Obx(
                  () => Checkbox(
                      fillColor: MaterialStateProperty.all(white),
                      checkColor: Colors.green,
                      value: controller.tambahan.value,
                      onChanged: (_) {
                        if (_!) {
                          snackbar(context, false,
                              "Hanya bisa menambahkan weekly minggu kemarin dan minggu ini, untuk weekly kemarin batas maksimal input Senin week baru jam 10 Pagi",
                              duration: 6000);
                        }
                        controller.changeTambahan();
                      }),
                ),
                Text(
                  "Extra Task ?",
                  style: blackFontStyle3.copyWith(color: white),
                )
              ],
            ),
            MyInputField(
              isPassword: false,
              title: "Your Task",
              hint: "Weekly Objective",
              controllerText: controller.task,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GetBuilder<WeeklyAddTaskController>(
                  id: 'week',
                  builder: (_) => _pickWeek(context, 'Week'),
                ),
                GetBuilder<WeeklyAddTaskController>(
                  id: 'year',
                  builder: (_) => _pickYear(context, 'Year'),
                ),
              ],
            ),
            Container(
              height: 110,
              alignment: Alignment.center,
              child: Row(
                children: [
                  Obx(
                    () => Checkbox(
                        fillColor: MaterialStateProperty.all(white),
                        checkColor: Colors.green,
                        value: controller.isResult.value,
                        onChanged: (bool? val) {
                          controller.isResult.toggle();
                        }),
                  ),
                  Text(
                    "Result ?",
                    style: blackFontStyle3.copyWith(color: white),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Obx(
                    () => controller.isResult.value
                        ? Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyInputField(
                                    typeInput: TextInputType.number,
                                    controllerText: controller.resultValue,
                                    side: true,
                                    title: "",
                                    hint: 'Input Value',
                                    isPassword: false),
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "nominal",
                                    style:
                                        blackFontStyle3.copyWith(color: white),
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(right: 10, top: 10),
              child: MyButton(
                  label: "Submit",
                  onTap: () async => await controller
                      .submit(
                          extraTask: controller.tambahan.value,
                          taskVal: controller.task.text,
                          week: controller.selectedWeek,
                          year: controller.selectedYear,
                          isResultVal: controller.isResult.value,
                          resultValueText: controller.isResult.value
                              ? controller.resultValue.value.text
                                  .replaceAll('.', '')
                              : null)
                      .then((value) =>
                          snackbar(context, value.value!, value.message!)),
                  height: 50,
                  width: 100),
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
        'Add Weekly Objective',
        style: blackFontStyle3.copyWith(color: white),
      ),
    );
  }

  _pickWeek(BuildContext context, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: blackFontStyle3.copyWith(color: white),
          ),
          _week(context),
        ],
      ),
    );
  }

  _week(BuildContext context) {
    return Row(children: [
      SizedBox(
        width: 150,
        height: 75,
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
                          borderRadius: BorderRadius.circular(10)),
                      width: 50,
                      height: 50,
                      padding: EdgeInsets.only(
                          left: controller.week.text.length > 1 ? 8 : 14,
                          bottom: 3),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onSubmitted: (val) {
                          if (val.isNotEmpty) {
                            if (val.toInt()! < controller.minWeek) {
                              snackbar(context, false,
                                  "Tidak bisa kurang dari week ${controller.minWeek}");
                              controller.selectedWeek = controller.minWeek;
                              controller.week.text =
                                  controller.minWeek.toString();
                              controller.changeWeek(controller.selectedWeek);
                            } else if (val.toInt()! > controller.maxWeek) {
                              snackbar(context, false,
                                  "Tidak bisa lebih dari ${controller.maxWeek}");
                              controller.selectedWeek = controller.minWeek;
                              controller.week.text =
                                  controller.minWeek.toString();
                              controller.changeWeek(controller.selectedWeek);
                            } else {
                              controller.changeWeek(val.toInt()!);
                            }
                            controller.update(['week']);
                          }
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        controller: controller.week,
                        style: blackFontStyle1.copyWith(
                            color: white, fontSize: 30),
                      ),
                    ),
                    IconButton(
                        onPressed: () => controller.buttonWeek(true)
                            ? null
                            : snackbar(context, false,
                                "Tidak bisa lebih dari week ${controller.maxWeek}"),
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
      )
    ]);
  }

  _pickYear(BuildContext context, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: blackFontStyle3.copyWith(color: white),
          ),
          _year(context),
        ],
      ),
    );
  }

  _year(BuildContext context) {
    return Row(children: [
      SizedBox(
        width: 200,
        height: 75,
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
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      width: 100,
                      height: 50,
                      padding: const EdgeInsets.only(left: 16, bottom: 3),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onSubmitted: (val) {
                          if (val.isNotEmpty) {
                            if (val.toInt()! < controller.minyear) {
                              snackbar(context, false,
                                  "Tidak bisa kurang dari tahun ${controller.minyear}");
                              controller.selectedYear = controller.minyear;
                              controller.year.text =
                                  controller.minyear.toString();
                              controller.changeYear(controller.selectedYear);
                            } else {
                              controller.changeYear(val.toInt()!);
                            }
                            controller.update(['year']);
                          }
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        controller: controller.year,
                        style: blackFontStyle1.copyWith(
                            color: white, fontSize: 30),
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
      )
    ]);
  }
}
