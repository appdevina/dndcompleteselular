part of 'widgets.dart';

class CardWeekly extends GetView<WeeklyController> {
  final int index;
  final WeeklyModel weekly;
  const CardWeekly({required this.index, required this.weekly, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                height: 30,
                width: 30,
                child: Icon(
                  MdiIcons.calendarMonth,
                  size: 30,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "WEEKLY ${weekly.type! == 'NON' ? "NON RESULT" : "RESULT"}",
                    style: blackFontStyle2.copyWith(
                        wordSpacing: 1,
                        fontSize: 12,
                        color: greyColor,
                        fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "${weekly.task!.toUpperCase()} ${weekly.type != "NON" ? controller.formatNumber(weekly.valPlan!.toString()) : ""}",
                    style: blackFontStyle2.copyWith(
                      wordSpacing: 1,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                GetBuilder<WeeklyController>(
                  id: 'inputvalue',
                  builder: (_) => InkWell(
                    onTap: () async => weekly.type == "NON"
                        ? await controller
                            .changeStatus(controller.selectedWeek, weekly.id!,
                                weekly.type!)
                            .then((value) =>
                                snackbar(context, value.value!, value.message!))
                        : _inputDialog(
                            context,
                            weekly.id!,
                            weekly.week!,
                            weekly.type!,
                            weekly.valPlan!.toString(),
                            weekly.task!),
                    child: Container(
                      alignment: Alignment.center,
                      width: 30,
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: controller.getColor(weekly.type!, weekly)),
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
            onPressed: () {
              snackbar(context, false, "Menghapus ${weekly.task}");
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

  _inputDialog(BuildContext context, int id, int week, String type,
      String value, String title) {
    return Get.bottomSheet(Container(
      decoration: const BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      width: double.infinity,
      height: 230,
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          Text(
            "Plan : $title",
            style: blackFontStyle2,
            textAlign: TextAlign.center,
          ),
          Text(
            "Value Plan : ${controller.formatNumber(value)}",
            style: blackFontStyle2,
            textAlign: TextAlign.center,
          ),
          MyInputField(
            title: "",
            hint: "Value Actual",
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
                    .changeStatus(week, id, type,
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
