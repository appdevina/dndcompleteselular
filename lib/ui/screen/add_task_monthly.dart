part of 'screens.dart';

class AddTaskMonthly extends StatelessWidget {
  final controller = Get.arguments == null
      ? Get.put(MonthlyAddTaskController())
      : Get.put(MonthlyAddTaskController(monthly: Get.arguments));
  final HomePageController homePageController = Get.find<HomePageController>();
  final DateTime? month;

  AddTaskMonthly({Key? key, this.month}) : super(key: key);

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
                                      if (controller.monthly == null) {
                                        controller.isResult.toggle();
                                      }
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
                                              margin: const EdgeInsets.only(
                                                  left: 10),
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
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(right: 10, top: 10),
              child: Obx(
                () => MyButton(
                    label: controller.monthly != null ? "Update" : "+ Add",
                    onTap: controller.button.value
                        ? () async {
                            if (month == null) {
                              controller.button.toggle();
                              FocusScope.of(context).requestFocus(FocusNode());
                              await controller
                                  .submit(
                                      isUpdate: controller.monthly == null
                                          ? false
                                          : true,
                                      id: controller.monthly == null
                                          ? null
                                          : controller.monthly!.id,
                                      extraTask: controller.tambahan.value,
                                      taskVal: controller.title.text,
                                      date: controller.selectedMonth,
                                      isResultVal: controller.isResult.value,
                                      resultValueText: controller.isResult.value
                                          ? controller.valueCon.value.text
                                              .replaceAll('.', '')
                                          : null)
                                  .then((value) {
                                controller.button.toggle();
                                if (controller.monthly != null) {
                                  Get.back();
                                }
                                if (value.value!) {
                                  final con = Get.find<MonthlyController>();
                                  controller.title.clear();
                                  controller.tambahan.value = false;
                                  controller.isResult.value = false;
                                  controller.valueCon.clear();
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
                                type: controller.isResult.value
                                    ? 'RESULT'
                                    : 'NON',
                                valPlan: controller.isResult.value
                                    ? controller.valueCon.value.text
                                        .replaceAll('.', '')
                                        .toInt()
                                    : null,
                                statNon:
                                    controller.isResult.value ? null : false,
                                statRes:
                                    controller.isResult.value ? false : null,
                                valAct: controller.isResult.value ? 0 : null,
                                isUpdate: true,
                                isAdd: false,
                              );
                              con
                                  .addTaskChange(monthlyModel: monthly)
                                  .then((value) {
                                snackbar(
                                    context, value, 'Berhasil menambahkan');
                                Get.back();
                              });
                            }
                          }
                        : () => null,
                    height: 50,
                    width: 100),
              ),
            ),
            controller.monthly != null || month != null
                ? const SizedBox()
                : Expanded(
                    child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
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
                  ))
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
        'Add Monthly ${month == null ? "Objective" : "Change"}',
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
