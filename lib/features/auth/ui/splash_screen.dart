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
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _navigateToNextScreen();
      }
    });
  }

  void _navigateToNextScreen() {
    final token = AppStorage.getData(key: kAccessToken);

    if (token == null) {
      Navigation.pushReplacement(SignInScreen());
      return;
    }

    if (JwtDecoder.isExpired(token)) {
      AppStorage.removeData(key: kAccessToken);
      AppStorage.removeData(key: kAccessTokenExpirationDate);
      Navigation.pushReplacement(SignInScreen());
      return;
    }
    Navigation.pushReplacement(NavBarScreen(pageIndex: 0));
    FirebaseApi.instance.appIsReady();
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
      body: Container(
        height: 1.sh,
        width: 1.sw,
        color: Color(0xff01bac8),
        child: Lottie.asset(
          splash,
          controller: _controller,
          animate: false,
          onLoaded: (composition) {
            _controller..duration = composition.duration..forward(from: 0.0);
          },
        ),
      ),
    );
  }
}