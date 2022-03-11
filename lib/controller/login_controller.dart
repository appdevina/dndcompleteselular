part of 'controllers.dart';

class LoginController extends GetxController {
  TextEditingController? userName, pass;
  bool islogin = false;
  bool loadingLogin = true;
  Rx<bool> loading = false.obs;
  Rx<bool> obsecure = true.obs;

  final GlobalKey key = GlobalKey<FormState>();

  Future<ApiReturnValue<bool>> signIn(String userName, String pass) async {
    if (userName.isEmpty ||
        pass.isEmpty ||
        userName.isBlank! ||
        pass.isBlank!) {
      return ApiReturnValue(
          value: false, message: 'Lengkapi username dan password');
    } else {
      ApiReturnValue<bool> signIn = await UserServices.signIn(userName, pass);
      return signIn;
    }
  }

  Future<ApiReturnValue<bool>> check() async => await UserServices.check();

  @override
  void onInit() async {
    userName = TextEditingController();
    pass = TextEditingController();
    await check().then((value) {
      if (value.value!) {
        loadingLogin = false;
        islogin = true;
        update(['login']);
      } else {
        loadingLogin = false;
        update(['login']);
      }
    });
    super.onInit();
  }

  @override
  void onClose() {
    userName!.dispose();
    pass!.dispose();
    super.onClose();
  }
}
