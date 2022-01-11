part of 'widgets.dart';

class CardDaily extends GetView<DailyController> {
  final int index;
  final DailyModel daily;
  const CardDaily({required this.index, required this.daily, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 0.2, color: greyColor),
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
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
                    daily.time!,
                    style: blackFontStyle2.copyWith(
                        wordSpacing: 1, fontSize: 10, color: greyColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    daily.task!.toUpperCase(),
                    style:
                        blackFontStyle2.copyWith(wordSpacing: 1, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () => controller.changeStatus(daily.id!),
              child: Container(
                alignment: Alignment.center,
                width: 30,
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: daily.status! ? Colors.green[400] : Colors.red[400]),
                child: Icon(
                  daily.status! ? Icons.check : Icons.close_sharp,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
