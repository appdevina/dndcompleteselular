part of 'widgets.dart';

class CardDailyRequest extends GetView<RequestTaskController> {
  final DailyModel daily;
  const CardDailyRequest({required this.daily, Key? key}) : super(key: key);

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
          ],
        ),
      ),
    );
  }
}
