import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:todolist_complete/controller/controllers.dart';
import 'package:todolist_complete/ui/screen/screens.dart';
import 'package:supercharged/supercharged.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart'; //dv.easyloading

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Remove this method to stop OneSignal Debugging
  // OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  OneSignal.shared.setAppId("2edc35b0-dfab-42c0-9555-5bda70459f7c");
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });
  Get.put(LoginController());
  runApp(const MyApp());
  //configLoading(); //dv.configload
}

void configLoading() {
  //dv.add.easyloading
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 5000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  //..customAnimation = CustomAnimation();
  //tillhere
}

class MyApp extends GetView<LoginController> {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO LIST COMPLETE',
      theme: ThemeData(
          scaffoldBackgroundColor: "22577E".toColor(),
          appBarTheme: AppBarTheme(backgroundColor: "22577E".toColor())),
      home: GetBuilder<LoginController>(
          id: 'login',
          builder: (_) => (_.loadingLogin)
              ? const LoadingFullScreen()
              : (_.islogin)
                  ? HomePage()
                  : const Login()),
      builder: EasyLoading.init(), //dv.builder.easyloading
    );
  }
}
