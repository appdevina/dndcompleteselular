part of 'controllers.dart';

class ApproveRequestController extends GetxController {
  List<RequestModel> request = [];
  RxBool isShowExt = false.obs;
  RxBool isShowRep = false.obs;

  void getRequest() async => await RequestService.getRequest().then((value) {
        request = value.value!;
        update(['req']);
      });
  String formatNumber(String s) => NumberFormat.decimalPattern('ID').format(
        int.parse(s),
      );

  String getDateRequest({required RequestModel requestModel}) {
    late String result;
    switch (requestModel.jenisToDo) {
      case 'Daily':
        result = DateFormat('dd MMMM y')
            .format(requestModel.dailyExisting![0].date!);
        break;
      case 'Weekly':
        result = requestModel.weeklyExisting![0].week!.toString();
        break;
      default:
        result = DateFormat('MMMM y')
            .format(requestModel.monthlyExisting![0].monthYear!);
    }

    return result;
  }

  Future<ApiReturnValue<bool>> reject({required int id}) async =>
      await RequestService.reject(id: id).then((value) => value);

  Future<ApiReturnValue<bool>> approve({required int id}) async =>
      await RequestService.approve(id: id).then((value) => value);

  @override
  void onInit() {
    getRequest();
    super.onInit();
  }
}
