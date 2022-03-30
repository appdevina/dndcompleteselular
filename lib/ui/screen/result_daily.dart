part of 'screens.dart';

class ResultDaily extends GetView<ResultController> {
  const ResultDaily({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.loading.value
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                controller.totalPlanTaskDaily == 0
                    ? SizedBox(
                        width: double.infinity,
                        height: 210,
                        child: Center(
                          child: Text(
                            'NO DATA',
                            style: blackFontStyle1.copyWith(color: white),
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          PieCharResult(
                              closed: controller.totalActualDaily.toDouble(),
                              open: controller.totalOpenDaily.toDouble()),
                          MyButton(
                            label: "Detail",
                            onTap: () => Get.to(
                              () => const DetailDaily(),
                              transition: Transition.cupertino,
                            ),
                            height: 40,
                            width: 80,
                          ),
                        ],
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CardDetailResult(
                        title: "Plan Task",
                        titleTooltip: 'total task daily\nsatu minggu',
                        value: '${controller.totalPlanTaskDaily}'),
                    CardDetailResult(
                        title: "Extra Task",
                        titleTooltip: 'total extra task daily\nsatu minggu',
                        value: '${controller.totalExtraTaskDaily}'),
                    CardDetailResult(
                        title: "Achievement",
                        titleTooltip:
                            '(actual task + extra task / total task x 100)%',
                        value: NumberFormat("###.#", "en_US")
                                .format(controller.achievemntDaily) +
                            "%"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CardDetailResult(
                        titleTooltip:
                            'total task closed plan\ndaily satu minggu',
                        title: "Actual Task",
                        value: '${controller.totalActualDaily}'),
                    CardDetailResult(
                        titleTooltip: 'total daily submit / hari kerja',
                        title: "Day / Total Day",
                        value: '${controller.totalDaysData} / 6'),
                    CardDetailResult(
                      title: "Total Point",
                      titleTooltip: 'bobot 60 / achievement',
                      value: NumberFormat("###.#", "en_US")
                          .format(controller.totalPointDaily),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
