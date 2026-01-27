import 'package:centro/core/constants/app_colors.dart';
import 'package:centro/core/constants/app_images.dart';
import 'package:centro/core/constants/app_styles.dart';
import 'package:centro/core/utils/Navigation/Navigation.dart';
import 'package:centro/features/favorite/ui/favorite_screen.dart';
import 'package:centro/features/notification/ui/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomHeader extends StatelessWidget implements PreferredSizeWidget {

  final String? title;
  final bool isNavBar;
  final Widget? leading;

  const CustomHeader({super.key, this.title, required this.isNavBar,this.leading});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: EdgeInsets.only(top: 5.h),
        child: Text(title!, style: AppTheme.bodyLarge.copyWith(fontSize: 22.sp)),
      ),
      centerTitle: true,
      elevation: 1,
      toolbarHeight: 200.h,
      surfaceTintColor: Colors.transparent,
      shadowColor: AppColors.blackColor.withOpacity(0.5),
      backgroundColor: AppColors.whiteColor,
      leadingWidth: isNavBar == true ? 1.sw : null,
      leading: isNavBar ? Row(
        children: [
          Image.asset(logo,width: 150.w),
        ],
      ) :
      leading ?? IconButton(
        icon: Icon(Icons.arrow_back),
        color: AppColors.blackColor,
        onPressed: () {
          Navigation.pop();
        },
      ),
      actions: !isNavBar ? [] : [
        IconButton(
          icon: SvgPicture.asset(notifications,width: 23.w),
          color: AppColors.blackColor,
          onPressed: () => Navigation.push(NotificationScreen()),
        ),
        IconButton(
          icon: Icon(Icons.favorite_border),
          color: AppColors.blackColor,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          onPressed: () => Navigation.push(FavoriteScreen()),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size(1.sw, 50);
}

