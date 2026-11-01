import 'dart:io';
import 'package:centro/core/classes/firebase_api.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/utils/responsive/responsive.dart';
import 'package:centro/features/appointment/ui/appointments_screen.dart';
import 'package:centro/features/category/ui/category_screen.dart';
import 'package:centro/features/home/ui/home_screen.dart';
import 'package:centro/features/profile/ui/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:centro/core/constants/app_images.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class NavBarScreen extends StatefulWidget {

  final int pageIndex;

  const NavBarScreen({super.key, required this.pageIndex});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late PersistentTabController _controller;
  final NavBarStyle _navBarStyle = NavBarStyle.style12;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: widget.pageIndex);
    FirebaseApi.instance.refreshNotificationsStatus();

    FirebaseApi.instance.onNotificationChange = () {
      FirebaseApi.instance.refreshNotificationsStatus();
    };
  }

  List<Widget> _buildScreens() => [
    HomeScreen(),
    CategoryScreen(),
    AppointmentsScreen(),
    ProfileScreen(),
  ];


  List<PersistentBottomNavBarItem> _navBarsItems() => [
    PersistentBottomNavBarItem(
        icon: navIcon(svg: home, iosIcon: CupertinoIcons.house_fill, active: true),
        inactiveIcon: navIcon(svg: home, iosIcon: CupertinoIcons.house, active: false),
        title: "Home",
        activeColorPrimary: AppColors.primaryColor
    ),
    PersistentBottomNavBarItem(
        icon: navIcon(svg: category, iosIcon: CupertinoIcons.square_grid_2x2_fill, active: true, width: 30.w),
        inactiveIcon: navIcon(svg: category, iosIcon: CupertinoIcons.square_grid_2x2, active: false, width: 30.w),
        title: "Category",
        activeColorPrimary: AppColors.primaryColor
    ),
    PersistentBottomNavBarItem(
        icon: navIcon(svg: appointment, iosIcon: CupertinoIcons.calendar, active: true),
        inactiveIcon: navIcon(svg: appointment, iosIcon: CupertinoIcons.calendar, active: false),
        title: "Appointment",
        activeColorPrimary: AppColors.primaryColor
    ),
    PersistentBottomNavBarItem(
        icon: navIcon(svg: user, iosIcon: CupertinoIcons.person_fill, active: true),
        inactiveIcon: navIcon(svg: user, iosIcon: CupertinoIcons.person, active: false),
        title: "Profile",
        activeColorPrimary: AppColors.primaryColor
    ),
  ];

  // iOS uses Cupertino icons; other platforms keep the SVG assets.
  Widget navIcon({required String svg, required IconData iosIcon, required bool active, double? width}) {
    final color = active ? AppColors.primaryColor : AppColors.mediumGrayColor;
    if (Platform.isIOS) return Icon(iosIcon, size: 24.w, color: color);
    return SvgPicture.asset(svg, width: width ?? 24.w, color: color);
  }

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);
    return Scaffold(
      key: _scaffoldKey,
      body: PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: false,
      stateManagement: true,
      hideNavigationBarWhenKeyboardAppears: true,
      popBehaviorOnSelectedNavBarItemPress: PopBehavior.once,
      padding: EdgeInsets.symmetric(vertical: isTablet ? 0 : 5.h),
      backgroundColor: AppColors.whiteColor,
      decoration: NavBarDecoration(
        colorBehindNavBar: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withOpacity(0.15),
            blurRadius: 48,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      confineToSafeArea: true,
        navBarHeight: isTablet ? 85 : kBottomNavigationBarHeight,
        navBarStyle: _navBarStyle,
      )
    );
  }
}
