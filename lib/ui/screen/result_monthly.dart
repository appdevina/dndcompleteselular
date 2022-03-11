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
                              value:
                                  '${num.parse(controller.achievemntMonthly.toStringAsFixed(1))} %'),
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
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
