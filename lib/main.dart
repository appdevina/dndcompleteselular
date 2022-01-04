import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist_complete/controller/controllers.dart';
import 'package:todolist_complete/ui/screen/screens.dart';

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
      home: HomePage(),
    );
  }
}
