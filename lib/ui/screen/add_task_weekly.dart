part of 'screens.dart';

class AddTaskWeekly extends StatelessWidget {
  final controller = Get.arguments == null
      ? Get.put(WeeklyAddTaskController())
      : Get.put(
          WeeklyAddTaskController(
            weekly: Get.arguments,
          ),
        );
  final HomePageController homePageController = Get.find<HomePageController>();
  final int? week;
  final int? year;
  final bool isToUser;
  AddTaskWeekly({
    Key? key,
    this.week,
    this.year,
    this.isToUser = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar(),
      body: ListView(
        //KENAPA ADA CONTROLLER.KEY -> untuk Form
        key: controller.key,
        children: [
          controller.weekly == null && week == null
              ? Row(
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
                )
              : const SizedBox(),
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
          controller.weekly == null || controller.weekly!.type == 'RESULT'
              ? Container(
                  height: homePageController.user.weeklyResult! ? 110 : 0,
                  alignment: Alignment.center,
                  child: homePageController.user.weeklyResult!
                      ? Row(
                          children: [
                            Obx(
                              () => Checkbox(
                                  fillColor: MaterialStateProperty.all(white),
                                  checkColor: Colors.green,
                                  value: controller.isResult.value,
                                  onChanged: (bool? val) {
                                    // if (controller.weekly == null) {
                                    //   controller.isResult.toggle();
                                    // }
                                    controller.weeklyResult();
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          MyInputField(
                                              typeInput: TextInputType.number,
                                              controllerText:
                                                  controller.resultValue,
                                              side: true,
                                              title: "",
                                              hint: 'Input Value',
                                              isPassword: false),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              "nominal",
                                              style: blackFontStyle3.copyWith(
                                                  color: white),
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
                        )
                      : const SizedBox(),
                )
              : const SizedBox(),
          controller.weekly == null && week != null
              ? const SizedBox()
              : isToUser
                  ? const SizedBox()
                  : GetBuilder<WeeklyAddTaskController>(
                      id: 'tag',
                      builder: (_) => controller.isLoading.value
                          ? const SizedBox()
                          : controller.weekly != null
                              ? const SizedBox()
                              : _tag(),
                    ),
          if (isToUser)
            GetBuilder<WeeklyAddTaskController>(
              id: 'pic',
              builder: (_) => controller.isLoading.value
                  ? const SizedBox()
                  : controller.weekly != null
                      ? const SizedBox()
                      : _pic(),
            ),
          Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(right: 10, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(
                  () => MyButton(
                    height: 50,
                    width: 100,
                    label: controller.weekly != null ? "Update" : "+ Add",
                    onTap: controller.button.value
                        ? () async {
                            if (week == null) {
                              controller.button.toggle();
                              FocusScope.of(context).requestFocus(FocusNode());
                              await controller.submit().then((value) {
                                controller.button.toggle();

                                if (controller.weekly != null) {
                                  Get.back();
                                }
                                final con = Get.find<WeeklyController>();
                                if (controller.selectedWeek ==
                                        con.selectedWeek &&
                                    controller.selectedYear ==
                                        con.selectedYear) {
                                  con.getWeekObjective(
                                      con.selectedYear, con.selectedWeek,
                                      isloading: true);
                                }
                                controller.getWeekObjective(
                                    controller.selectedYear,
                                    controller.selectedWeek);
                                snackbar(context, value.value!, value.message!);
                              });
                            } else {
                              final con = Get.find<RequestTaskController>();
                              WeeklyModel weekly = WeeklyModel(
                                task: controller.task.text,
                                type: controller.isResult.value
                                    ? 'RESULT'
                                    : 'NON',
                                week: week,
                                year: year,
                                statNon:
                                    controller.isResult.value ? null : false,
                                statRes:
                                    controller.isResult.value ? false : null,
                                valPlan: controller.isResult.value
                                    ? controller.resultValue.value.text
                                        .replaceAll('.', '')
                                        .toInt()
                                    : null,
                                valAct: controller.isResult.value ? 0 : null,
                                isAdd: false,
                                isUpdate: true,
                              );
                              con
                                  .addTaskChange(weeklyModel: weekly)
                                  .then((value) {
                                snackbar(
                                    context, value, 'Berhasil menambahkan');
                                Get.back();
                              });
                            }
                          }
                        : () {},
                  ),
                ),
              ],
            ),
          ),
          controller.weekly != null || week != null
              ? const SizedBox()
              : Container(
                  height: 300,
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: white),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: GetBuilder<WeeklyAddTaskController>(
                      id: 'weekly',
                      builder: (_) => ListView.builder(
                            itemBuilder: ((context, index) => CardWeeklyAdd(
                                  index: index,
                                  weekly: controller.weeklys[index],
                                )),
                            itemCount: controller.weeklys.length,
                          )),
                ),
        ],
        // ),
      ),
    );
  }

  Container _tag() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          MultiSelectDialogField<UserModel>(
            buttonIcon: const Icon(
              MdiIcons.arrowLeftBottom,
              color: white,
            ),
            listType: MultiSelectListType.CHIP,
            searchable: true,
            buttonText: Text(
              "Tag Weekly To :",
              style: blackFontStyle3.copyWith(color: white),
            ),
            title: Text("Nama", style: blackFontStyle3),
            items: controller.tempUsers
                .where(
                    (e) => e.divisi!.id == homePageController.user.divisi!.id)
                .map((e) => MultiSelectItem<UserModel>(
                    e, "${e.namaLengkap!} - ${e.divisi!.nama}"))
                .toList(),
            onConfirm: (values) {
              controller.selectedPerson = values;
              controller.update(['tag']);
            },
            chipDisplay: MultiSelectChipDisplay(
              chipColor: white,
              textStyle: blackFontStyle3.copyWith(color: "22577E".toColor()),
              onTap: (value) {
                controller.selectedPerson.remove(value);
                controller.update(['tag']);
              },
            ),
          ),
          controller.selectedPerson.isEmpty
              ? Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "None selected tag",
                    style: blackFontStyle3.copyWith(color: white),
                  ))
              : Container(),
        ],
      ),
    );
  }

  Container _pic() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          MultiSelectDialogField<UserModel>(
            buttonIcon: const Icon(
              MdiIcons.arrowLeftBottom,
              color: white,
            ),
            listType: MultiSelectListType.CHIP,
            searchable: true,
            buttonText: Text(
              "Send Weekly To :",
              style: blackFontStyle3.copyWith(color: white),
            ),
            title: Text("Nama", style: blackFontStyle3),
            items: controller.tempUsers
                .where(
                    (e) => e.divisi!.id == homePageController.user.divisi!.id)
                .map((e) => MultiSelectItem<UserModel>(
                    e, "${e.namaLengkap!} - ${e.divisi!.nama}"))
                .toList(),
            onConfirm: (values) {
              controller.selectedSendPerson = values;
              controller.update(['pic']);
            },
            chipDisplay: MultiSelectChipDisplay(
              chipColor: white,
              textStyle: blackFontStyle3.copyWith(color: "22577E".toColor()),
              onTap: (value) {
                controller.selectedSendPerson.remove(value);
                controller.update(['pic']);
              },
            ),
          ),
          controller.selectedSendPerson.isEmpty
              ? Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "None selected tag",
                    style: blackFontStyle3.copyWith(color: white),
                  ))
              : Container(),
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
          color: white,
        ),
      ),
      elevation: 0,
      centerTitle: true,
      title: Text(
        '${controller.weekly == null ? "Add" : "Edit"} Weekly ${week == null ? "Objective" : "Change"}',
        style: blackFontStyle3.copyWith(color: white),
      ),
    );
  }

  _pickWeek(BuildContext context, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: blackFontStyle3.copyWith(color: white),
        ),
        _week(context),
      ],
    );
  }

  _week(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          controller.weekly == null && week == null
              ? IconButton(
                  onPressed: () => controller.buttonWeek(false)
                      ? null
                      : snackbar(context, false,
                          "Tidak bisa kurang dari week ${controller.minWeek}"),
                  icon: const Icon(
                    MdiIcons.minusCircle,
                    color: white,
                  ),
                )
              : const SizedBox(width: 40),
          Container(
            width: 50,
            padding: EdgeInsets.only(
                left: controller.week.text.length > 1 &&
                        controller.week.text.toInt()! < 20
                    ? 15
                    : 8,
                bottom: 3),
            child: controller.weekly == null && week == null
                ? TextField(
                    keyboardType: TextInputType.number,
                    onSubmitted: (val) {
                      if (val.isNotEmpty) {
                        if (val.toInt()! < controller.minWeek) {
                          snackbar(context, false,
                              "Tidak bisa kurang dari week ${controller.minWeek}");
                          controller.selectedWeek = controller.minWeek;
                          controller.week.text = controller.minWeek.toString();
                          controller.changeWeek(controller.selectedWeek);
                        } else if (val.toInt()! > controller.maxWeek) {
                          snackbar(context, false,
                              "Tidak bisa lebih dari ${controller.maxWeek}");
                          controller.selectedWeek = controller.minWeek;
                          controller.week.text = controller.minWeek.toString();
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
                    style: blackFontStyle1.copyWith(color: white, fontSize: 30),
                  )
                : Text(
                    '${controller.weekly == null ? week : controller.weekly!.week}',
                    style:
                        blackFontStyle1.copyWith(color: white, fontSize: 30)),
          ),
          controller.weekly == null && week == null
              ? IconButton(
                  onPressed: () => controller.buttonWeek(true)
                      ? null
                      : snackbar(context, false,
                          "Tidak bisa lebih dari week ${controller.maxWeek}"),
                  icon: const Icon(
                    MdiIcons.plusCircle,
                    color: white,
                  ))
              : const SizedBox(width: 20),
        ],
      ),
    );
  }

  _pickYear(BuildContext context, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: blackFontStyle3.copyWith(color: white),
        ),
        _year(context),
      ],
    );
  }

  _year(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          controller.weekly == null && year == null
              ? IconButton(
                  onPressed: () => controller.buttonYear(false)
                      ? null
                      : snackbar(context, false,
                          "Tidak bisa kurang dari tahun ${controller.minyear}"),
                  icon: const Icon(
                    MdiIcons.minusCircle,
                    color: white,
                  ))
              : const SizedBox(width: 30),
          Container(
            width: 70,
            padding: const EdgeInsets.only(bottom: 3),
            child: controller.weekly == null && year == null
                ? TextField(
                    keyboardType: TextInputType.number,
                    onSubmitted: (val) {
                      if (val.isNotEmpty) {
                        if (val.toInt()! < controller.minyear) {
                          snackbar(context, false,
                              "Tidak bisa kurang dari tahun ${controller.minyear}");
                          controller.selectedYear = controller.minyear;
                          controller.year.text = controller.minyear.toString();
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
                    style: blackFontStyle1.copyWith(color: white, fontSize: 30),
                  )
                : Text(
                    '${controller.weekly != null ? controller.weekly!.year : year}',
                    style:
                        blackFontStyle1.copyWith(color: white, fontSize: 30)),
          ),
          controller.weekly == null && year == null
              ? IconButton(
                  onPressed: () => controller.buttonYear(true),
                  icon: const Icon(
                    MdiIcons.plusCircle,
                    color: white,
                  ))
              : const SizedBox(width: 20),
        ],
      ),
    );
  }
}
