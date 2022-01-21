part of 'screens.dart';

class AddTaskDaily extends StatelessWidget {
  final controller = Get.put(DailyAddTaskController());
  AddTaskDaily({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar(),
      body: Form(
        key: controller.key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Obx(
                  () => Checkbox(
                      fillColor: MaterialStateProperty.all(white),
                      checkColor: Colors.green,
                      value: controller.tambahan.value,
                      onChanged: (_) {
                        controller.changeTambahan();
                      }),
                ),
                Text(
                  "Extra Task ?",
                  style: blackFontStyle3.copyWith(color: white),
                )
              ],
            ),
            MyInputField(
              isPassword: false,
              title: "Your Task",
              hint: "Daily Objective",
              controllerText: controller.task,
            ),
            Row(
              children: [
                Expanded(
                  child: GetBuilder<DailyAddTaskController>(
                    id: 'date',
                    builder: (_) => _dateField(context),
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
            Container(
              padding: const EdgeInsets.only(right: 10),
              margin: const EdgeInsets.only(top: defaultMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MyButton(
                    height: 50,
                    width: 100,
                    label: "+ Add",
                    onTap: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      await controller
                          .submit(
                              controller.task.text,
                              controller.tambahan.value,
                              controller.selectedDate!,
                              jam: controller.selectedTime)
                          .then((value) => value.value!
                              ? snackbar(context, true, value.message!)
                              : snackbar(context, false, value.message!));
                    },
                  )
                ],
              ),
            ),
            const Spacer(),
            Obx(() => controller.tambahan.value
                ? Container(
                    padding: const EdgeInsetsDirectional.all(10),
                    height: 20,
                    margin: const EdgeInsetsDirectional.only(bottom: 8),
                    width: double.infinity,
                    child: Text(
                      "*Batas waktu input tambahan daily hari sebelumnya sampai (H+1) jam 10",
                      style:
                          blackFontStyle3.copyWith(color: white, fontSize: 10),
                      overflow: TextOverflow.visible,
                    ),
                  )
                : const SizedBox())
          ],
        ),
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
              ? DateFormat.yMMMd().format(controller.lastMonday!)
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
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.input);
  }

  _getDateUser(BuildContext context, bool tambahan) async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: tambahan
            ? DateTime.now()
            : DateTime.now().isAfter(controller.lastMonday!)
                ? DateTime.now()
                : controller.lastMonday!,
        firstDate: tambahan
            ? DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day)
                .subtract(const Duration(days: 1))
            : controller.lastMonday!,
        lastDate: tambahan
            ? DateTime.now()
            : controller.lastMonday!.add(const Duration(days: 6)));

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
        'Add Daily To Do',
        style: blackFontStyle3.copyWith(color: white),
      ),
    );
  }
}
