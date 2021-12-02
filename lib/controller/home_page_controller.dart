part of 'controllers.dart';

class HomePageController extends GetxController {
  UserModel? user;
  List<DailyModel>? daily;
  RxBool loading = true.obs;

  void getUserAndDaily() async {
    var result = await UserServices.getDetailUser();
    var result2 =
        await DailyService.getDaily(DateFormat('d-M-y').format(DateTime.now()));
    if (result.value != null) {
      user = result.value!;
    }
    if (result2.value != null) {
      daily = result2.value!;
    }
    loading.toggle();
    update(['user', 'daily']);
  }

  @override
  void onInit() {
    getUserAndDaily();
    super.onInit();
  }
}
