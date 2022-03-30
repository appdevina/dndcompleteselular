part of 'widgets.dart';

class CardDailyHome extends GetView<HomePageController> {
  final int index;
  final DailyModel daily;
  const CardDailyHome({required this.index, required this.daily, Key? key})
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
                      daily.time ?? 'Extra Task',
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
                          horizontal: 15, vertical: 5),
                      verticalOffset: -60,
                      textStyle: blackFontStyle3.copyWith(
                        color: white,
                      ),
                      decoration: BoxDecoration(
                          color: "22577E".toColor(),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: white)),
                      child: Text(
                        daily.task!.toUpperCase(),
                        style: blackFontStyle2.copyWith(
                          wordSpacing: 1,
                          fontSize: 12,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            daily.status!
                ? Container(
                    alignment: Alignment.center,
                    width: 30,
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.green[400]),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 20,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
