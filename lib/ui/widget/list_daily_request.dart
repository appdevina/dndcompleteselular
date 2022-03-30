part of 'widgets.dart';

class CardDailyRequest extends GetView<RequestTaskController> {
  final DailyModel daily;
  final bool? isCanDelete;
  final int index;
  const CardDailyRequest(
      {required this.daily,
      required this.index,
      this.isCanDelete = true,
      Key? key})
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
              child: Text(
                "${index + 1}",
                textAlign: TextAlign.center,
                style: blackFontStyle1,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      daily.tag == null
                          ? daily.time ?? 'Extra Task'
                          : "${daily.time} - TAG BY : ${daily.tag!.namaLengkap}",
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      verticalOffset: -80,
                      textStyle: blackFontStyle3.copyWith(color: white),
                      decoration: BoxDecoration(
                          color: "22577E".toColor(),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: white)),
                      child: Text(
                        daily.task!.toUpperCase(),
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
            isCanDelete!
                ? InkWell(
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
                  )
                : const SizedBox(),
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
        'Apakah anda yakin menghapus\n"${daily.task}"',
        style: blackFontStyle3,
      ),
      actions: [
        TextButton(
            onPressed: () {
              controller.dailyChange.removeWhere((element) => element == daily);
              controller.update(['tag']);
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
}
