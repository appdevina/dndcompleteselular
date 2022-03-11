part of 'widgets.dart';

class ListHistoryRequest extends GetView<RequestTaskController> {
  final RequestModel request;
  const ListHistoryRequest({required this.request, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => RequestHistoryDetail(request: request),
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
                      "Request Date : ${DateFormat('dd MMM y').format(request.createdAt!)} || Status : ${request.status!} ",
                      style: blackFontStyle2.copyWith(
                          wordSpacing: 1,
                          fontSize: 8,
                          color: greyColor,
                          fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Request Task : ${request.jenisToDo!}",
                      style: blackFontStyle2.copyWith(
                        wordSpacing: 1,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
