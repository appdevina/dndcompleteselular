part of 'screens.dart';

class ResultMonthly extends GetView<ResultController> {
  const ResultMonthly({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.loading.value
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                controller.totalPlanTaskMonthly == 0
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
                              closed: controller.totalActualMonthly.toDouble(),
                              open: controller.totalOpenMonthly.toDouble()),
                          MyButton(
                            label: "Detail",
                            onTap: () => Get.to(
                              () => const DetailMonthly(),
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
                        titleTooltip: 'total plan task monthly',
                        value: '${controller.totalPlanTaskMonthly}'),
                    CardDetailResult(
                        title: "Extra Task",
                        titleTooltip: 'total extra task monthly',
                        value: '${controller.totalExtraTaskMonthly}'),
                    CardDetailResult(
                        title: "Achievement",
                        titleTooltip:
                            '(actual task + extra task / total task x 100)%',
                        value: NumberFormat("###.#", "en_US")
                                .format(controller.achievemntMonthly) +
                            "%"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CardDetailResult(
                        title: "Actual",
                        titleTooltip: 'total task weekly closed',
                        value: '${controller.totalActualMonthly}'),
                    CardDetailResult(
                        title: "Total Point",
                        titleTooltip: 'bobot 20 / achievement',
                        value: NumberFormat("###.#", "en_US")
                            .format(controller.totalPointMonthly)),
                  ],
                ),
              ],
            ),
    );
  }
}
