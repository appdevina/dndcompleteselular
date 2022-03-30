part of 'widgets.dart';

class CardWeekly extends GetView<WeeklyController> {
  final int index;
  final WeeklyModel weekly;
  const CardWeekly({required this.index, required this.weekly, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(
        () => AddTaskWeekly(),
        arguments: weekly,
        transition: Transition.cupertino,
      ),
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
                child: Text(
                  "${index + 1}",
                  textAlign: TextAlign.center,
                  style: blackFontStyle1,
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "WEEKLY ${weekly.type! == 'NON' ? "NON RESULT" : "RESULT"} ${!weekly.isAdd! ? '' : '(Extra Task)'}",
                        style: blackFontStyle2.copyWith(
                            wordSpacing: 1,
                            fontSize: 10,
                            color: greyColor,
                            fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Tooltip(
                        message: weekly.task!.toUpperCase(),
                        showDuration: const Duration(milliseconds: 500),
                        verticalOffset: -60,
                        textStyle: blackFontStyle3.copyWith(
                          color: white,
                        ),
                        decoration: BoxDecoration(
                            color: "22577E".toColor(),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: white)),
                        child: Text(
                          "${weekly.task!.toUpperCase()} ${weekly.type != "NON" ? controller.formatNumber(weekly.valPlan!.toString()) : ""}",
                          maxLines: 1,
                          style: blackFontStyle2.copyWith(
                              wordSpacing: 1,
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  GetBuilder<WeeklyController>(
                    id: 'inputvalue',
                    builder: (_) => InkWell(
                      onTap: () async => weekly.type == "NON"
                          ? await controller
                              .changeStatus(
                                id: weekly.id!,
                              )
                              .then((value) => snackbar(
                                  context, value.value!, value.message!))
                          : _inputDialog(context, weekly.id!,
                              weekly.valPlan!.toString(), weekly.task!,
                              valueActual: weekly.valAct.toString()),
                      child: Container(
                        alignment: Alignment.center,
                        width: 30,
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: controller.getColor(weekly)),
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
        'Apakah anda yakin menghapus\n"${weekly.task}"',
        style: blackFontStyle3,
      ),
      actions: [
        TextButton(
            onPressed: () => controller.delete(weekly.id!).then((value) {
                  Get.back();
                  snackbar(context, value.value!, value.message!);
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
            title: "",
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
                        id: id,
                        value: int.parse(controller.valueResult.value.text
                            .replaceAll('.', '')))
                    .then((_) =>
                        snackbar(context, true, "berhasil input result value"));
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
