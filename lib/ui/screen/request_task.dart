part of 'screens.dart';

class RequestTask extends GetView<RequestTaskController> {
  const RequestTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Row(
            children: [
              Expanded(
                child: GetBuilder<RequestTaskController>(
                  id: 'tag',
                  builder: (_) => DropDownCustom(
                      title: "Todo",
                      todoType: controller.user.monthlyNon! ||
                              controller.user.monthlyResult!
                          ? ['Daily', 'Weekly', 'Monthly']
                          : ['Daily', 'Weekly']),
                ),
              ),
              Expanded(
                child: GetBuilder<RequestTaskController>(
                  id: 'spec',
                  builder: (_) => controller.selectedTodo == 'Daily'
                      ? _dateField(context)
                      : controller.selectedTodo == 'Weekly'
                          ? _pickWeek(context, 'Week')
                          : controller.selectedTodo == 'Monthly'
                              ? _monthField(context)
                              : const SizedBox(),
                ),
              )
            ],
          ),
          GetBuilder<RequestTaskController>(
            id: 'tag',
            builder: (_) =>
                controller.selectedTodo != null ? _tag() : const SizedBox(),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(color: white, thickness: 1.5),
          GetBuilder<RequestTaskController>(
            id: 'tag',
            builder: (_) => controller.selectedTodo != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      controller.selectedTodo != null
                          ? Container(
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  MyButton(
                                      label: "Add Task",
                                      onTap: () => controller.selectedTodo ==
                                              'Daily'
                                          ? Get.to(
                                              () => AddTaskDaily(
                                                    date: controller.day,
                                                  ),
                                              transition: Transition.cupertino)
                                          : controller.selectedTodo == 'Weekly'
                                              ? Get.to(
                                                  () => AddTaskWeekly(
                                                      week: controller.week,
                                                      year: controller.weekly
                                                              .first.year ??
                                                          DateTime.now().year),
                                                  transition:
                                                      Transition.cupertino)
                                              : Get.to(
                                                  () => AddTaskMonthly(
                                                      month: controller.month),
                                                  transition:
                                                      Transition.cupertino),
                                      height: 40,
                                      width: 90),
                                  MyButton(
                                      label: "Submit",
                                      onTap: () async {
                                        await controller
                                            .submit(
                                                type: controller.selectedTodo,
                                                existingTaskId:
                                                    controller.selectedTask,
                                                dailyReplace:
                                                    controller.dailyChange,
                                                weeklyReplace:
                                                    controller.weeklyChange,
                                                monthlyReplace:
                                                    controller.monthlyChange)
                                            .then(
                                          (value) {
                                            if (value.value!) {
                                              controller.selectedTodo = null;
                                              controller.getHistory();
                                              controller.daily.clear();
                                              controller.weekly.clear();
                                              controller.monthly.clear();
                                              controller.dailyChange.clear();
                                              controller.weeklyChange.clear();
                                              controller.monthlyChange.clear();
                                              controller.selectedTask.clear();
                                              controller
                                                  .update(['spec', 'tag']);
                                            }
                                            snackbar(context, value.value!,
                                                value.message!);
                                          },
                                        );
                                      },
                                      height: 40,
                                      width: 90),
                                ],
                              ))
                          : const SizedBox(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'List Task Change : ',
                          style: blackFontStyle3.copyWith(
                              color: white, fontSize: 14),
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                        thickness: 0.5,
                        indent: 15,
                        endIndent: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: white),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        width: double.infinity,
                        height: 300,
                        child: controller.dailyChange.isNotEmpty &&
                                controller.selectedTodo == 'Daily'
                            ? ListView.builder(
                                itemBuilder: ((context, index) =>
                                    CardDailyRequest(
                                        daily: controller.dailyChange[index])),
                                itemCount: controller.dailyChange.length,
                              )
                            : controller.weeklyChange.isNotEmpty &&
                                    controller.selectedTodo == 'Weekly'
                                ? ListView.builder(
                                    itemBuilder: ((context, index) =>
                                        CardWeeklyRequest(
                                            weekly: controller
                                                .weeklyChange[index])),
                                    itemCount: controller.weeklyChange.length,
                                  )
                                : controller.monthlyChange.isNotEmpty &&
                                        controller.selectedTodo == 'Monthly'
                                    ? ListView.builder(
                                        itemBuilder: ((context, index) =>
                                            CardMonthlyRequest(
                                                monthly: controller
                                                    .monthlyChange[index])),
                                        itemCount:
                                            controller.monthlyChange.length,
                                      )
                                    : const SizedBox(),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }

  _monthField(BuildContext context) {
    return MyInputField(
      isPassword: false,
      title: "Month",
      hint: DateFormat.MMMM().format(controller.month),
      widget: IconButton(
        onPressed: () async => await showMonthPicker(
          context: context,
          initialDate: controller.month,
          firstDate: DateTime(2022, 1),
          lastDate: DateTime(2025, 12),
        ).then((value) => value != null ? controller.changeMonth(value) : null),
        icon: const Icon(
          Icons.calendar_today_outlined,
          color: Colors.black38,
        ),
      ),
    );
  }

  _dateField(BuildContext context) {
    return MyInputField(
      isPassword: false,
      title: "Date",
      hint: DateFormat.yMMMd().format(controller.day),
      widget: IconButton(
        onPressed: () {
          _getDateUser(context);
        },
        icon: const Icon(
          Icons.calendar_today_outlined,
          color: Colors.black38,
        ),
      ),
    );
  }

  _getDateUser(BuildContext context) async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2022, 1),
      initialDate: controller.day,
      lastDate: DateTime(2025, 12),
    );

    if (_pickerDate != null) {
      controller.changeDay(_pickerDate);
    }
  }

  _pickWeek(BuildContext context, String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: blackFontStyle3.copyWith(color: white),
          ),
          _week(context),
        ],
      ),
    );
  }

  _week(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.7,
      height: 75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () => controller.buttonWeek(false)
                ? null
                : snackbar(context, false,
                    "Tidak bisa kurang dari week ${controller.minWeek}"),
            icon: const Icon(
              MdiIcons.minusCircle,
              color: white,
            ),
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            height: 50,
            child: Text(controller.week.toString(),
                style: blackFontStyle1.copyWith(color: white, fontSize: 30)),
          ),
          IconButton(
              onPressed: () => controller.buttonWeek(true)
                  ? null
                  : snackbar(context, false,
                      "Tidak bisa lebih dari week ${controller.maxWeek}"),
              icon: const Icon(
                MdiIcons.plusCircle,
                color: white,
              )),
        ],
      ),
    );
  }

  Container _tag() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          MultiSelectDialogField(
            buttonIcon: const Icon(
              MdiIcons.arrowLeftBottom,
              color: white,
            ),
            listType: MultiSelectListType.CHIP,
            searchable: true,
            buttonText: Text(
              "List Task Existing :",
              style: blackFontStyle3.copyWith(color: white),
            ),
            title:
                Text("Task ${controller.selectedTodo}", style: blackFontStyle3),
            items: controller.selectedTodo == 'Daily' &&
                    controller.daily.isNotEmpty
                ? controller.daily
                    .map(
                        (e) => MultiSelectItem(e.id!, "${e.time!} - ${e.task}"))
                    .toList()
                : controller.selectedTodo == 'Weekly' &&
                        controller.weekly.isNotEmpty
                    ? controller.weekly
                        .map((e) =>
                            MultiSelectItem(e.id!, "${e.type} - ${e.task}"))
                        .toList()
                    : controller.selectedTodo == 'Monthly' &&
                            controller.monthly.isNotEmpty
                        ? controller.monthly
                            .map((e) =>
                                MultiSelectItem(e.id!, "${e.type} - ${e.task}"))
                            .toList()
                        : [],
            onConfirm: (values) {
              controller.selectedTask = values;
              controller.update(['tag']);
            },
            chipDisplay: MultiSelectChipDisplay(
              chipColor: white,
              textStyle: blackFontStyle3.copyWith(color: "22577E".toColor()),
              onTap: (value) {
                controller.selectedTask.remove(value);
                controller.update(['tag']);
              },
            ),
          ),
          controller.selectedTask.isEmpty
              ? Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "None selected task",
                    style: blackFontStyle3.copyWith(color: white),
                  ))
              : Container(),
        ],
      ),
    );
  }
}
