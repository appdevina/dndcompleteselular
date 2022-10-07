part of 'screens.dart';

class CopyDaily extends StatelessWidget {
  final controller = Get.put(CopyDailyController());
  CopyDaily({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: ListView(
        children: [
          Container(
              padding: const EdgeInsets.only(left: 10),
              child: Text("From Week : ",
                  style: blackFontStyle3.copyWith(color: white, fontSize: 20))),
          _addWeek(context, true),
          Container(
            padding: const EdgeInsets.only(right: 10),
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 2, top: 10),
            child: GetBuilder<CopyDailyController>(
                id: 'daily',
                builder: (_) => MyButton(
                    label: controller.dailys.isEmpty ? "No Data" : "Details",
                    onTap: controller.dailys.isEmpty
                        ? () {}
                        : () => Get.to(() => const CopyDailyDetail(),
                            transition: Transition.cupertino),
                    height: 50,
                    width: 70)),
          ),
          const SizedBox(height: 50),
          Container(
              padding: const EdgeInsets.only(left: 10),
              child: Text("To Week : ",
                  style: blackFontStyle3.copyWith(color: white, fontSize: 20))),
          _addWeek(context, false),
          Container(
              padding: const EdgeInsets.only(right: 10),
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 2, top: 10),
              child: MyButton(
                  label: "Copy Daily",
                  onTap: () => showDialog<String>(
                      context: context,
                      builder: (context) => _dialogDelete(context)),
                  height: 50,
                  width: 70))
        ],
      ),
    );
  }

  _dialogDelete(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Copy",
        style: blackFontStyle1,
      ),
      content: Text(
        'Apakah anda yakin menduplikat daily ?',
        style: blackFontStyle3,
      ),
      actions: [
        TextButton(
            child: Text(
              "YES",
              style: blackFontStyle3.copyWith(color: Colors.green[400]),
            ),
            onPressed: () async {
              Get.back();
              EasyLoading.show(status: 'Copying...');
              await controller
                  .copy(
                      yearfrom: controller.fromYear.value,
                      weekfrom: controller.fromWeek.value,
                      yearto: controller.toYear.value,
                      weekto: controller.toWeek.value)
                  .then((value) {
                EasyLoading.removeAllCallbacks();
                EasyLoading.dismiss();
                print(value.message);
                EasyLoading.showSuccess('Berhasil copy!');
                Get.back();
              });
            }),
        TextButton(
            onPressed: () => Get.back(),
            child: Text(
              "NO",
              style: blackFontStyle3.copyWith(color: Colors.red[400]),
            )),
      ],
    );
  }

  _appBar() => AppBar(
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
          'Copy daily one week',
          style: blackFontStyle3.copyWith(
            color: white,
          ),
        ),
      );

  _addWeek(BuildContext context, bool isFrom) => Container(
        color: "22577E".toColor(),
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Column(
              children: [
                _week(context, isFrom),
                _year(context, isFrom),
              ],
            ),
            Expanded(
              child: SizedBox(
                child: Obx(
                  () => Text(
                    isFrom ? controller.from.value : controller.to.value,
                    textAlign: TextAlign.center,
                    style: blackFontStyle1.copyWith(
                        letterSpacing: 2, color: "b6defa".toColor()),
                  ),
                ),
              ),
            )
          ],
        ),
      );

  _week(BuildContext context, bool isFrom) {
    return SizedBox(
      width: 150,
      height: 50,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () async => await controller.buttonWeek(
                              false, isFrom)
                          ? null
                          : snackbar(context, false,
                              "Tidak bisa kurang dari week ${isFrom ? controller.minWeekFrom : controller.minWeekTo}"),
                      icon: const Icon(
                        MdiIcons.minusCircle,
                        color: white,
                      )),
                  Container(
                    alignment: Alignment.center,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    width: 50,
                    height: 50,
                    padding: const EdgeInsets.only(bottom: 3),
                    child: Obx(
                      () => Text(
                          isFrom
                              ? controller.fromWeek.value.toString()
                              : controller.toWeek.value.toString(),
                          textAlign: TextAlign.center,
                          style: blackFontStyle1.copyWith(color: white)),
                    ),
                  ),
                  IconButton(
                      onPressed: () async => await controller.buttonWeek(
                              true, isFrom)
                          ? null
                          : snackbar(context, false,
                              "Tidak bisa lebih dari week ${isFrom ? controller.maxWeekFrom : controller.maxWeekTo}"),
                      icon: const Icon(
                        MdiIcons.plusCircle,
                        color: white,
                      )),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  _year(BuildContext context, bool isFrom) {
    return SizedBox(
      width: 150,
      height: 50,
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () async => await controller.buttonYear(
                              false, isFrom)
                          ? null
                          : snackbar(context, false,
                              "Tidak bisa kurang dari tahun ${isFrom ? controller.minYearFrom : controller.minYearTo}"),
                      icon: const Icon(
                        MdiIcons.minusCircle,
                        color: white,
                      )),
                  Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      width: 50,
                      height: 50,
                      padding: const EdgeInsets.only(left: 5, bottom: 3),
                      child: Obx(() => Text(
                          isFrom
                              ? controller.fromYear.value.toString()
                              : controller.toYear.value.toString(),
                          textAlign: TextAlign.center,
                          style: blackFontStyle1.copyWith(
                              color: white, fontSize: 16)))),
                  IconButton(
                      onPressed: () async => await controller.buttonYear(
                              true, isFrom)
                          ? null
                          : snackbar(context, false,
                              "Tidak bisa lebih dari tahun ${isFrom ? controller.maxYearFrom : controller.maxYearTo}"),
                      icon: const Icon(
                        MdiIcons.plusCircle,
                        color: white,
                      )),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
