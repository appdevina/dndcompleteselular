part of 'screens.dart';

class AddTaskMonthly extends StatelessWidget {
  final controller = Get.put(MonthlyAddTaskController());
  AddTaskMonthly({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: false,
      appBar: _appBar(),
      body: Form(
        key: controller.key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Add Task',
                style: blackFontStyle1,
              ),
            ),
            MyInputField(
              isPassword: false,
              title: "Todo",
              hint: "input todo",
              controllerText: controller.title,
            ),
            DropDownMonth(
              title: 'Month',
              controller: controller,
              month: controller.month,
            ),
            Container(
              height: 100,
              alignment: Alignment.center,
              child: Row(
                children: [
                  Obx(
                    () => Checkbox(
                        value: controller.check.value,
                        onChanged: (bool? val) {
                          controller.check.toggle();
                        }),
                  ),
                  Text(
                    "Result ?",
                    style: blackFontStyle3,
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
                                    controllerText: controller.value,
                                    side: true,
                                    title: "",
                                    hint: 'Input Value',
                                    isPassword: false),
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "nominal",
                                    style: blackFontStyle3,
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
        'Add Monthly',
        style: blackFontStyle3,
      ),
    );
  }
}