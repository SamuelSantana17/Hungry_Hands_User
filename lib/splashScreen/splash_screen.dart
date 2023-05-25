import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hungry_hands/authentication/login.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 9), () {
      Get.to(const LoginScreen());
    });
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/image_processing20191127-32388-1nvvybx.gif"),
          ),
        ),
      ),
    );
  }
}
