import 'package:centro/features/auth/ui/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:centro/core/clasess/app_storage.dart';
import 'dart:async';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_images.dart';
import 'package:centro/core/constants/end_point.dart';
import 'package:centro/core/utils/Navigation/Navigation.dart';

class SplashScreen extends StatefulWidget {

  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () async {
      Navigation.pushReplacement(SignInScreen());
      // if(AppStorage.getData(key: kAccessToken) != null) {
      //   // todo go to home page
      // } else {
      //   //  todo go to login page
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: Image.asset(logo),
      ),
    );
  }
}
