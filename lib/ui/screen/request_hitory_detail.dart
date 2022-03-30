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
                label: 'Canceled at',
                detail: (request.status! == 'CANCELED') ? 'YES' : '-',
                show: false,
              ),
              _itemdetail(
                label: 'Created at',
                detail: DateFormat('dd MMMM y').format(request.createdAt!),
                show: false,
              ),
              _itemdetail(
                label: 'Line Approve',
                detail: request.approvalName!.namaLengkap!,
                show: false,
              ),
              _itemdetail(
                label: request.status == 'REJECTED'
                    ? 'Rejected By'
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
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            "13285e".toColor()),
                      ),
                      onPressed: () => showDialog<String>(
                          context: context,
                          builder: (context) => _dialogDelete(
                                context,
                                request,
                              )),
                      child: Text('Cancel',
                          style: blackFontStyle3.copyWith(color: white)))
                  : const SizedBox(),
            ],
          )),
    );
  }

  _dialogDelete(
    BuildContext context,
    RequestModel requestModel,
  ) {
    return AlertDialog(
      title: Text(
        'Cancel',
        style: blackFontStyle1,
      ),
      content: Text(
        'Apakah anda yakin membatalkan pengajuan ini ?',
        style: blackFontStyle3,
      ),
      actions: [
        TextButton(
            onPressed: () async =>
                await controller.cancel(id: requestModel.id!).then((value) {
                  snackbar(context, value.value!, value.message!);
                  Get.back();
                  Get.back();
                  controller.getHistory();
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

  List<Widget> _taskRequest(
      {required bool isRequest, required RequestModel requestModel}) {
    List<Widget> value = [];
    switch (requestModel.jenisToDo) {
      case 'Daily':
        isRequest
            ? requestModel.dailyExisting!.asMap().forEach(
                  (key, e) => value.add(
                    CardDailyRequest(daily: e, isCanDelete: false, index: key),
                  ),
                )
            : requestModel.dailyReplace!.asMap().forEach(
                  (key, e) => value.add(
                    CardDailyRequest(daily: e, isCanDelete: false, index: key),
                  ),
                );
        break;
      case 'Weekly':
        isRequest
            ? requestModel.weeklyExisting!.asMap().forEach(
                  (key, e) => value.add(
                    CardWeeklyRequest(
                        weekly: e, isCanDelete: false, index: key),
                  ),
                )
            : requestModel.weeklyReplace!.asMap().forEach(
                  (key, e) => value.add(
                    CardWeeklyRequest(
                        weekly: e, isCanDelete: false, index: key),
                  ),
                );
        break;
      default:
        isRequest
            ? requestModel.monthlyExisting!.asMap().forEach(
                  (key, e) => value.add(
                    CardMonthlyRequest(
                        monthly: e, isCanDelete: false, index: key),
                  ),
                )
            : requestModel.monthlyReplace!.asMap().forEach(
                  (key, e) => value.add(
                    CardMonthlyRequest(
                        monthly: e, isCanDelete: false, index: key),
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
}
