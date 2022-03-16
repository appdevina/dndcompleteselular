part of 'widgets.dart';

class ListHistoryApprove extends GetView<ApproveRequestController> {
  final RequestModel request;
  const ListHistoryApprove({required this.request, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => ApproveHistoryDetail(request: request),
          transition: Transition.cupertino),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 0.2, color: greyColor),
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 10,
        child: Container(
          alignment: Alignment.center,
          height: 60,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                height: 30,
                width: 30,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/request.png',
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Request Date : ${DateFormat('dd MMM y').format(request.createdAt!)} || Request : ${request.jenisToDo}",
                      style: blackFontStyle2.copyWith(
                          wordSpacing: 1,
                          fontSize: 8,
                          color: greyColor,
                          fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "${request.user!.namaLengkap}",
                      style: blackFontStyle2.copyWith(
                        wordSpacing: 1,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              (request.status == 'PENDING')
                  ? const SizedBox()
                  : Container(
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        _getIcon(request),
                        color: _getColor(request),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Color? _getColor(RequestModel req) {
    return req.status == "APPROVED"
        ? Colors.green
        : req.status == 'REJECTED'
            ? Colors.red
            : Colors.yellow[200];
  }

  IconData? _getIcon(RequestModel req) {
    return req.status == "APPROVED"
        ? MdiIcons.check
        : req.status == 'REJECTED'
            ? MdiIcons.close
            : MdiIcons.accountConvert;
  }
}
