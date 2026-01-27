import 'dart:async';
import 'package:centro/core/classes/app_storage.dart';
import 'package:centro/core/classes/firebase_api.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_images.dart';
import 'package:centro/core/constants/end_point.dart';
import 'package:centro/core/utils/Navigation/Navigation.dart';
import 'package:centro/features/auth/ui/sign_in_screen.dart';
import 'package:centro/features/nav_bar/ui/nav_bar_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    final curved = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _scaleAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(curved);
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(curved);
    _rotationAnimation = Tween<double>(begin: 0.0, end: 2 * 3.1416).animate(curved);

    _controller.forward();

    Timer(const Duration(seconds: 3), () async {
      if(AppStorage.getData(key: kAccessToken) != null) {
        Navigation.pushReplacement(NavBarScreen(pageIndex: 0));
      } else {
        Navigation.pushReplacement(SignInScreen());
      }
      FirebaseApi().appIsReady();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _fadeAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Transform.rotate(
                  angle: _rotationAnimation.value,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Image.asset(logo),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}