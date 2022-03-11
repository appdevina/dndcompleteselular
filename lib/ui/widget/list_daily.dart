part of 'widgets.dart';

class CardDaily extends GetView<DailyController> {
  final DailyModel daily;
  const CardDaily({required this.daily, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => daily.tag == null
          ? Get.to(
              () => AddTaskDaily(),
              arguments: daily,
              transition: Transition.cupertino,
            )
          : snackbar(context, false, "Daily tag tidak bisa di rubah"),
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
                    SelectableText(
                      daily.task!.toUpperCase(),
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
                  InkWell(
                    onTap: () async => await controller
                        .changeStatus(daily.id!)
                        .then((value) =>
                            snackbar(context, value.value!, value.message!)),
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
}
