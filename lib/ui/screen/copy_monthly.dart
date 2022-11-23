part of 'screens.dart';

class CopyMonthly extends StatelessWidget {
  final controller = Get.put(CopyMonthlyController());
  CopyMonthly({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: ListView(
        children: [
          Container(
              padding: const EdgeInsets.only(left: 10),
              child: Text("From Month : ",
                  style: blackFontStyle3.copyWith(color: white, fontSize: 20))),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            height: 90,
            margin: const EdgeInsets.only(top: 15),
            child: _pickMonth(context, true),
          ),
          Container(
            padding: const EdgeInsets.only(right: 10),
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 2, top: 10),
            child: GetBuilder<CopyMonthlyController>(
                id: 'monthly',
                builder: (_) => MyButton(
                    label: controller.monthlys.isEmpty ? "No Data" : "Details",
                    onTap: controller.monthlys.isEmpty
                        ? () {}
                        : () => Get.to(() => const CopyMonthlyDetail(),
                            transition: Transition.cupertino),
                    height: 50,
                    width: 70)),
          ),
          const SizedBox(height: 50),
          Container(
              padding: const EdgeInsets.only(left: 10),
              child: Text("To Month : ",
                  style: blackFontStyle3.copyWith(color: white, fontSize: 20))),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            height: 90,
            margin: const EdgeInsets.only(top: 15),
            child: _pickMonth(context, false),
          ),
          Container(
              padding: const EdgeInsets.only(right: 10),
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 2, top: 10),
              child: MyButton(
                  label: "Copy monthly",
                  onTap: () => showDialog<String>(
                      context: context,
                      builder: (context) => _dialogDelete(context)),
                  height: 50,
                  width: 70))
        ],
      ),
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
          'Copy monthly',
          style: blackFontStyle3.copyWith(
            color: white,
          ),
        ),
      );

  _pickMonth(BuildContext context, bool isFrom) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
                child: Obx(
              () => Text(
                  isFrom
                      ? controller.monthfrom.value
                      : controller.monthto.value,
                  style: blackFontStyle1.copyWith(color: white),
                  textAlign: TextAlign.center),
            )),
          ),
          MyButton(
            height: 40,
            width: 100,
            label: "CHANGE",
            onTap: () => showPicker(context, isFrom),
          )
        ],
      ),
    );
  }

  Future showPicker(BuildContext context, bool isFrom) => showMonthPicker(
        context: context,
        initialDate: isFrom ? controller.monthFrom : controller.monthTo,
        firstDate: isFrom ? DateTime(2022) : controller.minMonthTo,
        lastDate: isFrom ? controller.maxMonthFrom : DateTime(2025),
      ).then((value) => value != null
          ? controller.changeMonth(isFrom: isFrom, val: value)
          : null);

  _dialogDelete(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Copy",
        style: blackFontStyle1,
      ),
      content: Text(
        'Apakah anda yakin menduplikat monthly ?',
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
                  .copy(from: controller.monthFrom, to: controller.monthTo)
                  .then((value) {
                EasyLoading.removeAllCallbacks();
                EasyLoading.dismiss();
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
}
