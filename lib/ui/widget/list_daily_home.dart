part of 'widgets.dart';

class CardDailyHome extends GetView<HomePageController> {
  final int index;
  const CardDailyHome({required this.index, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 0.2, color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      child: Container(
        alignment: Alignment.center,
        height: 100,
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    left: 10,
                    top: 10,
                    bottom: 10,
                  ),
                  child: Text(
                    DateFormat('dd MMM y')
                        .format(controller.daily![index].date!),
                    style: blackFontStyle3.copyWith(color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/day.png'),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.daily![index].time!,
                        style: blackFontStyle2.copyWith(
                            wordSpacing: 1, fontSize: 10, color: greyColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        controller.daily![index].task!.toUpperCase(),
                        style: blackFontStyle2.copyWith(
                            wordSpacing: 1, fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "Status :",
                      style: blackFontStyle3.copyWith(fontSize: 10),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.11,
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          color: controller.daily![index].status!
                              ? Colors.green[100]
                              : Colors.red[100],
                          borderRadius: BorderRadius.circular(6)),
                      child: Text(
                        controller.daily![index].status! ? "Closed" : "Open",
                        style: blackFontStyle3.copyWith(
                            fontSize: 8,
                            color: controller.daily![index].status!
                                ? Colors.green
                                : Colors.red),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
