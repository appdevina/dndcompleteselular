part of 'screens.dart';

class DetailMonthly extends GetView<ResultController> {
  const DetailMonthly({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: Card(
          elevation: 10,
          child: ListView(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Month : ${DateFormat('MMMM y').format(controller.monthlies[0].monthYear!)}",
                          style: blackFontStyle2,
                        ),
                        Text(
                          "${controller.monthlies.where((element) => element.value != 0.0).toList().length} / ${controller.monthlies.length}",
                          style: blackFontStyle3,
                        )
                      ],
                    ),
                    const Divider(
                      height: 2,
                      color: Colors.black,
                    ),
                    ...controller.monthlies.map((e) => _task(e)).toList()
                  ],
                ),
              ),
            ],
          ),
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
        'Detail Result Monthly',
        style: blackFontStyle3.copyWith(color: white),
      ),
    );
  }

  _task(MonthlyModel e) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "WEEKLY ${e.type! == 'NON' ? "NON RESULT" : "RESULT"} ${!e.isAdd! ? '' : '(Extra Task)'}",
                    style: blackFontStyle3.copyWith(
                        fontSize: 12, color: greyColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Tooltip(
                    message: e.task!,
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    showDuration: const Duration(milliseconds: 500),
                    verticalOffset: -60,
                    textStyle: blackFontStyle3.copyWith(
                      color: white,
                    ),
                    decoration: BoxDecoration(
                        color: "22577E".toColor(),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: white)),
                    child: Text(e.task!,
                        style: blackFontStyle1.copyWith(fontSize: 14),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                  ),
                  e.type! == 'RESULT'
                      ? Text(
                          "Plan : ${controller.formatNumber('${e.valPlan}')} <> Actual : ${controller.formatNumber(e.valAct!.floor().toInt().toString())}",
                          style: blackFontStyle1.copyWith(fontSize: 10),
                          overflow: TextOverflow.ellipsis,
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: e.value! != 0.0 ? Colors.green[100] : Colors.red[100]),
            width: 60,
            height: 20,
            child: Text(
              e.value! != 0.0 ? "Closed" : 'Open',
              style: blackFontStyle3.copyWith(
                  fontSize: 10,
                  color: e.value! != 0.0 ? Colors.green[500] : Colors.red[500]),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
