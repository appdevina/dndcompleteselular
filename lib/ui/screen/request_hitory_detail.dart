part of 'screens.dart';

class RequestHistoryDetail extends GetView<RequestTaskController> {
  final RequestModel request;
  const RequestHistoryDetail({required this.request, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.3,
                    vertical: 20),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: const BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                child: Text(
                  request.status!,
                  style: blackFontStyle3,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Request Info',
                  style: blackFontStyle3.copyWith(color: white, fontSize: 20),
                ),
              ),
              _itemdetail(
                label: 'Request Name',
                detail: "Request ${request.jenisToDo}",
              ),
              _itemdetail(
                label: 'Request Date',
                detail: DateFormat('dd MMMM y').format(request.createdAt!),
              ),
              _itemdetail(
                label: 'Task existing',
                detail: _lenght(jenis: request.jenisToDo!, isRequest: true),
              ),
              // taskDetail(jenis: request.jenisToDo!, isRequest: true),
              _itemdetail(
                label: 'Task replace',
                detail: _lenght(jenis: request.jenisToDo!, isRequest: false),
              ),
              // taskDetail(jenis: request.jenisToDo!, isRequest: false),
              _itemdetail(
                label: 'Canceled',
                detail: (request.status! == 'CANCELED') ? 'YES' : '-',
              ),
              _itemdetail(
                label: 'Line Approve',
                detail: request.approvalName!.namaLengkap!,
              ),
              _itemdetail(
                label: 'Approved at',
                detail: request.appovedAt == null
                    ? '-'
                    : DateFormat('dd MMMM y').format(request.appovedAt!),
              ),
              _itemdetail(
                label: 'Rejected at',
                detail: request.appovedAt == null
                    ? '-'
                    : DateFormat('dd MMMM y').format(request.appovedAt!),
              ),
            ],
          )),
    );
  }

  Widget taskDetail({required String jenis, required bool isRequest}) {
    return SizedBox(
      height: 200,
      child: (jenis == "daily" && isRequest)
          ? ListView.builder(
              itemBuilder: (context, index) =>
                  CardDailyRequest(daily: request.dailyReplace![index]),
              itemCount: request.dailyReplace!.length,
            )
          : ListView.builder(
              itemBuilder: (context, index) =>
                  CardDailyRequest(daily: request.dailyExisting![index]),
              itemCount: request.dailyExisting!.length,
            ),
    );
  }

  String _lenght({required String jenis, required bool isRequest}) {
    String value = '-';
    switch (jenis) {
      case 'Daily':
        (isRequest)
            ? value = request.dailyExisting!.length.toString()
            : value = request.dailyReplace!.length.toString();
        break;
      case 'Weekly':
        (isRequest)
            ? value = request.weeklyExisting!.length.toString()
            : value = request.weeklyReplace!.length.toString();
        break;
      default:
        (isRequest)
            ? value = request.monthlyExisting!.length.toString()
            : value = request.monthlyReplace!.length.toString();
    }

    return value + ' Item';
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
        'Detail Request',
        style: blackFontStyle3.copyWith(
          color: white,
        ),
      ),
    );
  }

  _itemdetail({required String label, required String detail}) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: 150,
              child: Text(
                label,
                style: blackFontStyle3.copyWith(color: white, fontSize: 14),
              ),
            ),
            Expanded(
              child: SizedBox(
                child: Text(
                  detail,
                  style: blackFontStyle3.copyWith(color: white, fontSize: 14),
                ),
              ),
            )
          ],
        ),
        const Divider(
          color: white,
          thickness: 1,
        ),
      ],
    );
  }
}
