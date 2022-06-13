part of 'screens.dart';

class AddTaskDaily extends StatelessWidget {
  final controller = Get.arguments == null
      ? Get.put(DailyAddTaskController())
      : Get.put(
          DailyAddTaskController(
            daily: Get.arguments,
          ),
        );
  final DateTime? date;
  AddTaskDaily({
    Key? key,
    this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar(),
      body: ListView(
        children: [
          Get.arguments == null && date == null
              ? Row(
                  children: [
                    Obx(
                      () => Checkbox(
                          fillColor: MaterialStateProperty.all(white),
                          checkColor: Colors.green,
                          value: controller.tambahan.value,
                          onChanged: (bool? value) {
                            if (value!) {
                              snackbar(context, false,
                                  "Hanya bisa menambahkan daily hari kemarin dan hari ini, untuk daily kemarin batas maksimal input H+1 jam 10:00",
                                  duration: 5000);
                            }
                            controller.changeTambahan();
                          }),
                    ),
                    Text(
                      "Extra Task ?",
                      style: blackFontStyle3.copyWith(color: white),
                    )
                  ],
                )
              : date == null
                  ? Row(
                      children: [
                        Checkbox(
                            fillColor: MaterialStateProperty.all(white),
                            checkColor: Colors.green,
                            value: !controller.daily!.isPlan!,
                            onChanged: (bool? value) {}),
                        Text(
                          "Extra Task ?",
                          style: blackFontStyle3.copyWith(color: white),
                        )
                      ],
                    )
                  : const SizedBox(),
          MyInputField(
            isPassword: false,
            title: "Your Task",
            hint: "Daily Objective",
            controllerText: controller.taskText,
          ),
          Row(
            children: [
              Expanded(
                child: GetBuilder<DailyAddTaskController>(
                  id: 'date',
                  builder: (_) =>
                      date == null ? _dateField(context) : const SizedBox(),
                ),
              ),
              Expanded(
                child: GetBuilder<DailyAddTaskController>(
                  id: 'time',
                  builder: (_) => controller.tambahan.value
                      ? const SizedBox()
                      : _timeField(context),
                ),
              ),
            ],
          ),
          controller.daily == null && date != null
              ? const SizedBox()
              : GetBuilder<DailyAddTaskController>(
                  id: 'tag',
                  builder: (_) => controller.isLoading.value
                      ? const SizedBox()
                      : controller.daily != null
                          ? const SizedBox()
                          : _tag(),
                ),
          Container(
            padding: const EdgeInsets.only(right: 10),
            margin: const EdgeInsets.only(top: defaultMargin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(() => MyButton(
                      height: 50,
                      width: 100,
                      label: controller.daily != null ? "Update" : "+ Add",
                      onTap: controller.button.value
                          ? () async {
                              FocusScope.of(context).requestFocus(FocusNode());
                              if (date != null) {
                                final con = Get.find<RequestTaskController>();
                                DailyModel daily = DailyModel(
                                  task: controller.taskText.text,
                                  date: date,
                                  time: controller.selectedTime,
                                  status: false,
                                  ontime: 0,
                                  isPlan: true,
                                  isUpdate: true,
                                );
                                con
                                    .addTaskChange(dailyModel: daily)
                                    .then((value) {
                                  snackbar(
                                      context, value, 'Berhasil menambahkan');
                                  Get.back();
                                });
                              } else {
                                controller.button.toggle();
                                await controller
                                    .submit(
                                  task: controller.taskText.text,
                                  isAdd: controller.tambahan.value,
                                  date: controller.selectedDate!,
                                  time: controller.selectedTime,
                                  id: controller.daily == null
                                      ? null
                                      : controller.daily!.id,
                                  tags: controller.selectedPerson,
                                )
                                    .then((_) {
                                  controller.button.toggle();
                                  if (!_.value!) {
                                    snackbar(context, _.value!, _.message!);
                                  } else {
                                    if (controller.daily != null) {
                                      Get.back();
                                    }
                                    snackbar(context, _.value!, _.message!);
                                  }
                                  DailyController daily =
                                      Get.find<DailyController>();
                                  if (controller.selectedDate ==
                                          daily.selectedDate ||
                                      controller.daily != null) {
                                    daily.getDaily(daily.selectedDate,
                                        isloading: true);
                                  }
                                  return _;
                                });
                                controller.getDaily(controller.selectedDate!);
                              }
                            }
                          : () {},
                    ))
              ],
            ),
          ),
          controller.daily != null || date != null
              ? const SizedBox()
              : Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: white),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: GetBuilder<DailyAddTaskController>(
                      id: 'daily',
                      builder: (_) => ListView.builder(
                            itemBuilder: ((context, index) => CardDailyAdd(
                                  daily: controller.dailys[index],
                                  index: index,
                                )),
                            itemCount: controller.dailys.length,
                          )),
                ),
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
              "Tag Daily To :",
              style: blackFontStyle3.copyWith(color: white),
            ),
            title: Text("Nama", style: blackFontStyle3),
            items: controller.users
                .map((e) => MultiSelectItem(
                    e.id!, "${e.namaLengkap!} - ${e.divisi!.nama}"))
                .toList(),
            onConfirm: (values) {
              controller.selectedPerson = values;
              controller.update(['tag']);
            },
            chipDisplay: MultiSelectChipDisplay(
              chipColor: white,
              textStyle: blackFontStyle3.copyWith(color: "22577E".toColor()),
              onTap: (value) {
                controller.selectedPerson.remove(value);
                controller.update(['tag']);
              },
            ),
          ),
          controller.selectedPerson.isEmpty
              ? Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "None selected tag",
                    style: blackFontStyle3.copyWith(color: white),
                  ))
              : Container(),
        ],
      ),
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.white;
    }
    return Colors.green;
  }

  _timeField(BuildContext context) {
    return MyInputField(
      isPassword: false,
      title: "Time",
      hint: controller.selectedTime,
      widget: IconButton(
        onPressed: () {
          _getTimeUser(context);
        },
        icon: const Icon(
          Icons.access_time_rounded,
          color: Colors.black38,
        ),
      ),
    );
  }

  _dateField(BuildContext context) {
    return MyInputField(
      isPassword: false,
      title: "Date",
      hint: (controller.tambahan.value)
          ? (controller.selectedDate == null)
              ? DateFormat.yMMMd().format(DateTime.now())
              : DateFormat.yMMMd().format(controller.selectedDate!)
          : (controller.selectedDate == null)
              ? DateFormat.yMMMd().format(DateTime.now())
              : DateFormat.yMMMd().format(controller.selectedDate!),
      widget: IconButton(
        onPressed: () {
          _getDateUser(context, controller.tambahan.value);
        },
        icon: const Icon(
          Icons.calendar_today_outlined,
          color: Colors.black38,
        ),
      ),
    );
  }

  _getTimeUser(BuildContext context) async {
    TimeOfDay? pickedTime = await _showTimePicker(context);

    if (pickedTime != null) {
      String formated = pickedTime.format(context);
      controller.changeTime(formated);
    }
  }

  _showTimePicker(BuildContext context) {
    return showTimePicker(
        hourLabelText: "Jam",
        minuteLabelText: "Menit",
        context: context,
        initialTime: TimeOfDay(
            hour: controller.selectedTime
                .replaceRange(
                    controller.selectedTime.contains('M') ? 1 : 2, null, '')
                .toInt()!,
            minute: 00),
        initialEntryMode: TimePickerEntryMode.input);
  }

  _getDateUser(BuildContext context, bool tambahan) async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: tambahan
            ? DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day)
                .subtract(const Duration(days: 1))
            : DateTime(2022, 4, 25),
        lastDate: tambahan
            ? DateTime.now().add(const Duration(days: 1))
            : DateTime(2025, 12, 31),
        builder: (context, child) => Theme(
              data: ThemeData.dark(),
              child: child!,
            ));

    if (_pickerDate != null) {
      controller.changeDate(_pickerDate);
    }
  }

  _appBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          CupertinoIcons.back,
          color: white,
        ),
      ),
      elevation: 0,
      centerTitle: true,
      title: Text(
        '${Get.arguments == null ? "Add" : "Edit"} Daily To Do ${date == null ? "" : "Change"}',
        style: blackFontStyle3.copyWith(color: white),
      ),
    );
  }
}
