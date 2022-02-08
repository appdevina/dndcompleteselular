part of 'widgets.dart';

class CardMonthly extends GetView<MonthlyController> {
  final int index;
  final MonthlyModel monthly;
  const CardMonthly({required this.index, required this.monthly, Key? key})
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
                    "MONTHLY ${monthly.type! == 'NON' ? "NON RESULT" : "RESULT"} ${monthly.isPlan! ? '' : '(Extra Task)'}",
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
                        ? await controller
                            .changeStatus(controller.selectedMonthYear.month,
                                monthly.id!, monthly.type!)
                            .then((value) =>
                                snackbar(context, value.value!, value.message!))
                        : _inputDialog(
                            context,
                            monthly.id!,
                            monthly.month!,
                            monthly.type!,
                            controller
                                .formatNumber(monthly.valPlan!.toString()),
                            monthly.task!,
                          ),
                    child: Container(
                      alignment: Alignment.center,
                      width: 30,
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: controller.getColor(monthly.type!, monthly)),
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
        'Apakah anda yakin menghapus\n"${monthly.task}"',
        style: blackFontStyle3,
      ),
      actions: [
        TextButton(
            onPressed: () {
              snackbar(context, false, "Menghapus ${monthly.task}");
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
            "Value Plan : $value",
            style: blackFontStyle2,
            textAlign: TextAlign.center,
          ),
          MyInputField(
            title: "Value Actual",
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
