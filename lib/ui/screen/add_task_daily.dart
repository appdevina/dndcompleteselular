part of 'screens.dart';

class AddTaskDaily extends StatelessWidget {
  final controller = Get.put(DailyAddTaskController());
  AddTaskDaily({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: white,
      appBar: _appBar(),
      body: Form(
        key: controller.key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Text(
                "Add Task",
                style: blackFontStyle1,
              ),
            ),
            MyInputField(
              isPassword: false,
              title: "Todo",
              hint: "input todo",
              controllerText: controller.title,
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
                    builder: (_) => _timeField(context),
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
                    onTap: () {},
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
      hint: (controller.selectedDate == null)
          ? DateFormat.yMMMd().format(controller.lastMonday!)
          : DateFormat.yMMMd().format(controller.selectedDate!),
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

  _getDateUser(BuildContext context) async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now().isAfter(controller.lastMonday!)
            ? DateTime.now()
            : controller.lastMonday!,
        firstDate: controller.lastMonday!,
        lastDate: controller.lastMonday!.add(const Duration(days: 5)));

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
          color: Colors.black,
        ),
      ),
      backgroundColor: white,
      elevation: 0,
      centerTitle: true,
      title: Text(
        'Add Daily Todo',
        style: blackFontStyle3,
      ),
    );
  }
}
