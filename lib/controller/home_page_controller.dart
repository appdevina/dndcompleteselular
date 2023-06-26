part of 'controllers.dart';

class HomePageController extends GetxController {
  late UserModel user;
  List<DailyModel>? daily;
  RxBool loading = true.obs;
  File? foto;
  StreamSubscription<ConnectivityResult>? result;

  Future<UserModel?> getUser() async {
    var result = await UserServices.getDetailUser();

    if (result.value == null) {
      throw Exception('Failed to fetch user data');
    }
    user = result.value!;
    return user;
  }

  Future<bool> getUserAndDaily() async {
    var result = await UserServices.getDetailUser();
    var result2 = await DailyService.getDaily(
        DateFormat('y-MM-dd').format(DateTime.now()));
    if (result.value == null || result2.value == null) {
      return false;
    }
    user = result.value!;
    daily = result2.value!;
    update(['user', 'daily']);
    return true;
  }

  void updateBack() async {
    getUserAndDaily();
    update(['daily']);
    loading.toggle();
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

  Future<File?> submitImage() async {
    final _picker = ImagePicker();

    String _time = DateTime.now().toString();

    XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile == null) {
      Get.back();
      return null;
    }
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    final title = _time;
    final bytes = await pickedFile.readAsBytes();
    img.Image? image = img.decodeImage(bytes);
    img.Image? resizeimg = img.copyResize(image!, width: 720, height: 1280);
    foto = File('$path/$title.jpg')..writeAsBytesSync(img.encodeJpg(resizeimg));
    return foto;
  }

  Future<ApiReturnValue<bool>> changeprofile(File image) async =>
      await UserServices.profilepicture(image).then((value) => value);

  Future<ApiReturnValue<bool>> logout() async =>
      await UserServices.logout().then((value) => value);

  @override
  void onInit() async {
    await getUserAndDaily().then((value) => loading.toggle());
    result =
        Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);

    await getUser();
    super.onInit();
  }
}
