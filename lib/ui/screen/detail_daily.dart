part of 'screens.dart';

class DetailDaily extends GetView<ResultController> {
  const DetailDaily({
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
        child: GetBuilder<ResultController>(
          id: 'dailys',
          builder: (_) => ListView.builder(
            itemBuilder: (context, index) => Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tanggal : ${DateFormat('d MMM y').format(controller.dailys[index][0].date!)}",
                          style: blackFontStyle2,
                        ),
                        Text(
                          "${controller.dailys[index].where((element) => element.valueResult != 0.0).toList().length} / ${controller.dailys[index].where((element) => element.isPlan!).toList().length}",
                          style: blackFontStyle3,
                        )
                      ],
                    ),
                  ),
                  const Divider(
                    height: 2,
                    color: Colors.black,
                  ),
                  ...controller.dailys[index]
                      .map(
                        (e) => _task(e),
                      )
                      .toList(),
                ],
              ),
            ),
            itemCount: controller.dailys.length,
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
        'Detail Result Daily',
        style: blackFontStyle3.copyWith(color: white),
      ),
    );
  }

  _task(DailyModel e) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e.time ?? 'Extra Task',
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
                    child: Text(
                      e.task!,
                      style: blackFontStyle1.copyWith(fontSize: 14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    'on-time point : ${e.ontime}',
                    style:
                        blackFontStyle3.copyWith(fontSize: 8, color: greyColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color:
                    e.valueResult != 0.0 ? Colors.green[100] : Colors.red[100]),
            width: 60,
            height: 20,
            child: Text(
              e.valueResult != 0.0 ? "Closed" : 'Open',
              style: blackFontStyle3.copyWith(
                  fontSize: 10,
                  color: e.valueResult != 0.0
                      ? Colors.green[500]
                      : Colors.red[500]),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
