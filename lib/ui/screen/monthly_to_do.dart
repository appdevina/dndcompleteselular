part of 'screens.dart';

class MonthlyToDo extends StatelessWidget {
  final controller = Get.put(MonthlyController());
  MonthlyToDo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          _pickMonth(context),
          Expanded(
            child: GetBuilder<MonthlyController>(
              id: 'monthly',
              builder: (_) => controller.isLoading.value
                  ? Shimmer.fromColors(
                      child: _listToDo(10),
                      highlightColor: Colors.grey[300]!,
                      baseColor: Colors.grey[100]!,
                    )
                  : _listToDo(controller.monthly.length,
                      monthly: controller.monthly),
            ),
          ),
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          CupertinoIcons.back,
          color: Colors.white,
        ),
      ),
      elevation: 0,
      centerTitle: true,
      title: Text(
        'Monthly To Do',
        style: blackFontStyle3.copyWith(color: white),
      ),
      actions: [
        IconButton(
          onPressed: () =>
              Get.to(() => CopyMonthly(), transition: Transition.cupertino),
          icon: const Icon(
            MdiIcons.contentCopy,
            color: white,
          ),
          iconSize: 16,
        ),
        IconButton(
          onPressed: () =>
              Get.to(() => AddTaskMonthly(), transition: Transition.cupertino),
          icon: const Icon(
            MdiIcons.plus,
            color: white,
          ),
          iconSize: 18,
        ),
        IconButton(
          onPressed: () => controller.getMonthlyObjective(
              controller.selectedMonthYear,
              isloading: true),
          icon: const Icon(
            MdiIcons.refresh,
            color: Colors.white,
          ),
          iconSize: 18,
        )
      ],
    );
  }

  _pickMonth(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: GetBuilder<MonthlyController>(
                id: 'month',
                builder: (_) => Text(
                    DateFormat('MMMM  -  y')
                        .format(controller.selectedMonthYear),
                    style: blackFontStyle1.copyWith(color: white),
                    textAlign: TextAlign.center),
              ),
            ),
          ),
          MyButton(
            height: 40,
            width: 100,
            label: "CHANGE",
            onTap: () => showMonthPicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: controller.minMonthYear,
              lastDate: DateTime(2025),
            ).then((value) =>
                value != null ? controller.changeMonth(value) : null),
          )
        ],
      ),
    );
  }

  _listToDo(int lenght, {List<MonthlyModel>? monthly}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: monthly != null && monthly.isEmpty
          ? Center(
              child: Text(
                "Tidak ada to do\n ${DateFormat('MMMM - y').format(controller.selectedMonthYear)}",
                style: blackFontStyle2.copyWith(color: white),
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemBuilder: (context, index) => monthly != null
                  ? CardMonthly(
                      index: index,
                      monthly: controller.monthly[index],
                    )
                  : Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 0.2, color: greyColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                      child: Container(
                        alignment: Alignment.center,
                        height: 60,
                        width: double.infinity,
                        padding: const EdgeInsetsDirectional.only(bottom: 10),
                      ),
                    ),
              itemCount: lenght,
            ),
    );
  }
}
