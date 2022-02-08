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
                PieCharResult(
                    closed: controller.totalActualDaily.toDouble(),
                    open: controller.totalOpenDaily.toDouble()),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
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
                              value: '${controller.achievemntDaily}%'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CardDetailResult(
                              title: "Actual Task",
                              value: '${controller.totalActualDaily}'),
                          CardDetailResult(
                              title: "Total Point",
                              value: '${controller.totalPointDaily}'),
                        ],
                      ),
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
                ),
              ],
            ),
    );
  }
}
