part of 'controllers.dart';

class MainPageController extends GetxController {
  int index = 0;
  StreamSubscription<ConnectivityResult>? result;

  void changeIndex(int val) {
    index = val;
    update(['page']);
  }
}
