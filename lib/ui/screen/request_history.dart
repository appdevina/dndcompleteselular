part of 'screens.dart';

class RequestHistory extends GetView<RequestTaskController> {
  const RequestHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.requests.isEmpty
          ? Center(
              child: Text('Belum ada histori',
                  style: blackFontStyle3.copyWith(color: white)),
            )
          : Container(
              padding: const EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemBuilder: ((context, index) =>
                    ListHistoryRequest(request: controller.requests[index])),
                itemCount: controller.requests.length,
              ),
            ),
    );
  }
}
