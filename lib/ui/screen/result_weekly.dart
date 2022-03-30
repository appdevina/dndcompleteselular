part of 'screens.dart';

class ResultWeekly extends GetView<ResultController> {
  const ResultWeekly({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.loading.value
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                controller.planTaskWeekly == 0
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
                              closed: controller.actualTaskWeekly.toDouble(),
                              open: controller.totalOpenWeekly.toDouble()),
                          MyButton(
                            label: "Detail",
                            onTap: () => Get.to(
                              () => const DetailWeekly(),
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
                        titleTooltip: 'total plan task weekly',
                        value: '${controller.planTaskWeekly}'),
                    CardDetailResult(
                        title: "Extra Task",
                        titleTooltip: 'total extra task weekly',
                        value: '${controller.extraTaskWeekly}'),
                    CardDetailResult(
                        title: "Achievement",
                        titleTooltip:
                            '(actual task + extra task / total task x 100)%',
                        value: NumberFormat("###.#", "en_US")
                                .format(controller.achievementWeekly) +
                            "%"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CardDetailResult(
                        title: "Actual Task",
                        titleTooltip: 'total task weekly closed',
                        value: '${controller.actualTaskWeekly}'),
                    CardDetailResult(
                        title: "Total Point",
                        titleTooltip: 'bobot 40 / achievement',
                        value: NumberFormat("###.#", "en_US")
                            .format(controller.totalPointWeekly)),
                  ],
                ),
              ],
            ),
    );
  }
}
