part of 'screens.dart';

class ResultWeekly extends GetView<ResultController> {
  const ResultWeekly({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.loading.value
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                PieCharResult(
                    closed: controller.actualTaskWeekly.toDouble(),
                    open: controller.totalOpenWeekly.toDouble()),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CardDetailResult(
                              title: "Plan Task",
                              value: '${controller.planTaskWeekly}'),
                          CardDetailResult(
                              title: "Extra Task",
                              value: '${controller.extraTaskWeekly}'),
                          CardDetailResult(
                              title: "Achievement",
                              value: '${controller.achievementWeekly}%'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CardDetailResult(
                              title: "Actual Task",
                              value: '${controller.actualTaskWeekly}'),
                          CardDetailResult(
                              title: "Total Point",
                              value: '${controller.totalPointWeekly}'),
                        ],
                      ),
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
                ),
              ],
            ),
    );
  }
}
