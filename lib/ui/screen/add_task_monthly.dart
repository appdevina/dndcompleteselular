part of 'screens.dart';

class AddTaskMonthly extends StatelessWidget {
  final controller = Get.arguments == null
      ? Get.put(MonthlyAddTaskController())
      : Get.put(
          MonthlyAddTaskController(
            monthly: Get.arguments,
          ),
        );
  final HomePageController homePageController = Get.find<HomePageController>();
  final DateTime? month;
  final bool isToUser;

  AddTaskMonthly({
    Key? key,
    this.month,
    this.isToUser = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar(),
      body: ListView(
        key: controller.key,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          controller.monthly == null && month == null
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
                                  "Hanya bisa menambahkan monthly kemarin dan sekarang, untuk monthly kemarin batas maksimal H+5 bulan baru",
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
            hint: "Monthly Objective",
            controllerText: controller.title,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            height: 90,
            margin: const EdgeInsets.only(top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Month",
                  style: blackFontStyle3.copyWith(color: white),
                ),
                _pickMonth(context),
              ],
            ),
          ),
          controller.monthly == null || controller.monthly!.type == 'RESULT'
              ? Container(
                  height: homePageController.user.monthlyResult! ? 115 : 0,
                  alignment: Alignment.center,
                  child: homePageController.user.monthlyResult!
                      ? Row(
                          children: [
                            Obx(
                              () => Checkbox(
                                  value: controller.isResult.value,
                                  fillColor: MaterialStateProperty.all(white),
                                  checkColor: Colors.green,
                                  onChanged: (bool? val) {
                                    // if (controller.monthly == null) {
                                    //   controller.isResult.toggle();
                                    // }
                                    controller.monthlyResult();
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
                                                  controller.valueCon,
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
          controller.monthly != null
              ? const SizedBox()
              : isToUser
                  ? const SizedBox()
                  : GetBuilder<MonthlyAddTaskController>(
                      id: 'tag',
                      builder: (_) => controller.isLoading.value
                          ? const SizedBox()
                          : controller.monthly != null
                              ? const SizedBox()
                              : _tag(),
                    ),
          if (isToUser)
            GetBuilder<MonthlyAddTaskController>(
              id: 'pic',
              builder: (_) => controller.isLoading.value
                  ? const SizedBox()
                  : controller.monthly != null
                      ? const SizedBox()
                      : _pic(),
            ),
          Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(right: 10, top: 10),
            child: Obx(
              () => MyButton(
                height: 50,
                width: 100,
                label: controller.monthly != null ? "Update" : "+ Add",
                onTap: controller.button.value
                    ? () async {
                        if (month == null) {
                          controller.button.toggle();
                          FocusScope.of(context).requestFocus(FocusNode());
                          await controller.submit().then((value) {
                            controller.button.toggle();
                            if (controller.monthly != null) {
                              Get.back();
                            }
                            if (value.value!) {
                              final con = Get.find<MonthlyController>();
                              controller.title.clear();
                              controller.tambahan.value = false;
                              controller.isResult.value = false;
                              controller.valueCon.text = '0';
                              con.getMonthlyObjective(con.selectedMonthYear,
                                  isloading: true);
                            }
                            snackbar(context, value.value!, value.message!);
                          });
                        } else {
                          final con = Get.find<RequestTaskController>();
                          MonthlyModel monthly = MonthlyModel(
                            task: controller.title.text,
                            monthYear: month,
                            type: controller.isResult.value ? 'RESULT' : 'NON',
                            valPlan: controller.isResult.value
                                ? controller.valueCon.value.text
                                    .replaceAll('.', '')
                                    .toInt()
                                : null,
                            statNon: controller.isResult.value ? null : false,
                            statRes: controller.isResult.value ? false : null,
                            valAct: controller.isResult.value ? 0 : null,
                            isUpdate: true,
                            isAdd: false,
                          );
                          con
                              .addTaskChange(monthlyModel: monthly)
                              .then((value) {
                            snackbar(context, value, 'Berhasil menambahkan');
                            Get.back();
                          });
                        }
                      }
                    : () {},
              ),
            ),
          ),
          controller.monthly != null || month != null
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
                  child: GetBuilder<MonthlyAddTaskController>(
                      id: 'monthly',
                      builder: (_) => ListView.builder(
                            itemBuilder: ((context, index) => CardMonthlyAdd(
                                  index: index,
                                  monthly: controller.monthlys[index],
                                )),
                            itemCount: controller.monthlys.length,
                          )),
                )
        ],
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
              "Tag Monthly To :",
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
              "Send Monthly To :",
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
        '${controller.monthly != null ? "Edit" : "Add"} Monthly ${month == null ? "Objective" : "Change"}',
        style: blackFontStyle3.copyWith(color: white),
      ),
    );
  }

  _pickMonth(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              child: GetBuilder<MonthlyAddTaskController>(
                id: 'month',
                builder: (_) => Text(
                    DateFormat('MMMM  -  y')
                        .format(month ?? controller.selectedMonth),
                    style: blackFontStyle1.copyWith(color: white),
                    textAlign: TextAlign.center),
              ),
            ),
          ),
          controller.monthly == null && month == null
              ? MyButton(
                  height: 40,
                  width: 100,
                  label: "CHANGE",
                  onTap: () => showMonthPicker(
                    context: context,
                    initialDate: controller.selectedMonth,
                    firstDate: controller.minMonth,
                    lastDate: controller.maxMonth,
                  ).then((value) =>
                      value != null ? controller.changeMonth(value) : null),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
