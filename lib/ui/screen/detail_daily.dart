part of 'screens.dart';

class DetailDaily extends StatelessWidget {
  final DailyModel daily;
  final controller = Get.put(DetailDailyController());

  DetailDaily({Key? key, required this.daily}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: _appBar(),
      body: Column(
        children: [
          MyInputField(
            title: 'Task',
            hint: '${daily.task}'.toUpperCase(),
            isPassword: false,
            widget: const SizedBox(),
            isvalue: true,
          ),
          Row(
            children: [
              Expanded(
                child: MyInputField(
                  title: 'Date',
                  hint: DateFormat('d-M-y').format(daily.date!),
                  isPassword: false,
                  widget: const SizedBox(),
                  isvalue: true,
                ),
              ),
              Expanded(
                child: MyInputField(
                  title: 'Time',
                  hint: daily.time!,
                  isPassword: false,
                  widget: const SizedBox(),
                  isvalue: true,
                ),
              ),
            ],
          ),
          MyInputField(
            title: 'Status',
            hint: daily.status! ? 'CLOSED' : 'OPEN',
            isPassword: false,
            widget: const SizedBox(),
            isvalue: true,
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: MyButton(
                label: daily.status! ? 'OPEN' : 'CLOSED',
                onTap: () {},
                height: 50,
                width: 90),
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
          color: Colors.black,
        ),
      ),
      backgroundColor: white,
      elevation: 0,
      centerTitle: true,
      title: Text(
        'Detail Daily',
        style: blackFontStyle3,
      ),
    );
  }
}
