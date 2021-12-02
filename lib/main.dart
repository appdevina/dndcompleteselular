// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolist_complete/controller/controllers.dart';
import 'package:todolist_complete/ui/screen/screens.dart';

void main() {
  Get.put(LoginController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TODO LIST COMPLETE',
      home: MainPage(),
    );
  }
}
