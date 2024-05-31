import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whatsapp_poll/controllers/home_controller.dart';
import 'package:whatsapp_poll/views/home_screen.dart';

void main() {
  Get.put(HomeController()); // Initialize the HomeController
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
