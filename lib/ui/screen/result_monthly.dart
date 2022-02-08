part of 'screens.dart';

class ResultMonthly extends GetView<ResultController> {
  const ResultMonthly({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.loading.value
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                PieCharResult(
                    closed: controller.totalActualMonthly.toDouble(),
                    open: controller.totalOpenMonthly.toDouble()),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CardDetailResult(
                              title: "Plan Task",
                              value: '${controller.totalPlanTaskMonthly}'),
                          CardDetailResult(
                              title: "Extra Task",
                              value: '${controller.totalExtraTaskMonthly}'),
                          CardDetailResult(
                              title: "Achievement",
                              value: '${controller.achievemntMonthly} %'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CardDetailResult(
                              title: "Actual",
                              value: '${controller.totalActualMonthly}'),
                          CardDetailResult(
                              title: "Total Point",
                              value: '${controller.totalPointMonthly}'),
                        ],
                      ),
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
                ),
              ],
            ),
    );
  }
}
