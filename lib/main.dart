import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist_complete/controller/controllers.dart';
import 'package:todolist_complete/ui/screen/screens.dart';
import 'package:supercharged/supercharged.dart';

void main() {
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
      home: HomePage(),
    );
  }
}
