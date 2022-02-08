part of 'controllers.dart';

class HomePageController extends GetxController {
  UserModel? user;
  List<DailyModel>? daily;
  RxBool loading = true.obs;
  StreamSubscription<ConnectivityResult>? result;

  void getUserAndDaily() async {
    var result = await UserServices.getDetailUser();
    var result2 = await DailyService.getDaily(
        DateFormat('y-MM-dd').format(DateTime.now()));
    if (result.value != null) {
      user = result.value!;
    }
    if (result2.value != null) {
      daily = result2.value!;
    }
    loading.toggle();
    update(['user', 'daily']);
  }

  void updateBack() async {
    loading.toggle();
    getUserAndDaily();
    update(['daily']);
  }

  _updateConnectionStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        print('wifi');
        break;
      case ConnectivityResult.mobile:
        print('mobile');
        break;
      default:
        Get.snackbar("ERROR", "Tidak ada akses internet");
    }
  }

  @override
  void onInit() {
    getUserAndDaily();
    result =
        Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
    super.onInit();
  }
}
