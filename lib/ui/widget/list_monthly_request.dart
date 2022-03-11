part of 'widgets.dart';

class CardMonthlyRequest extends GetView<RequestTaskController> {
  final MonthlyModel monthly;
  const CardMonthlyRequest({required this.monthly, Key? key}) : super(key: key);

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
                    "MONTHLY ${monthly.type! == 'NON' ? "NON RESULT" : "RESULT"} ${!monthly.isAdd! ? '' : '(Extra Task)'}",
                    style: blackFontStyle2.copyWith(
                        wordSpacing: 1,
                        fontSize: 10,
                        color: greyColor,
                        fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SelectableText(
                    "${monthly.task!.toUpperCase()} ${monthly.type != "NON" ? controller.formatNumber(monthly.valPlan!.toString()) : ""}",
                    maxLines: 1,
                    style: blackFontStyle2.copyWith(
                      wordSpacing: 1,
                      fontSize: 12,
                    ),
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
