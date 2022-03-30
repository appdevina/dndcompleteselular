part of 'widgets.dart';

class CardWeeklyApprove extends GetView<ApproveRequestController> {
  final WeeklyModel weekly;
  final int index;
  const CardWeeklyApprove({required this.weekly, required this.index, Key? key})
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
                      "WEEKLY ${weekly.type! == 'NON' ? "NON RESULT" : "RESULT"} ${!weekly.isAdd! ? '' : '(Extra Task)'}",
                      style: blackFontStyle2.copyWith(
                          wordSpacing: 1,
                          fontSize: 10,
                          color: greyColor,
                          fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Tooltip(
                      message: weekly.task!.toUpperCase(),
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
                        "${weekly.task!.toUpperCase()} ${weekly.type != "NON" ? controller.formatNumber(weekly.valPlan!.toString()) : ""}",
                        maxLines: 1,
                        style: blackFontStyle2.copyWith(
                          wordSpacing: 1,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
