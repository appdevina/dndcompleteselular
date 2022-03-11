part of 'widgets.dart';

class CardMonthly extends GetView<MonthlyController> {
  final int index;
  final MonthlyModel monthly;
  const CardMonthly({required this.index, required this.monthly, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => AddTaskMonthly(),
          transition: Transition.cupertino, arguments: monthly),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.2, color: greyColor),
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 10,
        child: Container(
          alignment: Alignment.center,
          height: 60,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: 30,
                width: 30,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/task.png',
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "MONTHLY ${monthly.type! == 'NON' ? "NON RESULT" : "RESULT"} ${!monthly.isAdd! ? '' : '(Extra Task)'}",
                      style: blackFontStyle2.copyWith(
                          wordSpacing: 1,
                          fontSize: 10,
                          color: greyColor,
                          fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SelectableText(
                      monthly.task!.toUpperCase(),
                      style: blackFontStyle2.copyWith(
                        wordSpacing: 1,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  GetBuilder<MonthlyController>(
                    id: 'inputvalue',
                    builder: (_) => InkWell(
                      onTap: () async => monthly.type == "NON"
                          ? await controller.changeStatus(id: monthly.id!).then(
                              (value) => snackbar(
                                  context, value.value!, value.message!))
                          : _inputDialog(
                              context,
                              monthly.id!,
                              monthly.valPlan.toString(),
                              monthly.task!,
                              valueActual: monthly.valAct.toString(),
                            ),
                      child: Container(
                        alignment: Alignment.center,
                        width: 30,
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: controller.getColor(monthly)),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => showDialog<String>(
                        context: context,
                        builder: (context) => _dialogDelete(context)),
                    child: Container(
                      alignment: Alignment.center,
                      width: 30,
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.red[400]),
                      child: const Icon(
                        Icons.delete_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _dialogDelete(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Hapus",
        style: blackFontStyle1,
      ),
      content: Text(
        'Apakah anda yakin menghapus\n"${monthly.task}"',
        style: blackFontStyle3,
      ),
      actions: [
        TextButton(
            onPressed: () async =>
                await controller.delete(monthly.id!).then((value) {
                  snackbar(context, value.value!, value.message!);
                  Get.back();
                }),
            child: Text(
              "YES",
              style: blackFontStyle3.copyWith(color: Colors.green[400]),
            )),
        TextButton(
            onPressed: () => Get.back(),
            child: Text(
              "NO",
              style: blackFontStyle3.copyWith(color: Colors.red[400]),
            )),
      ],
    );
  }

  _inputDialog(BuildContext context, int id, String value, String task,
      {String? valueActual}) {
    return Get.bottomSheet(Container(
      decoration: const BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      width: double.infinity,
      height: 275,
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CardDetailResult(
                title: 'Plan',
                value: controller.formatNumber(value),
              ),
              CardDetailResult(
                title: 'Actual',
                value: valueActual == null
                    ? '0'
                    : controller.formatNumber(valueActual),
              )
            ],
          ),
          MyInputField(
            title: 'Task : ${task.toUpperCase()}',
            textStyle: blackFontStyle3.copyWith(color: Colors.black),
            hint: "Submit Value Actual",
            isPassword: false,
            controllerText: controller.valueResult,
            typeInput: TextInputType.number,
          ),
          MyButton(
              label: "Submit",
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                Get.back();
                await controller
                    .changeStatus(
                      id: monthly.id!,
                      value: int.parse(
                          controller.valueResult.text.replaceAll('.', '')),
                    )
                    .then((_) => snackbar(context, _.value!, _.message!));
                controller.valueResult.clear();
                controller.update(['inputvalue']);
              },
              height: 40,
              width: 60)
        ],
      ),
    ));
  }
}
