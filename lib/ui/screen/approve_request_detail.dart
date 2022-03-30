part of 'screens.dart';

class ApproveHistoryDetail extends GetView<ApproveRequestController> {
  final RequestModel request;
  const ApproveHistoryDetail({required this.request, Key? key})
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
                label: 'Request by',
                detail: request.user!.namaLengkap!,
                show: false,
              ),
              _itemdetail(
                label: 'Request Name',
                detail: "Request ${request.jenisToDo}",
                show: false,
              ),
              _itemdetail(
                label:
                    "Request ${request.jenisToDo == 'Daily' ? 'Date' : request.jenisToDo == 'Weekly' ? 'Week' : 'Month'}",
                detail: controller.getDateRequest(requestModel: request),
                show: false,
              ),
              _itemdetail(
                label: 'Task existing',
                detail: _lenght(jenis: request.jenisToDo!, isRequest: true),
                show: true,
              ),
              Obx(() => controller.isShowExt.value
                  ? Column(
                      children:
                          _taskRequest(isRequest: true, requestModel: request))
                  : const SizedBox()),
              _itemdetail(
                label: 'Task replace',
                detail: _lenght(jenis: request.jenisToDo!, isRequest: false),
                show: true,
              ),
              Obx(() => controller.isShowRep.value
                  ? Column(
                      children:
                          _taskRequest(isRequest: false, requestModel: request))
                  : const SizedBox()),
              _itemdetail(
                label: 'Canceled',
                detail: (request.status! == 'CANCELED') ? 'YES' : '-',
                show: false,
              ),
              _itemdetail(
                label: 'Created at',
                detail: DateFormat('dd MMMM y').format(request.createdAt!),
                show: false,
              ),
              _itemdetail(
                label: (request.status == 'REJECTED')
                    ? 'Rejected by'
                    : 'Approved by',
                detail: request.approvedName != null
                    ? request.approvedName!.namaLengkap!
                    : '-',
                show: false,
              ),
              _itemdetail(
                label: (request.status == 'REJECTED')
                    ? 'Rejected at'
                    : 'Approved at',
                detail: request.appovedAt != null
                    ? DateFormat('dd MMMM y').format(request.appovedAt!)
                    : '-',
                show: false,
              ),
              (request.status == 'PENDING')
                  ? ElevatedButton(
                      onPressed: () => showDialog<String>(
                          context: context,
                          builder: (context) =>
                              _dialogDelete(context, request, true)),
                      child: Text('Approve',
                          style: blackFontStyle3.copyWith(color: white)))
                  : const SizedBox(),
              (request.status == 'PENDING')
                  ? ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            "13285e".toColor()),
                      ),
                      onPressed: () => showDialog<String>(
                          context: context,
                          builder: (context) =>
                              _dialogDelete(context, request, false)),
                      child: Text('Reject',
                          style: blackFontStyle3.copyWith(color: white)))
                  : const SizedBox(),
            ],
          )),
    );
  }

  List<Widget> _taskRequest(
      {required bool isRequest, required RequestModel requestModel}) {
    List<Widget> value = [];
    switch (requestModel.jenisToDo) {
      case 'Daily':
        isRequest
            ? requestModel.dailyExisting!.asMap().forEach(
                  (key, e) => value.add(
                    CardDailyApprove(daily: e, index: key),
                  ),
                )
            : requestModel.dailyReplace!.asMap().forEach(
                  (key, e) => value.add(
                    CardDailyApprove(daily: e, index: key),
                  ),
                );
        break;
      case 'Weekly':
        isRequest
            ? requestModel.weeklyExisting!.asMap().forEach(
                  (key, e) => value.add(
                    CardWeeklyApprove(weekly: e, index: key),
                  ),
                )
            : requestModel.weeklyReplace!.asMap().forEach(
                  (key, e) => value.add(
                    CardWeeklyApprove(weekly: e, index: key),
                  ),
                );
        break;
      default:
        isRequest
            ? requestModel.monthlyExisting!.asMap().forEach(
                  (key, e) => value.add(
                    CardMonthlyApprove(monthly: e, index: key),
                  ),
                )
            : requestModel.monthlyReplace!.asMap().forEach(
                  (key, e) => value.add(
                    CardMonthlyApprove(monthly: e, index: key),
                  ),
                );
    }
    return value;
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

  _itemdetail(
      {required String label, required String detail, required bool show}) {
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
            ),
            show
                ? IconButton(
                    onPressed: () => label == 'Task existing'
                        ? controller.isShowExt.toggle()
                        : controller.isShowRep.toggle(),
                    icon: Obx(() => Icon(
                          label == 'Task existing' && controller.isShowExt.value
                              ? MdiIcons.minusBox
                              : controller.isShowRep.value
                                  ? MdiIcons.minusBox
                                  : MdiIcons.plusBox,
                          size: 20,
                          color: white,
                        )))
                : const SizedBox(),
          ],
        ),
        const Divider(
          color: white,
          thickness: 1,
        ),
      ],
    );
  }

  _dialogDelete(
      BuildContext context, RequestModel requestModel, bool isApprove) {
    return AlertDialog(
      title: Text(
        isApprove ? 'Approved' : 'Rejected',
        style: blackFontStyle1,
      ),
      content: Text(
        isApprove
            ? textDialog(requestModel)
            : 'Apakah anda yakin menolak pengajuan ini ?',
        style: blackFontStyle3,
      ),
      actions: [
        TextButton(
            onPressed: () async => isApprove
                ? await controller.approve(id: requestModel.id!).then((value) {
                    snackbar(context, value.value!, value.message!);
                    Get.back();
                    Get.back();
                    controller.getRequest();
                  })
                : await controller.reject(id: requestModel.id!).then((value) {
                    snackbar(context, value.value!, value.message!);
                    Get.back();
                    Get.back();
                    controller.getRequest();
                  }),
            child: Text(
              "YES",
              style: blackFontStyle3.copyWith(color: Colors.green[400]),
            )),
        TextButton(
            onPressed: () => Get.back(),
            child: Text(
              "NO",
              style: blackFontStyle3.copyWith(color: Colors.red[400]),
            )),
      ],
    );
  }

  String textDialog(RequestModel req) {
    DateTime now = DateTime.now();
    if (req.jenisToDo == 'Daily' &&
        req.dailyExisting![0].date!
            .isBefore(DateTime(now.year, now.month, now.day))) {
      return 'Jika anda menyetujui pengajuan ini maka todolist akan dianggap close !!!';
    }
    return "Apakah sudah yakin menyetujui pengajuan ini ?";
  }
}
