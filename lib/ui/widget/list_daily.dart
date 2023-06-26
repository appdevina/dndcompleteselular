part of 'widgets.dart';

class CardDaily extends GetView<DailyController> {
  final DailyModel daily;
  final int index;
  const CardDaily({required this.daily, required this.index, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => daily.tag != null || daily.send != null
          ? snackbar(context, false, "Daily tag/send tidak bisa di rubah")
          : Get.to(
              () => AddTaskDaily(),
              arguments: daily,
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
                        "${daily.time ?? 'Extra Task'} ${daily.tag != null ? ' - TAG BY : ${daily.tag!.namaLengkap}' : daily.send != null ? ' - SEND BY : ${daily.send!.namaLengkap}' : ''} ${daily.tipe! == 'NON' ? ' - NON' : ' - RESULT'} ",
                        style: blackFontStyle2.copyWith(
                            wordSpacing: 1,
                            fontSize: 10,
                            color: greyColor,
                            fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Tooltip(
                        message: daily.task!.toUpperCase(),
                        showDuration: const Duration(milliseconds: 500),
                        verticalOffset: -80,
                        textStyle: blackFontStyle3.copyWith(color: white),
                        decoration: BoxDecoration(
                            color: "22577E".toColor(),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: white)),
                        child: Text(
                          " ${daily.task!.toUpperCase()} ${daily.tipe != "NON" ? controller.formatNumber(daily.valuePlan!.toString()) : ""}",
                          style: blackFontStyle2.copyWith(
                            wordSpacing: 1,
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  GetBuilder<DailyController>(
                    id: 'inputvalue',
                    builder: (_) => InkWell(
                      onTap: () async => daily.tipe == "NON"
                          ? await controller
                              .changeStatus(
                                id: daily.id!,
                              )
                              .then((value) => snackbar(
                                  context, value.value!, value.message!))
                          : _inputDialog(context, daily.id!,
                              daily.valuePlan!.toString(), daily.task!,
                              valueActual: daily.valueActual.toString()),
                      child: Container(
                        alignment: Alignment.center,
                        width: 30,
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: controller.getColor(daily)),
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
        'Apakah anda yakin menghapus\n"${daily.task}"',
        style: blackFontStyle3,
      ),
      actions: [
        TextButton(
            onPressed: () async {
              await controller.delete(id: daily.id!).then(
                  (value) => snackbar(context, value.value!, value.message!));
              Get.back();
            },
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

  _inputDialog(BuildContext context, int id, String valuePlan, String task,
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
                value: controller.formatNumber(valuePlan),
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
                controller.valueResult.text == '0';
                controller.update(['inputvalue']);
              },
              height: 40,
              width: 60)
        ],
      ),
    ));
  }
}
