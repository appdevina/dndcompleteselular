import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:todolist_complete/controller/controllers.dart';
import 'package:todolist_complete/ui/screen/screens.dart';
import 'package:supercharged/supercharged.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Remove this method to stop OneSignal Debugging
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  OneSignal.shared.setAppId("2edc35b0-dfab-42c0-9555-5bda70459f7c");
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });
  Get.put(LoginController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO LIST COMPLETE',
      theme: ThemeData(
          scaffoldBackgroundColor: "22577E".toColor(),
          appBarTheme: AppBarTheme(backgroundColor: "22577E".toColor())),
      home: const Login(),
    );
  }
}
