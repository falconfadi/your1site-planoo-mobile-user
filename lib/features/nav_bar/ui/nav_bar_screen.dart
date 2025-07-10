import 'package:centro/core/clasess/Keys.dart';
import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/features/home/ui/home_screen.dart';
import 'package:centro/features/profile/ui/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:centro/core/constants/app_images.dart';

class NavBarScreen extends StatefulWidget {

  int pageIndex;
  NavBarScreen({required this.pageIndex});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {

  final PageController pageController = PageController();

  List<Widget> screens = [
    HomeScreen(),
    Container(color: Colors.yellow),
    Container(color: Colors.blue),
    ProfileScreen(),
  ];

  void setPage(int pageIndex) {
    widget.pageIndex = pageIndex;
    pageController.animateToPage(pageIndex, duration: const Duration(milliseconds: 500), curve: Curves.linear);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Keys.scaffoldKey,
      backgroundColor: AppColors.whiteColor,
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r)
        ),
        child: BottomAppBar(
          height: 60,
          color: AppColors.primaryColor,
          clipBehavior: Clip.antiAlias,
          shape: const CircularNotchedRectangle(),
          child: Row(children: [
            bottomNavItem(icon: widget.pageIndex == 0 ? filledHome : home, onTap: () => setPage(0)),
            bottomNavItem(icon: widget.pageIndex == 1 ? filledAppointment : appointment, onTap: () => setPage(1)),
            bottomNavItem(icon: widget.pageIndex == 2 ? filledNotifications : notifications, onTap: () => setPage(2)),
            bottomNavItem(icon: widget.pageIndex == 3 ? filledProfile : profile, onTap: () => setPage(3)),
          ]),
        ),
      ),
      body: PageView.builder(
        controller: pageController,
        itemCount: screens.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return screens[index];
        },
      ),
    );
  }

  Widget bottomNavItem({required String icon,required VoidCallback onTap}) {
    return Expanded(
      child: IconButton(
        icon: SvgPicture.asset(icon,width: 24.w,height: 24.w),
        onPressed: onTap,
      ),
    );
  }

}
