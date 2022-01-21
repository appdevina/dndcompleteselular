part of 'screens.dart';

class AddTaskMonthly extends StatelessWidget {
  final controller = Get.put(MonthlyAddTaskController());
  AddTaskMonthly({Key? key}) : super(key: key);

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
            Container(
              height: 115,
              alignment: Alignment.center,
              child: Row(
                children: [
                  Obx(
                    () => Checkbox(
                        value: controller.check.value,
                        fillColor: MaterialStateProperty.all(white),
                        checkColor: Colors.green,
                        onChanged: (bool? val) {
                          controller.check.toggle();
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
                    () => controller.check.value
                        ? Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyInputField(
                                    typeInput: TextInputType.number,
                                    controllerText: controller.valueCon,
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
                  label: "Submit", onTap: () {}, height: 50, width: 100),
            ),
            const Spacer(),
            Obx(() => controller.tambahan.value
                ? Container(
                    padding: const EdgeInsetsDirectional.all(10),
                    height: 20,
                    margin: const EdgeInsetsDirectional.only(bottom: 8),
                    width: double.infinity,
                    child: Text(
                      "*Batas waktu input tambahan monthly sebelumnya (H+5) bulan berikutnya",
                      style:
                          blackFontStyle3.copyWith(color: white, fontSize: 10),
                      overflow: TextOverflow.visible,
                    ),
                  )
                : const SizedBox())
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
        'Add Monthly Objective',
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
                    DateFormat('MMMM  -  y').format(controller.selectedMonth),
                    style: blackFontStyle1.copyWith(color: white),
                    textAlign: TextAlign.center),
              ),
            ),
          ),
          MyButton(
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
        ],
      ),
    );
  }
}
