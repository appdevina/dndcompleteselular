part of 'controllers.dart';

class LoginController extends GetxController {
  TextEditingController? userName, pass;
  bool islogin = false;
  bool loadingLogin = true;
  Rx<bool> loading = false.obs;
  Rx<bool> obsecure = true.obs;

  final GlobalKey key = GlobalKey<FormState>();

  @override
  void onInit() async {
    userName = TextEditingController();
    pass = TextEditingController();
    // await check().then((value) {
    //   if (value) {
    //     loadingLogin = false;
    //     islogin = true;
    //     update();
    //   } else {
    //     loadingLogin = false;
    //     update();
    //   }
    // });
    super.onInit();
  }

  @override
  void onClose() {
    userName!.dispose();
    pass!.dispose();
    super.onClose();
  }

  Future<bool> signIn(String userName, String pass) async {
    if (userName.isEmpty ||
        pass.isEmpty ||
        userName.isBlank! ||
        pass.isBlank!) {
      return false;
    } else {
      ApiReturnValue<UserModel> signIn =
          await UserServices.signIn(userName, pass);
      if (signIn.value != null) {
        return true;
      }
      return false;
    }
  }

  Future<bool> check() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    if (token == null) {
      return false;
    } else {
      ApiReturnValue<bool> login = await UserServices.check(token);
      if (login.value != null) {
        if (login.value!) {
          return true;
        }
      }
      pref.remove('username');
      pref.remove('token');
      return false;
    }
  }

  void open() {
    obsecure.toggle();
    update(['password']);
  }
}
