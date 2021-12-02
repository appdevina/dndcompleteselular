part of 'controllers.dart';

class MainPageController extends GetxController {
  int index = 0;
  StreamSubscription<ConnectivityResult>? result;

  void changeIndex(int val) {
    index = val;
    update(['page']);
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
        print('no connection');
    }
  }

  @override
  void onInit() {
    result =
        Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
    super.onInit();
  }
}
