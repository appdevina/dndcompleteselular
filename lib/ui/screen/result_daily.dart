part of 'screens.dart';

class ResultDaily extends GetView<ResultController> {
  const ResultDaily({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.loading.value
          ? const Center(child: CircularProgressIndicator())
          : Column(
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
                        value: '${controller.totalPlanTaskDaily}'),
                    CardDetailResult(
                        title: "Extra Task",
                        value: '${controller.totalExtraTaskDaily}'),
                    CardDetailResult(
                        title: "Achievement",
                        value:
                            '${num.parse(controller.achievemntDaily.toStringAsFixed(1))}%'),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CardDetailResult(
                        title: "Actual Task",
                        value: '${controller.totalActualDaily}'),
                    CardDetailResult(
                        title: "Day / Total Day",
                        value: '${controller.totalDaysData} / 6'),
                    CardDetailResult(
                        title: "Total Point",
                        value: '${controller.totalPointDaily}'),
                  ],
                ),
              ],
            ),
    );
  }
}
